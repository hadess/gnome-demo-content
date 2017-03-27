#!/bin/sh

check()
{
	which $1 > /dev/null 2>&1 || (echo "*** $1 not found" ; exit 1)
}

check youtube-dl
check ffmpeg
