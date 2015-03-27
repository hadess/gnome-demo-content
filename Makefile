all: install

install-data:
	for i in DOCUMENTS PICTURES MUSIC VIDEOS; do cp -r $$i/* "`xdg-user-dir $$i`"/ ; done

install: install-data
	su -c "install -m0644 user-icons/* /var/lib/AccountsService/icons/"
