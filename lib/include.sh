#!/bin/sh

#_DEBUG=0

if [ -z "$_BRANCH" ]
then
    _BRANCH=$(gcb)
fi

if [ -z "$_PROJECT" ]
then
    _PROJECT=$(basename $(pwd))
fi

CSEARCHINDEX=~/.csearch/$_PROJECT/$_BRANCH
mkdir -p $(dirname $CSEARCHINDEX)

export CSEARCHINDEX

if [ -n "$_DEBUG" ]
then
    echo $CSEARCHINDEX
    echo $_FUNCTION
    set -x
fi

CSEARCHINDEX="$CSEARCHINDEX" $_FUNCTION 2>/dev/null