# Notifications secrets

Les différents secrets qui animent l'infrastructure de Notifications
sont encryptés dans cette forge au travers du [gestionnaire de mots de
passe "pass"](https://www.passwordstore.org/).

## Accès aux secrets

Pour lire ou maniupler les secrets il faut avoir une clé GnuPG et
faire rajouter la clé publique au trousseau dans le fichier `.gpg-id`.

### Arrivée dans l'équipe

Lorsqu'une personne rejoint l'équipe il faut :

1. créer une clé GnuPG

Voir l'excellent [tutorial de GitHub sur la création de
clé](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key).

Il faut ensuite obtenir la clé publique, par exemple avec :

```sh
gpg --list-keys | grep "uid" -B1
```

2. ajouter la clé au trousseau

L'identifiant de la clé publique doit être rajouté dans une ligne du
`.gpg-id` par un membre existant de l'équipe.

3. réencoder les secrets

Une fois que le trousseau est à jour, il faut qu'un membre existant
réencode les secrets pour qu'ils soient déchiffrables par tout le
monde :

```sh
make reencrypt
```

Voir le `Makefile` pour la commande précise.

### Départ de l'équipe

Pour un départ dans l'équipe il faut faire exactement pareil que pour
l'arrivée mais en enlevant la clé du trousseau.

## Opérations sur les secrets

**Attention** : il faut toujours préfixer les commandes `pass` avec
`PASSWORD_STORE_DIR=.` car le répertoire par défaut est
`~/.password_store` ce qui n'est pas notre cas. Par exemple :

```sh
# dans le dossier /Users/steph/build/betagouv/notifications/secrets

$ PASSWORD_STORE_DIR=. pass ls
```

Une fois ce détail noté l'api de `pass` est très simple :

| opération   | commande          | exemple                                  |
|-------------|-------------------|------------------------------------------|
| lister      | ls                | `pass ls`                                |
| obtention   | show `chemin`     | `pass show admin/staging/sentry.gpg`     |
| recherche   | find `motif`      | `pass find sentry`                       |
| édition     | edit `chemin`     | `pass edit admin/staging/sentry.gpg`     |
| insertion   | insert `chemin`   | `pass insert admin/staging/sentry.gpg`   |
| création    | generate `chemin` | `pass generate admin/staging/sentry.gpg` |
| suppression | rm `chemin`       | `pass rm admin/staging/sentry.gpg`       |

L'API complète est consultable dans le manuel : `man pass`,
disponible aussi sur https://git.zx2c4.com/password-store/about/.
