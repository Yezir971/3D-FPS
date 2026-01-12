# 🎮 Silent-tilde - FPS 3D

<div align="center">

![Godot Version](https://img.shields.io/badge/Godot-4.4-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Engine](https://img.shields.io/badge/Physics-Jolt%20Physics-orange.svg)

**Un jeu de tir à la première personne (FPS) 3D développé avec Godot Engine**

[📋 À propos](#-à-propos) • [🎯 Fonctionnalités](#-fonctionnalités) • [🛠️ Technologies](#️-technologies) • [📚 Concepts étudiés](#-concepts-étudiés) • [📦 Installation](#-installation) • [🎮 Contrôles](#-contrôles) • [📁 Structure du projet](#-structure-du-projet)

</div>

---

## 📋 À propos

**Silent-tilde** est un jeu de tir à la première personne (FPS) en 3D où le joueur doit éliminer tous les ennemis présents dans le niveau pour progresser. Ce projet démontre une maîtrise approfondie des mécaniques de jeu 3D, de la gestion des ressources, des systèmes d'animation complexes et de l'optimisation des performances dans un environnement de jeu moderne.

### 🎯 Objectif du jeu

Le but principal est de survivre et d'éliminer tous les ennemis du niveau. Le joueur dispose d'un arsenal varié d'armes, chacune avec ses propres caractéristiques, et doit gérer ses munitions et sa santé tout en naviguant dans un environnement 3D immersif.

---

## 🖼️ Captures d'écran

<div align="center">

### Menu Principal
![Menu Principal](/screen-doc/menu.png)

### Gameplay

![Gameplay Screenshot](/screen-doc/game-play.png)

### Système d'armes
![Weapon System](/screen-doc/arme.png)

### Combat
![Combat Screenshot](/screen-doc/combat.png)

</div>

---

## 🎯 Fonctionnalités

### Système de combat
- ✅ **Système d'armes modulaire** avec plusieurs types d'armes (Revolver, Fusil, Sniper, Shotgun, AMG, UZI, Grenade, Smoke)
- ✅ **Gestion des munitions** avec système de rechargement
- ✅ **Système de tir** avec calcul de spread et raycast
- ✅ **Dégâts et santé** pour le joueur et les ennemis
- ✅ **Système de loot** (munitions, santé)

### Système d'ennemis
- ✅ **IA d'ennemis** Zombies ( futur intégration ), Squelettes avec comportements d'attaque
- ✅ **Barres de vie** pour les ennemis
- ✅ **Animations de mort** et d'attaque
- ✅ **Détection et poursuite du joueur**

### Interface utilisateur
- ✅ **HUD complet** avec affichage de la santé, munitions, et armes
- ✅ **Menu principal** avec navigation
- ✅ **Système de pause**
- ✅ **Écran de fin de partie**

### Graphismes et rendu
- ✅ **Environnement 3D** avec bâtiments, props et décors
- ✅ **Gestion avancée des lumières** pour l'ambiance
- ✅ **Animations 3D** fluides avec AnimationTree
- ✅ **Effets visuels** et particules

### Audio
- ✅ **Sons d'armes** variés (tir, rechargement, clic à vide)
- ✅ **Musique de fond** immersive
- ✅ **Audio spatialisé** en 3D

---

## 🛠️ Technologies

- **Moteur de jeu** : Godot Engine 4.4
- **Langage** : GDScript
- **Moteur physique** : Jolt Physics
- **Rendu** : OpenGL (GL Compatibility)
- **Format de modèles** : GLB, FBX
- **Audio** : AudioStream (MP3, OGG, M4A)

---

## 📚 Concepts étudiés

Ce projet a été développé pour approfondir et démontrer la maîtrise de plusieurs concepts avancés en développement de jeux vidéo :

### 1. 🔄 Collisions et physique
- **Collision entre objets et corps** : Implémentation d'un système de détection de collision robuste entre les projectiles, le joueur, les ennemis et l'environnement
- Utilisation de `RayCast3D` pour les tirs et la détection de cibles
- Gestion des collisions avec `CharacterBody3D` et `RigidBody3D`
- Calcul précis des points d'impact et des normales de collision

### 2. 📦 Gestion des ressources (Resource System)
- **Création rapide d'items avec différentes statistiques** : Système de ressources modulaire permettant de créer rapidement de nouvelles armes avec des propriétés variées
- Utilisation de `Resource` et `@export` pour la sérialisation des données
- Architecture modulaire avec `GunResource` permettant de définir :
  - Types d'armes (enum)
  - Statistiques (dégâts, portée, spread, cadence)
  - Modèles 3D et sons
  - Propriétés de munitions
- Système extensible facilitant l'ajout de nouveaux items sans modifier le code existant

### 3. 🎬 Animations 3D
- **Animation de personnages et objets** : Système d'animation complet pour les ennemis et le joueur
- Utilisation de `AnimationPlayer` pour les séquences d'animation
- Intégration des animations importées depuis les modèles 3D
- Synchronisation des animations avec les états du jeu

### 4. 🌳 AnimationTree pour les états complexes
- **Gestion des différentes poses et états** : Utilisation d'`AnimationTree` pour gérer les transitions fluides entre différents états d'animation
- Machine à états pour les ennemis (idle, walk, attack, death)
- Blending entre animations pour des transitions naturelles
- Paramètres dynamiques contrôlant les transitions (vitesse, santé, état de combat)

### 5. 💡 Gestion des lumières
- **Éclairage avancé** : Mise en place d'un système d'éclairage sophistiqué pour créer une ambiance immersive
- Utilisation de différents types de lumières (DirectionalLight, OmniLight, SpotLight)
- Gestion de l'ambiance et de l'atmosphère du niveau
- Optimisation des performances d'éclairage

### 6. 🏗️ Architecture et design patterns
- **Séparation des responsabilités** : Architecture modulaire avec séparation claire entre systèmes (armes, ennemis, joueur, UI)
- Utilisation de groupes (`global_group`) pour la communication entre systèmes
- Système d'autoload pour les ressources partagées
- Gestion d'état centralisée

---

## 📦 Installation

### Prérequis
- [Godot Engine 4.4](https://godotengine.org/download) ou version supérieure
- Windows, Linux ou macOS

### Étapes d'installation

1. **Cloner le repository**
```bash
git clone https://github.com/Yezir971/3D-FPS.git
cd 3d_game/3d_game
```

2. **Ouvrir le projet dans Godot**
   - Lancez Godot Engine
   - Cliquez sur "Importer" ou "Ouvrir"
   - Sélectionnez le fichier `project.godot`

3. **Lancer le jeu**
   - Appuyez sur `F5` ou cliquez sur le bouton "Play" dans l'éditeur
   - La scène principale se chargera automatiquement

### Export

Le projet contient des presets d'export configurés dans `export_presets.cfg`. Vous pouvez exporter le jeu pour différentes plateformes via :
- **Projet → Exporter → [Plateforme]**

---

## 🎮 Contrôles

| Action | Touche |
|--------|--------|
| **Mouvement** | |
| Avancer | `Z` |
| Reculer | `S` |
| Gauche | `Q` |
| Droite | `D` |
| Sprint | `Shift` |
| jump   | `Space` |
| **Combat** | |
| Tirer | `Clic gauche` |
| Recharger | `R` ou `Clic droit` |
| **Armes** | |
| Arme 1 | `1` |
| Arme 2 | `2` |
| Arme 3 | `3` |
| Arme 4 | `4` |
| **Interface** | |
| Pause | `Échap` |

---

## 📁 Structure du projet

```
3d_game/
├── Resources/              # Ressources du jeu
│   ├── GunResource.gd     # Classe de ressource pour les armes
│   ├── Guns/              # Définitions d'armes (.tres)
│   ├── sound_guns/        # Sons d'armes
│   └── health_bar/        # Ressources UI
├── scenes/                # Scènes du jeu
│   ├── building/          # Éléments architecturaux
│   ├── ennemies/          # Ennemis (zombies, squelettes)
│   ├── guns/              # Système d'armes
│   ├── hud/               # Interface utilisateur
│   ├── loot/              # Système de loot
│   ├── menu/              # Menus
│   ├── player/            # Joueur
│   └── props/             # Objets décoratifs
├── script/                # Scripts GDScript
│   ├── gun_system.gd      # Système de tir
│   ├── weapon.gd          # Logique des armes
│   ├── bullet.gd          # Projectiles
│   ├── zombie.gd          # IA des ennemis
│   ├── hud.gd             # Interface
│   └── main.gd            # Logique principale
├── systems/               # Systèmes modulaires
│   └── gun_system.tscn    # Scène du système d'armes
├── models/                # Modèles 3D
│   ├── guns/              # Modèles d'armes
│   ├── ennemies/          # Modèles d'ennemis
│   ├── player/            # Modèle du joueur
│   └── props/             # Props 3D
├── addons/                # Extensions
├── sound/                 # Musiques
└── project.godot          # Configuration du projet
```

---

## 🎓 Compétences démontrées

Ce projet met en évidence les compétences suivantes :

### Développement de jeux vidéo
- ✅ Maîtrise de Godot Engine 4.4 et GDScript
- ✅ Développement de mécaniques de jeu 3D complexes
- ✅ Gestion de la physique et des collisions
- ✅ Implémentation de systèmes d'IA pour ennemis
- ✅ Création de systèmes modulaires et extensibles

### Architecture logicielle
- ✅ Design patterns adaptés au développement de jeux
- ✅ Séparation des responsabilités (SRP)
- ✅ Système de ressources modulaire
- ✅ Communication inter-systèmes efficace

### Optimisation et performance
- ✅ Gestion efficace des ressources
- ✅ Optimisation du rendu 3D
- ✅ Gestion de la mémoire

### Game Design
- ✅ Conception de mécaniques de gameplay équilibrées
- ✅ Création d'une expérience utilisateur fluide
- ✅ Design d'interface utilisateur intuitive

---

## 🚀 Améliorations futures

- [ ] Système de progression et d'expérience
- [ ] Plusieurs niveaux avec difficulté croissante
- [ ] Système de sauvegarde
- [ ] Mode multijoueur
- [ ] Plus de variétés d'ennemis
- [ ] Système de crafting
- [ ] Amélioration des effets visuels (particules, shaders)

---

## 📝 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

---

## 👤 Auteur

**Ahmedaly James**
- Portfolio : [https://james-ahmedaly.com](https://james-ahmedaly.com)
- LinkedIn : [https://www.linkedin.com/in/james-ahmedaly-7523092a5/](https://www.linkedin.com/in/james-ahmedaly-7523092a5/)
- Email : james_ahmedaly@yahoo.com

---

## 🙏 Remerciements

- **Godot Engine** pour le moteur de jeu open-source
- **Kenney** pour les assets de particules

---

<div align="center">

**Développé avec ❤️ en utilisant Godot Engine**

⭐ Si ce projet vous a plu, n'hésitez pas à laisser une étoile !

</div>
