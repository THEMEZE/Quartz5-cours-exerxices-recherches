---
title: "Callouts (Quartz / Obsidian)"
tags:
  - outils
  - quartz
---

Pense-bête personnel sur la syntaxe des callouts (encadrés type
"admonition") supportée par Quartz — la même syntaxe qu'Obsidian.

## Syntaxe de base

```
> [!info] Titre
> Contenu du callout.
```

Le type (`info`, `tip`, `warning`, ...) contrôle la couleur et l'icône.
Sans texte après le type, le nom du type sert de titre par défaut :

```
> [!warning]
> Cette section n'est pas terminée.
```

## Replier / déplier

Un `+` ou un `-` juste après le type rend le callout repliable :

- pas de modificateur → fixe, toujours visible
- `+` → repliable, **ouvert** par défaut
- `-` → repliable, **fermé** par défaut

```
> [!question]+ Ouvert par défaut, mais repliable
> ...

> [!example]- Fermé par défaut, à cliquer pour dérouler
> ...
```

**Convention utilisée dans mes notes générées (projet `CoursOndes`)** —
pour faciliter la lecture, l'état par défaut dépend de l'importance :

| Contenu               | Type        | État par défaut | Pourquoi |
|------------------------|-------------|------------------|----------|
| Correction (résultat)  | `success`   | `+` ouvert        | C'est ce qu'on vient lire |
| Coup de pouce           | `tip`       | `-` fermé          | Indice à la demande, pas de spoil |
| Solution détaillée      | `example`   | `-` fermé          | Long, optionnel |
| Aller plus loin         | `question`  | `-` fermé          | Approfondissement, pas prioritaire |
| Voir aussi / liens      | `note`      | fixe               | Court, toujours utile |

Voir `CoursOndes/web/export_markdown.py`, dictionnaire `COLLAPSE`, pour
l'implémentation exacte.

## Nested (imbrication)

```
> [!question]+ Peut-on imbriquer des callouts ?
>
> > [!todo]- Oui, et même les replier !
> >
> > > [!example] Sur plusieurs niveaux si besoin.
```

## Types disponibles (et leurs alias)

`note` · `abstract` (alias : `summary`, `tldr`) · `info` · `todo` ·
`tip` (alias : `hint`, `important`) · `success` (alias : `check`, `done`) ·
`question` (alias : `help`, `faq`) · `warning` (alias : `attention`,
`caution`) · `failure` (alias : `missing`, `fail`) · `danger` (alias :
`error`) · `bug` · `example` · `quote` (alias : `cite`)

## Callout personnalisé

Un type non reconnu prend le style `note` par défaut. Pour un style
propre, ajouter dans `quartz/styles/custom.scss` :

```scss
.callout {
  &[data-callout="mon-type"] {
    --color: #couleur;
    --border: #couleur-bordure;
    --bg: #couleur-fond;
    --callout-icon: url("data:image/svg+xml;utf8,<svg .../>");
  }
}
```

(le SVG de l'icône doit être URL-encodé — un outil en ligne suffit).

## À ne pas oublier

Si les callouts ne s'affichent pas malgré le plugin activé dans
`quartz.config.yaml`, vérifier l'ordre des plugins : le plugin qui
parse le Markdown façon Obsidian doit passer **après** celui de la
coloration syntaxique dans la liste `plugins.transformers`.
