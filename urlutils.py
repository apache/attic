#!/usr/bin/env python3

"""
    Utility URL methods
"""

import hashlib
import sys
import errno
import time
import yaml
import json
from os import environ
from os.path import getmtime, join
from urllib.request import urlopen, Request
from urllib.error import HTTPError

MAXAGE=int(environ.get('CACHE_AGE', '600'))  # 5 min in seconds
CACHE=environ.get('CACHE')
DEBUG=environ.get('CACHE_DEBUG')

def isFileStale(filename):
    """ is file older than max age (default 5 minutes) """
    try:
        t = getmtime(filename)
    except OSError as e:
        if not e.errno == errno.ENOENT:
            raise e
        return True
    diff = time.time() - t
    return diff > MAXAGE

def hashurl(url):
    """ create hash from url """
    return hashlib.sha224(url.encode()).hexdigest()

def geturl(url):
    """ Get url contents -- no caching """
    req = Request(url)
    resp = urlopen(req)
    return resp.read()

def urlexists(url):
    """ Does URL exist? """
    req = Request(url)
    try:
        urlopen(req)
        return True
    except HTTPError:
        return False

def urlcache(url):
    """ Get url contents -- optional caching """
    if CACHE:
        # basename seems to work OK with URLs
        cache = join(CACHE, hashurl(url)+".tmp")
        if isFileStale(cache):
            if DEBUG:
                print("Caching %s" % url, file=sys.stderr)
            data = geturl(url)
            with open(cache,'wb') as w:
                w.write(data)
            return data
        else:
            if DEBUG:
                print("Using cache for %s" % url, file=sys.stderr)
        with open(cache,'r') as r:
            return r.read()
    else:
        if DEBUG:
            print("Fetching %s" % url, file=sys.stderr)
        return geturl(url)

def loadyaml(url):
    return yaml.safe_load(urlcache(url))

def loadjson(url):
    return json.loads(urlcache(url))

# Test code
if __name__ == '__main__':
    for arg in sys.argv[1:]:
        print(arg)
        print(loadyaml(arg))
