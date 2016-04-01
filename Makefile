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

install-data: videos
	for i in DOCUMENTS PICTURES MUSIC VIDEOS; do cp -r $$i/* "`xdg-user-dir $$i`"/ ; done

install: install-data
	su -c "install -m0644 user-icons/* /var/lib/AccountsService/icons/"
