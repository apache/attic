#!/usr/bin/env ruby

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#--------------------------------------------------------
#
# Script to create _data/projects YAML file for one or more project ids
#
# Usage:
# ruby retire.rb <list of project ids>
# e.g.
# ruby retire.rb gora mxnet
# This will create/update _data/projects/pid.yaml
# Review this and commit

# TODO:
# - does not check for Bugzilla issues
# - does not check for GitHub issues
# - Jira: juddi - does not find scout (is there an alias documented somewhere?)
# - Cwiki: did not find ODE2
# - aliases: does not check for previous names

# Input:
# - https://whimsy.apache.org/public/committee-retired.json
# - https://lists.apache.org/api/preferences.lua
# - https://cwiki.apache.org/confluence/rest/api/space/
# - https://issues.apache.org/jira/rest/api/2/project
# - https://svn.apache.org/repos/asf/
# - https://gitbox.apache.org/repositories.json
# - https://svn.apache.org/repos/asf/infrastructure/site/trunk/content/foundation/records/minutes (temporary)
#
# Output:
# _data/projects/pid.yaml

require 'yaml'
require 'net/http'
require 'uri'

# Sources
CTTEE_RETIRED = 'https://whimsy.apache.org/public/committee-retired.json'
CWIKI_INFO = 'https://cwiki.apache.org/confluence/rest/api/space/?type=global&limit=1000'
# Note: Two Wikis are lower-case: labs, usergrid. Upper case does seem to be equivalent for display.
JIRA = 'https://issues.apache.org/jira/rest/api/2/project'
SVNURL = 'https://svn.apache.org/repos/asf/'
GITREPOS = 'https://gitbox.apache.org/repositories.json'
LISTSAO = 'https://lists.apache.org/api/preferences.lua'
MINUTES = 'https://svn.apache.org/repos/asf/infrastructure/site/trunk/content/foundation/records/minutes/'

def get_url(url)
  uri = URI.parse(url)
  Net::HTTP.start(uri.host, uri.port,
    open_timeout: 5, read_timeout: 5, ssl_timeout: 5,
    use_ssl: uri.scheme == 'https') do |http|
    return http.request Net::HTTP::Get.new uri.request_uri
  end
end

def get_json(url, key=nil)
  begin
    response = get_url(url)
    json = YAML.safe_load(response.body)
    if key
      return json[key]
    else
      return json
    end
  rescue Net::OpenTimeout => to
    puts to
    return nil
  end
end

def has_svn(pid)
  url = SVNURL + pid + '/trunk' # ignore site-only repos
  res = get_url(url)
  return res.code == 200
end

# "key": "GMOxDOC21es",
# "name": " Apache Geronimo v2.1 - ES  ",
def find_wikis(pid)
  names = []
  WIKIS.each do |a|
    key = a['key']
    names << key if key == pid or key.start_with?(pid) or a['name'].downcase =~ /\b#{pid}\b/
  end
  names.sort
end

# Allow for Apache prefix and (Retired) suffixes etc.
# returns first word, downcased
# TODO: what about subnames?
def canon_name(name)
  name.downcase.sub('apache','').gsub('(retired)', '').sub('(old)', '').strip.split.first
end

def get_jiras(pid)
  jiras = []
  JIRAS.each do |project|
    key = project['key']
    if pid == key.downcase
      jiras << key
    elsif pid == canon_name(project['name']) # Allow
      jiras << key
    else
      cat = project['projectCategory']
      if cat
        catname = cat['name']
        jiras << key if pid == catname.downcase
      end
    end
  end
  return jiras
end

def main()
  retirees = get_json(CTTEE_RETIRED)['retired']
  not_retired = ARGV - retirees.keys
  if not_retired.size > 0
    puts "The following projects are not recorded as retired: #{not_retired}"
  end

  #  TODO filter out done ones
  # process valid projects
  (ARGV - not_retired).each do |pid|
    puts "Processing #{pid}"
    meta = retirees[pid]
    retired_date = Date.parse(meta['retired_date'])
    display_name = meta['display_name']
    description = meta['description'].chomp('.') # we add a full-stop later
    # Allow for desc. starting with a or an or a vowel
    if description =~ %r{^[aA]n? } # starts with A or an?
      description.sub!(/^A/, 'a') # downcase
      sep = ' was '
    elsif description =~ /^[AEIOUaeiou]/ # Vowel
      sep = ' was an '
    else
      sep = ' was '
    end
    project_description = display_name + sep + description + '.'
    data = {
      retirement_date: retired_date,
      attic_issue: 'ATTIC-nnn',
      attic_date: nil,
      attic_banner: true,
      # revived_date: nil,
      project_name: display_name,
      # project_longname: Where to find this?,
      project_description: project_description,
      board_resolution: true,
      board_reports: true,   
      downloads: true, # check if there are any?
    }
    data.delete(:project_name) if data[:project_name] == pid.capitalize # Not needed
    if has_svn pid
      data[:source_repositories] ||= []
      data[:source_repositories] << 
      {
        type: 'Subversion'
      }
    end

    has_git = get_json(GITREPOS)['projects'][pid]
    if has_git
      data[:source_repositories] ||= []
      data[:source_repositories] << 
      {
        type: 'Git'
      }
    end

    mlists = get_json(LISTSAO)['lists']["#{pid}.apache.org"]&.keys
    if mlists
      # ensure dev sorts first
      data[:mailing_lists] = mlists.sort_by {|l| l == 'dev' ? 'aaa' : l} if mlists.size > 0
    else
      $stderr.puts "No mailing lists found for #{pid}"
    end
    
    jiras = get_jiras pid
    if jiras.size > 0
      data[:issue_trackers] ||= []
      tracker =
      {
        type: 'JIRA'
      }
      tracker[:keys] = jiras.sort if jiras.size > 1 or jiras.first != pid.upcase
      data[:issue_trackers] << tracker
    end

    # TODO: Allow for Bugzilla and GitHub

    wikis = find_wikis pid
    if wikis.size > 0
      data[:wiki] = {
        type: 'CWIKI'
      }
      data[:wiki][:keys] = wikis if wikis.size > 1 or wikis.first != pid.upcase
    end

    dir = ENV['OUTPUT'] || '_data/projects' # Allow override for testing
    output = File.join(dir, "#{pid}.yaml")
    puts "Creating #{output}"
    content = YAML.safe_dump(data, permitted_classes: [Date], stringify_names: true, indentation: 4)
    # Massage the output to look more like existing files
    tmp = content.sub('project_description: ', "project_description: >-\n    ")
    File.write(output, tmp)
  end
end

if __FILE__ == $0
  JIRAS = get_json(JIRA)
  WIKIS = get_json(CWIKI_INFO, 'results')
  main
end
