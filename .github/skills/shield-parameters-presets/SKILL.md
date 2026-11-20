---
name: shield-parameters-presets
description: Modifier les paramètres, leur liaison à l’interface et leur sérialisation dans les presets Shield.
---

# Paramètres et presets

## Avant toute modification

- Examiner la définition des paramètres, leur identifiant, leur plage, leur valeur par défaut et leurs usages.
- Repérer les liens existants entre UI, Parameter Store, modulation et DSP.
- Vérifier les tests et exemples de presets concernés.

## Implémentation

- Préserver les identifiants de paramètres et la compatibilité des presets existants.
- Maintenir la séparation entre représentation UI et traitement DSP.
- Définir explicitement les valeurs par défaut et le comportement des valeurs hors plage ou invalides.
- Si le format de preset évolue, prévoir une migration ou une stratégie de compatibilité adaptée aux conventions du projet.
- Éviter les accès concurrents non protégés entre threads ; utiliser les mécanismes déjà présents.

## Tests et compte rendu

- Ajouter ou mettre à jour les tests portant sur les valeurs, la sérialisation, la désérialisation et la compatibilité lorsque cela s’applique.
- Ne pas lancer les tests, le build ou la compilation.
- Signaler les validations que le programmeur devra effectuer.
