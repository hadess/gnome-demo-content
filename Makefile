.NOTPARALLEL:

VERSION = 3.20
LOCALE = fr

all: tool-check videos

YOUTUBE_URL = https://www.youtube.com/watch?v=JU2f_jkPRq4
videos: VIDEOS/GNOME-$(VERSION).webm VIDEOS/GNOME-$(VERSION).srt

VIDEOS/GNOME-$(VERSION).webm:
	@echo "Downloading release video and subtitles"
	@youtube-dl -o VIDEOS/GNOME-$(VERSION).'%(ext)s' -f 248 --all-subs --convert-subs srt $(YOUTUBE_URL)

VIDEOS/GNOME-$(VERSION).srt: VIDEOS/GNOME-$(VERSION).webm
	@echo "Creating link for $(LOCALE) subtitle"
	@ln -s -r VIDEOS/GNOME-$(VERSION).$(LOCALE).srt VIDEOS/GNOME-$(VERSION).srt

tool-check: check-tools.sh
	@echo "Checking for tools"
	@./check-tools.sh
	@echo "Checking for Internet access"
	@nm-online || (echo "*** Internet connection required" ; exit 1)

user-check: check-user.sh
	@echo "Checking GNOME user, please enter sudo password if necessary"
	@sudo ./check-user.sh
	@set -e ; if test "`id -u gnome 2> /dev/null `" != "`id -u 2> /dev/null`" ; then echo "*** This script should only run as the GNOME user" ; exit 1 ; fi

install-data: videos
	for i in DOCUMENTS PICTURES MUSIC VIDEOS; do cp -r $$i/* "`xdg-user-dir $$i`"/ ; done

install: user-check install-data
