---
name: shield-cpp
description: Écrire ou refactoriser du C++20 dans le dépôt Shield en respectant ses conventions et ses contraintes de robustesse.
---

# C++20 dans Shield

## Avant toute modification

- Lire les fichiers voisins pour suivre les conventions locales.
- Vérifier les types, fonctions et dépendances existants avant d’ajouter une abstraction.
- Garder le changement ciblé et éviter les refactorings sans rapport avec la demande.

## Pratiques

- Préférer RAII et la règle du zéro.
- Appliquer la règle des 5 lorsqu’une classe personnalise ou nécessite un comportement particulier de destruction, de copie ou de déplacement.
- Initialiser les membres et préserver les invariants des classes.
- Utiliser `const` et les références lorsque cela exprime correctement l’intention.
- Éviter les pointeurs bruts propriétaires ; ne recourir à `std::shared_ptr` que lorsque le partage de propriété est requis.
- Vérifier les durées de vie, les accès aux conteneurs, les conversions et les débordements pertinents.
- Éviter les exceptions comme mécanisme normal de contrôle de flux.
- Préférer les algorithmes et types standard aux abstractions réinventées, lorsque cela reste lisible et respecte les contraintes temps réel.

## Résultat

- Ajouter ou mettre à jour les tests pertinents.
- Ne pas lancer le build, la compilation ou les tests.
- Résumer les modifications, les validations à faire et les éventuelles limites.
