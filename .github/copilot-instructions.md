# Shield

Projet :

Synthétiseur VA moderne basé sur un Shape Engine unifié.

## Technologies

- C++20
- JUCE
- xsimd
- CMake
- fmt
- spdlog
- nlohmann/json
- moodycamel::ConcurrentQueue
- Catch2
- cpptrace

## Architecture

UI
→ Parameter Store
→ Modulation Engine
→ Audio Engine

## Contraintes

- Temps réel strict
- Aucun lock dans le thread audio
- SIMD-first
- Design orienté Shape Engine

Avant de proposer un nouveau composant :

1. vérifier qu'il ne duplique pas un Shape Processor existant
2. respecter la séparation UI / DSP
3. respecter la compatibilité preset
4. produire du code testable