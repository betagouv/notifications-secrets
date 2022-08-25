# Notifications secrets

Les différents secrets qui animent l'infrastructure de Notifications
sont encryptés dans cette forge, au travers du [gestionnaire de mot de
pass "pass"](https://www.passwordstore.org/).

Pour lire ou ajouter des secrets, il faut faire parti du trousseau de
clés GnuPG indiqué dans le fichier `.gpg-id`.

Lorsque quelqu'un rejoint ou quitte l'équipe il faut réeencoder tous les
secrets.

## Accès aux secrets

Lorsque quelqu'un rejoint la team, il faut ajouter sa clé au trousseau
(`.gpg-id`) et réencoder tous les secrets.

## Opérations

La manipulation des secrets se fait selon l'API pass :

https://git.zx2c4.com/password-store/about/

*Attention* : il faut préciser le répertoire de passes car c'est
`~/.password-store` par défaut, ce qui n'est pas notre cas.

Exemple :

```sh
PASSWORD_STORE_DIR=. pass ls
```
