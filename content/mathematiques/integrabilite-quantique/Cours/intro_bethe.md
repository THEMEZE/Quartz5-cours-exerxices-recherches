---
title: "Notes — Introduction à l'ansatz de Bethe"
tags:
  - cours
---

*Notes de recherche (gabarit à compléter)*

📄 **[Télécharger le PDF](/pdfs/recherche_intro_bethe.pdf)**

## 1. Motivation

*(Gabarit d'exemple.)* La chaîne de Heisenberg XXX est le premier
système où Bethe a proposé sa méthode (1931) pour diagonaliser
l'hamiltonien exactement.

> [!info] 💡 Remarque
> Point de départ classique : article original de Bethe (1931), Zeitschrift für Physik.


## 2. Équations de Bethe (forme coordonnée)

*(À compléter : dérivation des équations de Bethe pour la chaîne XXX,
ansatz sous forme d'onde plane pour les magnons.)*

## 3. Modèle de Lieb-Liniger (gaz de bosons 1D en interaction contact)

Un autre système intégrable classique, résolu par ansatz de Bethe :
\begin{eqnarray}\label{eq.LL}
  $\operator{H}$ & = &
    {\color{colorFour} \underbrace{\frac{\hbar^2}{2m} \sum_{i=1}^{$N$}
    \operator{\partial}_{x_i}^2}_{\text{Cinétique}}}
    + {\color{colorSix} \underbrace{$g$
    \sum_{1 \leq i < j \leq N} \operator{\delta}(x_i - x_j)}_{\text{Interaction}}} ,
\end{eqnarray}

> [!info]- 📦 Formalisme — Lieb-Liniger (LL)
> Le paramètre sans dimension $\gamma = mg/(\hbar^2 n)$ (avec $n=N/L$
> la densité) contrôle le régime physique : $\gamma \ll 1$ (quasi
> condensat), $\gamma \gg 1$ (régime de Tonks-Girardeau, "fermionisation").

