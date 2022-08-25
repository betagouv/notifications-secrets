reencrypt:
	env PASSWORD_STORE_DIR=$(shell pwd) cat .gpg-id | xargs pass init
