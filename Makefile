all: install

install-data:
	for i in DOCUMENTS PICTURES MUSIC VIDEOS; do cp $$i/* "`xdg-user-dir $$i`"/ ; done

install: install-data
	sudo install -m0644 user-icons/* /var/lib/AccountsService/icons/
