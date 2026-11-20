# DSP Rules

## SIMD First

Tout nouvel algorithme DSP doit être conçu pour être vectorisable.

## Cache Friendly

Limiter les accès mémoire indirects.

## Audio Rate Aware

Les paramètres audio-rate doivent être explicitement identifiés.

## Deterministic Processing

Aucun comportement aléatoire non reproductible dans le moteur audio.

## Allocation Rules

Interdiction de :

- new
- delete
- malloc
- free
- std::vector resize

dans le traitement audio.
