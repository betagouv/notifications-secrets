# Concept

En une phrase : les secrets sont des fichiers texte encryptés pour
tous les collaborateurs du projet et eux seuls.

## Structure

```sh
$ tree secrets -a

secrets/
├── .gpg-id
├── admin
│   └── staging
│       └── foo-api-key.gpg
│       └── bar-api-key.gpg
└── api
    └── staging
        └── etc-etc.gpg
        [...]
```

Note : `admin`, `api`, `staging`, etc., sont ici arbitraires, tout
comme le nom du dossier `secrets`. Le seul élément nécessaire est un
`.gpg-id` à la racine.

## Le trousseau de clés

À la racine du répertoire `secrets`, un fichier `.gpg-id` agit en
trousseau de clés : il contient un identifiant de clé publique GPG par
ligne pour chaque membre de l'équipe qui est autorisé à voir et
modifier les secrets.


Exemple avec deux membres dans l'équipe :

```sh
$ cat secrets/.gpg-id
07405EC4E981CF86955A69244B399DE2A2F0E926
B55320F9BE149B7DFCD0B566E7C4F8FA3FDA0530
```

## Lecture des secrets

Pour lire un secret, il suffit simplement d'être le propriétaire
légitime d'une des clés du trousseau, c'est à dire avec la clé privée
correspondante (voir [l'introduction de l'article Wikipedia sur la cryptographie
asymétrique](https://fr.wikipedia.org/wiki/Cryptographie_asym%C3%A9trique)).

## Écriture / modification des secrets

Pour écrire ou modifier un secret, il faut en revanche pouvoir
encrypter/réencrypter pour toutes les personnes présentes dans le
trousseau. Comme la clé publique du destinataire est nécessaire pour
cela, il faut être en possession de toutes les clés de l'équipe pour
pouvoir maintenir ce chiffrage multi-destinataires.

Le [guide d'équipe](/TEAM.md) donne d'avantage de précision sur le
processus.

## Le gestionnaire de mots de passes

[pass](https://www.passwordstore.org/) est une interface en ligne de
commande (note : il existe aussi des interfaces graphiques) qui
permet de manipuler ces secrets.

**Attention** : il faut toujours indiquer à `pass` le password store dont il
est question ; par défaut c'est `~/.password_store` qui est choisi, ce
qui n'est pas notre cas. On préfixera donc toutes les commandes avec
`PASSWORD_STORE_DIR=./secrets` pour opérer sur le bon répertoire.

Exemple :

```sh
# dans le dossier /Users/steph/build/betagouv/notifications/secrets

$ PASSWORD_STORE_DIR=./secrets pass ls
```

Une fois ce détail noté l'api de `pass` est très simple :

| opération            | commande          | exemple                                  |
|----------------------|-------------------|------------------------------------------|
| lister               | ls                | `pass ls`                                |
| obtention            | show `chemin`     | `pass show admin/staging/sentry.gpg`     |
| recherche            | find `motif`      | `pass find sentry`                       |
| recherche du contenu | grep `motif`      | `pass grep "http://"`                    |
| édition              | edit `chemin`     | `pass edit admin/staging/sentry.gpg`     |
| insertion            | insert `chemin`   | `pass insert admin/staging/sentry.gpg`   |
| création             | generate `chemin` | `pass generate admin/staging/sentry.gpg` |
| suppression          | rm `chemin`       | `pass rm admin/staging/sentry.gpg`       |
