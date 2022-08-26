# Gestion d'équipe

## Ajouter quelqu'un

Pour ajouter quelqu'un au trousseau il faut :

### 1. Obtenir leur clé publique GPG

La personne en question doit avoir une clé GPG. Pour s'en faire une,
voir le [tutoriel de GitHub sur la génération de clé
GPG.](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key).

Ensuite, elle doit transférer sa clé publique à un membre existant de
l'équipe, ce qui peut se faire à travers un serveur de clés ou par
simple transfert textuel.

Imaginons un nouveau venu Romain qui veut envoyer sa clé publique à sa
collaboratrice Jeanne :

```sh
romain@Machine-de-Romain $ gpg --armor --export mon-identifiant-de-cle > cle-publique-romain.txt
```

Suit le transfert par email, Mattermost, pigeon voyageur, puis :


```sh
jeanne@Machine-de-Jeanne $ gpg --import cle-publique-romain.txt
```

Maintenant Jeanne peut encoder à destination de Jean.

### 2. Rajouter la clé au trousseau

Exemple :

```sh
$ cat 3782CBB60147010B330523DD26FBCC7836BF353A >> secrets/.gpg-id
```

Une fois que le trousseau est à jour, il faut réencoder les secrets
pour inclure la nouvelle personne :

```sh
make reencrypt
```

Voir le `Makefile` pour la commande précise.

### Départ de l'équipe

Pour un départ dans l'équipe il faut faire exactement pareil que pour
l'arrivée mais en enlevant la clé du trousseau.

L'API complète est consultable dans le manuel : `man pass`,
disponible aussi sur https://git.zx2c4.com/password-store/about/.
