# Shield - Presentation

  Synthetiseur VA oriente manipulation graphique directe, ou oscillateurs, LFO et modulations partagent le meme moteur de formes et les memes outils de transformation.

## Principes de base

- Visual first : toute transformation sonore doit etre representee graphiquement en temps reel
- Direct Manipulation : manipulation directe depuis la representation graphique au maximum
- Unified Modulation : Meme concepts visuels, memes interactions pour toutes les sources de modulation
- No Hidden Architecture : pas de fonctionnalites importantes dans d'autres pages ou dans des sous-menus
- Precision when needed : toute valeur doit pouvoir etre ajuste visuellement ou definie precisement par saisie numerique
- Consistent processing : meme moteur de generation, memes shapes processors pour les oscillateurs, les LFO et les autres generateurs de formes
- Separation stricte entre moteur audio, moteur de modulation et interface utilisateur
- Aucun traitement DSP dans les composants UI
- Aucun acces direct de l'UI aux structures temps reel audio
- Communication via snapshots immuables et files de messages lock-free
  - Waveform Snapshot
  - Modulation Snapshot
  - Filter Snapshot
  - Spatial Snapshot
  - Voice Snapshot

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

  - L'UI ne connait que des parametres
  - Le moteur de modulation ne connait que des parametres
  - Le moteur audio ne connait que des valeurs resolues

  UI
  ==> modifie un parametre

  Modulation Engine
  ==> calcule sa valeur finale

  Audio Engine
  ==> consomme la valeur

## Shape Processing

Toute transformation appliquee a une forme utilise une interface commune.

Chaque Shape Processor :

- possede une representation graphique
- est modulable
- peut etre reordonne
- peut etre active ou desactive
- utilise le meme systeme de parametres

Exemples :

- Bend
- Fold
- Stretch
- Phase Distortion
- Clip
- Rectify

## Generation sonore

### 2 Oscillateurs

- sine
- triangle
- saw
- square
- pulse
- supersaw
- half-sine
- trapezoid
- sharkfin
- stepped
- pulse-triangle

#### Deformations

- Phase offset
- Phase Stretch
- Bend
- Fold
- Skew
- Hard Sync
- Clip
- Rectify
- X-Mod
- Ring Mod
- Phase distorsion
- Unison
  - nb de voix
  - detune
  - Stereo Spread
  - Phase Spread
  - Drift
  - Width
  - Distribution
    - Lineaire
    - Exponentielle
    - Aleatoire
    - Symetrique
    - Circulaire

  Gestion sous forme de Shape Processors chaines, avec un meme moteur regroupant toutes les formes et toutes les deformations

### 1 sub oscillateur

- sine
- triangle
- saw
- square
- pulse

### 1 generateur de bruit

- Bruit brun a bruit ultraviolet
- Tracking (0 : frequence fixe, 100 : suivi complet du clavier)
  - A 0, choix de la frequence avec possibilite de saisie de note (facon A4) ou de frequence en hertz
- Largeur

## Gestion de la position sonore

- Pan par voix
- Width par voix
- Stereo phase offset
- Voice random position

## Mixer

- Niveau OSC1
- Niveau OSC2
- Niveau Sub
- Niveau Noise

## Filtres

- 2 filtres en parallele ou en serie

- Modeles analogiques
  - Ladder
  - OTA
  - Sallen Key
  - State Variable

- Morphing (ex : Ladder ==> OTA) sans changer de filtre
  - 0 : un type de filtre
  - 100 : un autre type de filtre
  - Interpolation sur certains elements des deux modeles (cutoff, resonance, saturation) pour assurer la transition.

## Modulation

  Audio Rate Modulation sur pitch, phase, bend, fold et cutoff

  Toute modulation doit etre

- visuelle, mais maitrisee
  - Saisie a la souris
  - possibilite de gerer la quantite exacte de modulation via de la saisie texte
  - Dans la mesure du possible, tous les elements devraient etre des cibles de modulation possibles

  Utiliser une architecture de type :

- Node
  - Parameter
  - Modulation Source
  - Modulation Target

### Sources de modulation

- Enveloppes
  - Amp AHDSR
  - Filtre DAHDSR
  - MSEG (plusieurs...)
- LFO
  - Synchronisation sur le tempo ou temporelle
  - One-Shot, trigger ou free-run
  - Memes formes et deformations que les oscillateurs et plus :
    - Sample & Hold
    - Sample & Glide
- Random
- Chaos
- Slew
- Macros 1
- Macros 2
- Macros 3
- Macros 4
- Macros 5
- Macros 6
- Macros 7
- Macros 8

## Effets

- Saturation / Drive
- Limiteur de securite
- Eventuellement rack optionnel

## Voice Management

- de Mono a 16 voix
- Legato / Portamento
- Voice drift
- Voice randomisation

## UI

- Style moderne simple et epure
- Interface entierement vectorielle, sans OpenGL (JUCE CPU)
- Maximum d'icones, minimum de texte (utilisation de paths ou de svg)
- Palettes de couleurs simples (majorite de transparences)
- themes clair et fonce, fond a majorite grise
- Tooltips pour les eclaircissements
- Menus via clic droit pour les gestions fines de parametres
  - MIDI Learn / Forget
  - Retour a la valeur par defaut
  - Definition de la valeur
  - Sous-menu ajoute a la creation de modulations
    - Definition de la valeur de modulation
    - Suppression de la modulation

- Tout parametre complexe possede :
  - visualisation temps reel
  - interaction directe

- Reduction des sliders lineaires. Privilegier :
  - potentiometres rotatifs
  - drag direct sur les graphes
  - widgets contextuels

- Aucune page cachee.
  - Tout doit etre visible ou accessible en un clic.

## Gestion des presets

- Collections
  - Import et export
- Tags
- Favoris
- Commentaires
- Compatibilite ascendante des presets
  - Migration automatique des anciens presets
- Chargement securise
  - Parametres inconnus ignores mais conserves

## Architecture technique

- Traitement interne en float 32 bits, avec conception facilitant un eventuel passage ulterieur a float 64
- Modulation sample accurate
- Audio-rate modulation sur les parametres critiques
- Interface vectorielle JUCE CPU
- Compatible HiDPI
- Aucun asset bitmap requis
- Presets serialises en format texte lisible
- Architecture extensible par Shape Processors
- C++20
- JUCE
- xsimd
- fmt
- spdlog
- Catch2 / GoogleTest ?
- nlohmann/json
- moodycamel::ConcurrentQueue
- cpptrace
- CMake
- DSP SIMD-first
- Interface entierement vectorielle
- Separation stricte DSP / Modulation / UI
- Communication lock-free entre threads
- Compatible Windows, Linux et macOS
- VST3 (Windows/Linux/macOS)
- AU (macOS)
- Compatible HiDPI
- Aucun asset bitmap requis
- Format de preset texte versionne
- Architecture extensible par Shape Processors

## Architecture Temps Reel

- Separation stricte DSP / Modulation / UI
- Aucun verrou (lock) dans le thread audio
- Communication inter-modules via mecanismes lock-free
- L'UI ne lit jamais directement les structures DSP
- Le moteur audio publie des snapshots consommes par l'interface
- Toute visualisation est decouplee du traitement audio
- Aucun rendu UI ne peut affecter les performances audio

## Design Goals

- Rapid sound design
- No menu diving
- Immediate visual feedback
- Automation-friendly
- Preset compatibility first
- Efficient CPU usage
