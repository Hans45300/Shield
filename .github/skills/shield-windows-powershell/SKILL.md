---
name: shield-windows-powershell
description: Proposer des commandes ou procédures de développement adaptées à l’environnement Windows et PowerShell restreint de Shield.
---

# Windows et PowerShell

- Proposer des commandes compatibles avec Windows PowerShell en mode restreint.
- Ne pas supposer la disponibilité de Bash ou d’outils Unix comme `sed`, `awk` ou `grep`.
- Privilégier les commandes PowerShell ou les outils déjà utilisés par le projet.
- Ne pas proposer de commande qui lance un build, une compilation ou les tests : ces tâches sont réservées au programmeur.
- Avant de proposer une commande qui modifie des fichiers ou l’état Git, expliquer brièvement son effet et éviter les actions destructrices.
