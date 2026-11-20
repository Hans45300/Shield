---
name: shield-dsp
description: Concevoir, modifier ou analyser le DSP et les Shape Processors du synthétiseur Shield.
---

# DSP et Shape Engine

## Avant toute modification

- Examiner les Shape Processors, interfaces et conventions DSP existants.
- Identifier le chemin des données et les contraintes de temps réel applicables.
- Vérifier si le comportement demandé peut être réalisé en réutilisant un composant existant.

## Implémentation

- Respecter la séparation entre UI, Parameter Store, Modulation Engine et Audio Engine.
- Ne pas introduire d’allocation, de verrou, d’attente bloquante, d’accès disque/réseau ou de journalisation bloquante dans le thread audio.
- Préférer des traitements à durée bornée et un état préalloué.
- Utiliser xsimd uniquement si cela s’intègre aux conventions existantes et apporte un bénéfice mesurable.
- Conserver une voie scalaire simple lorsqu’elle améliore la lisibilité ou la portabilité.
- Veiller à la cohérence des voies SIMD et scalaire pour les limites, valeurs non finies et cas particuliers.
- Préserver les invariants de traitement et définir le comportement des entrées invalides.

## Tests et compte rendu

- Ajouter ou mettre à jour des tests Catch2 couvrant le comportement nominal et les cas limites pertinents.
- Ne pas lancer les tests, le build ou la compilation.
- Indiquer les validations que le programmeur peut effectuer.
