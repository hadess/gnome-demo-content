#!/bin/sh

check()
{
	which $1 > /dev/null 2>&1 || (echo "*** $1 not found" ; exit 1)
}

check_gst()
{
	if test x$2 != x ; then
		gst-inspect-1.0 $1 > /dev/null 2>&1 || gst-inspect-1.0 $2 || (echo "*** GStreamer plugins $1 and $2 not found" ; exit 1)
	else
		gst-inspect-1.0 $1 > /dev/null 2>&1 || (echo "*** GStreamer plugin $1 not found" ; exit 1)
	fi
}

check nm-online
check youtube-dl
check ffmpeg
check git-lfs
check_gst mad mpg123
