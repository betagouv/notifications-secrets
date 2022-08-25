reencrypt:
	env PASSWORD_STORE_DIR=. $(shell cat .gpg-id | xargs pass init)
