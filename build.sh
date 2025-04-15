#!/usr/bin/env bash

# Script to build the Attic site from xdocs/ sources to html output
# default output is in docs/, override with -Ddocs.dest=path

ant -Danakia.check.date=false "$@"
