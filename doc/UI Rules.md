# UI Rules

## Strict Separation

L'UI ne lit jamais directement les structures DSP.

## Snapshot Only

Toutes les visualisations utilisent exclusivement les snapshots publiés.

## No DSP Logic

Aucun traitement audio dans les composants UI.

## Vector Only

Privilégier :

- Paths JUCE
- SVG
- primitives vectorielles

Éviter les bitmaps.
