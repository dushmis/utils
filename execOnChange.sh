#!/bin/bash
#
# Usage:
#     execOnChange.sh "some command with params" "-iname ..."
#
# Anything that matches the find filespec changes? Run the cmd.
# (i.e. instant make)
#
if [ $# -ne 2 ] ; then 
    echo 'Usage: execOnChange.sh "some command with params" "-iname ..."'
    exit 1
fi
command="$1"
shift
fileSpec="$@"
sentinel=/tmp/t.$$
 
touch -t197001010000 $sentinel
while :
do
    files=$(find . -newer $sentinel -a '(' $fileSpec ')')
    if [ $? != 0 ]; then
        exit 1;
    fi
    if [ "$files" != "" ]; then
        $command
        touch $sentinel
    fi
    sleep 0.1
done
