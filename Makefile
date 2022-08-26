reencrypt:
	env PASSWORD_STORE_DIR=$(shell pwd)/secrets cat .gpg-id | xargs pass init
