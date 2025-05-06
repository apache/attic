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
# Performs any extra setup - e.g. downloading data files
#

module Setup
  require 'uri'
  require 'net/http'

# Hash: key: target file, value: source
  CACHES = {
    '_data/git-repositories.json' => 'https://gitbox.apache.org/repositories.json',
    '_data/committee-retired.json' => 'https://whimsy.apache.org/public/committee-retired.json',    
  }
  
  AGE = 3600 # seconds => 1 hour
  
  Jekyll::Hooks.register :site, :after_init do |site, _payload|
    CACHES.each do |data_file, data_src|
      begin
        mtime = File.mtime(data_file)
      rescue Errno::ENOENT
        mtime = Time.gm(0)
      end
      if Time.now - mtime > AGE
        puts "Setup: #{data_file} is old or missing"
        uri = URI.parse(data_src)
        response = Net::HTTP.get_response uri
        File.write(data_file, response.body)
      else
        puts "Setup: #{data_file} is recent"
      end
    end
  end
  # Massage page to insert acevent class
  Jekyll::Hooks.register :pages, :post_render do |page|
    if page.relative_path =~ %r{\.(md|html)$}
      page.output.gsub!(
        %r{<a href="http://localhost/#acevent" class="nav-list-link external"},
        '<a class="nav-list-link acevent" data-format="square"'
      )
    end
  end
end