#!/bin/sh

check()
{
	which $1 > /dev/null 2>&1 || (echo "*** $1 not found" ; exit 1)
}

check_gst()
{
	gst-inspect-1.0 $1 > /dev/null 2>&1 || (echo "*** GStreamer plugin $1 not found" ; exit 1)
}

check nm-online
check youtube-dl
check ffmpeg
check git-lfs
check_gst mad
