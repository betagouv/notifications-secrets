reencrypt:
	env PASSWORD_STORE_DIR=$(pwd) $(shell cat .gpg-id | xargs pass init)
