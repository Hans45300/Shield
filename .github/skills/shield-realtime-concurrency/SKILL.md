---
name: shield-realtime-concurrency
description: Analyser ou modifier le partage de données et la communication entre threads, en particulier avec le thread audio.
---

# Temps réel et concurrence

## Analyse

- Identifier les threads concernés, leurs lecteurs et leurs écrivains.
- Examiner les mécanismes de communication déjà utilisés dans le projet avant d’en proposer un nouveau.
- Vérifier les garanties de concurrence des types et composants utilisés ; ne pas les présumer.

## Contraintes

- Aucun verrou, attente bloquante, allocation ou opération à durée non bornée dans le thread audio.
- Ne pas effectuer d’accès disque/réseau ni de journalisation bloquante depuis le chemin audio.
- Éviter les accès simultanés non synchronisés et préserver la durée de vie des objets partagés.
- Utiliser les mécanismes temps réel existants pour transmettre les changements de paramètres entre UI et DSP.
- Garder la synchronisation aussi simple et explicite que possible, sans affaiblir les garanties nécessaires.

## Tests et compte rendu

- Ajouter des tests adaptés aux invariants observables, sans prétendre qu’ils prouvent à eux seuls l’absence de toute course.
- Ne pas lancer les tests, le build ou la compilation.
- Décrire les points de concurrence examinés et les validations à effectuer par le programmeur.
