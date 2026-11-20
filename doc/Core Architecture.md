# Shield - Core Architecture

## Vision

Shield est un synthétiseur VA moderne orienté manipulation graphique directe.

Son architecture repose sur un principe fondamental :

> Les oscillateurs, les LFO, les générateurs de modulation et leurs représentations visuelles partagent un moteur commun de génération et de transformation de formes.

L'objectif est de proposer une expérience de conception sonore intuitive, cohérente et hautement visuelle, sans compromettre les performances temps réel.

---

## Principes Architecturaux

### Shape Engine First

Le Shape Engine constitue le cœur du système.

Toutes les formes temporelles sont générées par le même moteur :

- Oscillateurs
- LFO
- Générateurs aléatoires
- MSEG
- Futures sources de modulation

Chaque générateur repose sur :

```text
Base Shape
    ↓
Shape Processor Chain
    ↓
Output Shape
```

L'ensemble du système utilise les mêmes concepts, les mêmes interfaces et les mêmes modes de représentation graphique.

---

### Visual First

Toute transformation sonore doit pouvoir être représentée graphiquement en temps réel.

L'utilisateur doit comprendre l'effet d'un paramètre sans devoir l'interpréter uniquement à l'oreille.

Les représentations graphiques sont considérées comme des composants fonctionnels du synthétiseur et non comme de simples éléments décoratifs.

---

### Direct Manipulation

Lorsqu'un paramètre possède une représentation graphique, celle-ci doit pouvoir être manipulée directement.

Exemples :

- Bend via la courbe de forme
- Fold via ses points de repliement
- Phase Distortion via la courbe de phase
- Position stéréo via un espace de représentation dédié

Les potentiomètres servent principalement au réglage fin.

---

### Unified Modulation

Toutes les sources de modulation utilisent :

- les mêmes conventions visuelles ;
- les mêmes méthodes de routage ;
- les mêmes mécanismes de contrôle ;
- les mêmes outils d'édition.

Le comportement du système ne doit jamais dépendre du type de source.

---

### No Hidden Architecture

Aucune fonction importante du moteur ne doit être cachée derrière plusieurs niveaux de navigation.

Les informations essentielles doivent toujours être :

- visibles ;
- accessibles directement ;
- disponibles en un clic maximum.

---

### Architecture Globale

```text
+----------------+
|      UI        |
+----------------+
          |
          v
+----------------+
| Parameter Store|
+----------------+
          |
          v
+----------------+
| Modulation     |
| Engine         |
+----------------+
          |
          v
+----------------+
| Audio Engine   |
+----------------+
```

---

## Séparation des Responsabilités

### Interface Utilisateur

L'interface utilisateur :

- affiche les paramètres ;
- modifie les paramètres ;
- affiche les snapshots publiés par le moteur audio.

Elle ne réalise aucun traitement DSP.

Elle ne possède aucun accès direct aux structures temps réel.

Elle ne contient aucune logique de synthèse.

---

### Parameter Store

Le système de paramètres constitue l'unique point de communication entre les couches.

Il contient :

- paramètres utilisateurs ;
- métadonnées ;
- états de modulation ;
- valeurs sérialisables.

Chaque paramètre possède :

- un identifiant unique ;
- une valeur de base ;
- une valeur modulée ;
- des limites ;
- un mode d'affichage.

---

### Modulation Engine

Le moteur de modulation :

- calcule toutes les sources de modulation ;
- applique les routages ;
- résout les valeurs finales.

Il ne produit aucun son.

Il ne contient aucune logique d'affichage.

Sa sortie est uniquement constituée de valeurs résolues.

---

### Audio Engine

Le moteur audio :

- génère les voix ;
- exécute les Shape Processors ;
- exécute les filtres ;
- réalise le mixage final.

Le moteur audio ne connaît jamais l'origine des modulations.

Il reçoit uniquement des valeurs déjà résolues.

---

## Architecture Temps Réel

### Contraintes

Le thread audio doit rester totalement déterministe.

Les opérations suivantes sont interdites :

- mutex ;
- allocations mémoire ;
- accès disque ;
- journalisation bloquante ;
- chargements de ressources.

---

### Communication Lock-Free

Toutes les communications entre threads utilisent :

- files de messages lock-free ;
- structures atomiques ;
- snapshots immuables.

Aucune synchronisation bloquante n'est autorisée dans le traitement audio.

---

### Publication des Snapshots

Le moteur audio publie régulièrement :

```text
Waveform Snapshot
Filter Snapshot
Modulation Snapshot
Spatial Snapshot
Voice Snapshot
```

L'interface consomme ces données sans interagir directement avec le moteur DSP.

---

## Shape Engine

### Base Shapes

Le Shape Engine génère les formes fondamentales :

- Sine
- Triangle
- Saw
- Square
- Pulse
- Supersaw
- Half-Sine
- Trapezoid
- Sharkfin
- Stepped
- Pulse-Triangle

Chaque forme produit une représentation temporelle normalisée.

---

### Shape Processor Framework

Les transformations sont implémentées via un système extensible.

Chaque processor possède une interface commune.

Exemples :

- Phase Offset
- Phase Stretch
- Bend
- Fold
- Skew
- Rectify
- Clip
- Phase Distortion
- Hard Sync

Chaque processor :

- est modulable ;
- possède une représentation graphique ;
- peut être activé ou désactivé ;
- peut être sérialisé ;
- peut être ajouté sans modifier l'architecture centrale.

---

## Modulation Architecture

### Sources

- AHDSR
- DAHDSR
- MSEG
- LFO
- Random
- Chaos
- Slew
- Macros

Toutes les sources utilisant une évolution temporelle reposent sur le Shape Engine.

---

## Résolution

Chaque paramètre peut recevoir plusieurs modulations simultanées.

Le moteur calcule :

```text
Valeur Finale =
Valeur Utilisateur
+ Somme Modulations
```

Des modes supplémentaires pourront être introduits à l'avenir :

- Multiply
- Min
- Max
- Override

---

## Spatial Engine

Le moteur spatial est intégré au système de voix.

Il permet :

- Pan par voix
- Width par voix
- Stereo Phase Offset
- Voice Random Position

Les paramètres spatiaux sont entièrement modulables.

Ils participent directement à la génération du signal.

Aucun traitement binaural ou HRTF n'est requis dans l'architecture de base.

---

## Presets

### Format

Les presets sont stockés dans un format texte lisible.

Objectifs :

- lisibilité humaine ;
- contrôle de version Git ;
- facilité de migration ;
- robustesse.

---

### Compatibilité

Chaque preset contient :

```text
Version
Build
Schema Version
```

Le moteur doit assurer :

- la compatibilité ascendante ;
- la migration automatique ;
- la conservation des paramètres inconnus.

---

## Architecture Technique

### Langage

- C++20

### Build System

- CMake

### Framework Principal

- JUCE

### SIMD

- xsimd

Le DSP est conçu selon une approche SIMD-first.

Toute nouvelle brique DSP doit être pensée pour être vectorisable.

---

### Bibliothèques

#### Bibliothèques Core

- fmt
- spdlog

#### Bibliothèque Presets

- nlohmann/json

#### Concurrence

- moodycamel::ConcurrentQueue

#### Tests

- Catch2

#### Diagnostic

- cpptrace

#### Mathématiques avancées (optionnel)

- Eigen

---

## DSP

### Traitement Audio

- Float 32 bits
- Architecture compatible avec une évolution future vers Float 64
- Modulation sample accurate
- Audio-rate modulation sur les paramètres critiques

#### Paramètres Audio-Rate

- Pitch
- Phase
- Phase Stretch
- Bend
- Fold
- Filter Cutoff

---

### Polyphonie

- Mono
- Legato
- Polyphonique jusqu'à 16 voix

---

### Optimisations

Objectifs :

- SIMD-first
- Zéro allocation dans le thread audio
- Cache-friendly
- Faible empreinte mémoire
- Scalabilité de la polyphonie

---

## Plateformes

### Systèmes

- Windows
- macOS
- Linux

### Formats de plugins

- VST3
- AU (macOS)

---

## Principes Interface Utilisateur

### Technologie

- JUCE Software Renderer
- Interface entièrement vectorielle
- Aucun asset bitmap requis
- Compatible HiDPI

---

### Rendu

Le rendu graphique ne doit jamais influencer l'exécution audio.

Toutes les visualisations reposent exclusivement sur les snapshots publiés par le moteur.

---

### Visualisations

Le système doit permettre à terme l'affichage temps réel de :

- Oscillateurs
- Shape Processors
- LFO
- Enveloppes
- Filtres
- Modulations
- Répartition stéréo
- Activité des voix

---

### Qualité Logicielle

#### Tests Qualité logicielle

Les tests automatisés couvrent :

- Génération des formes
- Shape Processors
- Modulation
- Compatibilité des presets
- Migrations de version
- Sérialisation
- Désérialisation

---

### Journalisation

La journalisation n'est jamais exécutée dans le thread audio.

Elle est limitée :

- au chargement ;
- à la sauvegarde ;
- aux diagnostics ;
- aux erreurs.

---

## Objectifs de Performance

- Temps réel garanti
- Aucun impact du rendu UI sur l'audio
- Haute densité de modulation
- Polyphonie jusqu'à 16 voix
- Support HiDPI
- Consommation CPU maîtrisée
- Évolutivité à long terme

---

## Objectif Final

Shield n'est pas conçu comme une collection de fonctionnalités indépendantes.

Shield est conçu comme un système cohérent construit autour de trois piliers fondamentaux :

- Shape Engine unifié ;
- Modulation unifiée ;
- Manipulation graphique directe.

Toute évolution future devra renforcer ces principes plutôt que les contourner.
