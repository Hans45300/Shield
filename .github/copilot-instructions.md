# Shield — Instructions Copilot

## Instructions prioritaires

- Ne jamais lancer de build, compilation, tests ou commande susceptible de compiler le projet. Ces tâches sont réservées au programmeur.
- Après une modification, proposer les validations pertinentes à exécuter, sans les lancer. Ne pas affirmer qu’un changement compile ou que les tests passent sans validation effective.
- Ne pas mettre à jour un sous-module, son contenu ou son pointeur sans demande explicite.
- Respecter les contraintes de temps réel : aucune allocation, aucun verrou, aucune attente bloquante, aucun accès disque/réseau ni journalisation bloquante dans le thread audio.
- En cas d’ambiguïté sur le comportement attendu, poser une question plutôt que de choisir silencieusement.

## Projet

Synthétiseur VA moderne basé sur un Shape Engine unifié.

### Technologies

C++20, JUCE, xsimd, CMake, fmt, spdlog, nlohmann/json, moodycamel::ConcurrentQueue, Catch2 et cpptrace.

### Architecture

    UI → Parameter Store → Modulation Engine → Audio Engine

## Règles de développement

- Avant toute modification, inspecter les composants, conventions et tests existants.
- Privilégier les changements ciblés ; éviter les refactorings hors périmètre et les nouvelles dépendances lorsqu’un composant existant convient.
- S’aligner sur le code existant plutôt que d’inventer des API ou conventions.
- Respecter la séparation UI / DSP et l’architecture orientée Shape Engine. Avant d’ajouter un composant, vérifier qu’il ne duplique pas un Shape Processor existant.
- Produire du code testable, ajouter ou mettre à jour les tests Catch2 pertinents et documenter les composants si nécessaire.
- Ne pas modifier les tests pour masquer une régression ni les fichiers générés, sauf demande explicite.

## C++ moderne et robustesse

- Préférer RAII et la règle du zéro. Appliquer la règle des 5 lorsqu’une classe personnalise ou nécessite un comportement particulier de destruction, de copie ou de déplacement. Utiliser `= default` ou `= delete` lorsque cela clarifie sa sémantique.
- Initialiser les membres, privilégier des valeurs par défaut sûres et préserver les invariants des classes.
- Valider les entrées aux frontières du système et définir le comportement des valeurs invalides.
- Éviter les comportements indéfinis : vérifier notamment les durées de vie, les accès aux conteneurs, les conversions et les débordements pertinents.
- Utiliser `const` et les références lorsqu’ils expriment correctement l’intention. Éviter les pointeurs bruts propriétaires ; ne recourir à `std::shared_ptr` que si le partage de propriété est nécessaire.
- Préférer les algorithmes et types de la bibliothèque standard lorsque cela reste lisible et compatible avec les contraintes temps réel.
- Éviter les casts, macros, conversions implicites risquées et exceptions comme mécanisme normal de contrôle de flux.

## DSP, temps réel et concurrence

- Utiliser SIMD lorsque cela apporte un bénéfice mesurable ; conserver une voie scalaire simple lorsqu’elle améliore la lisibilité ou la portabilité.
- Toute optimisation DSP doit préserver le comportement attendu et, si possible, être justifiée par une mesure.
- Traiter les valeurs non finies (`NaN`, infini) et les limites numériques lorsque cela est pertinent ; ne pas supposer une précision ou un ordre d’évaluation particulier.
- Préserver la cohérence entre les chemins SIMD et scalaire, notamment pour les limites et les valeurs exceptionnelles.
- Ne pas introduire dans le chemin audio d’allocation, d’opération à durée non bornée ou d’autre traitement bloquant.
- Utiliser les mécanismes de communication UI/DSP déjà présents dans le projet.
- Pour toute donnée partagée entre threads, identifier les lecteurs, les écrivains et le mécanisme de synchronisation ; vérifier les garanties de concurrence des types utilisés.
- Préserver les invariants de traitement audio et la sûreté des changements de paramètres.

## Paramètres et presets

- Préserver les identifiants de paramètres et la compatibilité des presets existants.
- Si une évolution de format est nécessaire, prévoir une migration ou une valeur par défaut compatible.
- Garder les paramètres et leur représentation UI séparés du traitement DSP.

## Tests et livrables

- Maintenir sous `tests/` une arborescence miroir de `src/` pour les tests unitaires.
- Placer les tests dans le dossier correspondant au domaine du code testé.
- Suivre les conventions Catch2 et CMake déjà présentes dans le projet.
- Ne pas déplacer ou renommer des tests sans vérifier les références CMake et les conventions existantes.
- Couvrir les cas pertinents, notamment valeurs invalides, limites de paramètres et transitions d’état.
- Indiquer les fichiers modifiés, les validations que le programmeur doit effectuer et les limites éventuelles.
- Limiter chaque changement à un objectif cohérent et garder le code compilable.

## Environnement

- Le développement se fait sous Windows ; les commandes proposées doivent être compatibles avec PowerShell en mode restreint.
- Ne pas supposer la disponibilité d’outils Unix tels que `bash`, `sed`, `awk` ou `grep`. Privilégier PowerShell ou les outils du projet.

## Documentation

- Documenter les interfaces publiques et les composants dont les invariants ou contraintes ne sont pas évidents.
- Maintenir les diagrammes d’architecture importants dans `docs/` au format Mermaid, en cohérence avec le code.
- Ne pas générer ni modifier des fichiers de documentation générés, sauf demande explicite.
- Ne pas lancer Doxygen ni une commande de génération ; proposer les validations nécessaires au programmeur.
- Réserver le wiki à la documentation destinée aux utilisateurs du produit.
- Placer la documentation technique du dépôt dans `docs/` et la documentation locale dans le code.
- Ne pas ajouter au wiki des informations d’architecture ou de développement source.
- Maintenir les diagrammes d’architecture dans `docs/` ; ne pas modifier la documentation générée sans demande explicite.
