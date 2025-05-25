# countries\_app

**countries\_app** est une application Flutter qui permet de rechercher et d’afficher des informations détaillées sur les pays, en s’appuyant sur l’API REST Countries.

## 📦 Structure du projet

```
countries_app/
├── android/               
├── ios/                
├── assets/              
│   └── json/
│       ├── countries.json 
│       └── loading.json 
├── lib/                    # Code source principal
│   ├── constants/          # Constantes de l’application
│   │   ├── colors.dart
│   │   ├── text.dart     
│   │   └── poppins_text_style.dart
│   ├── data/               # Couche d’accès aux données & logique métier
│   │   ├── country_remote_data_source.dart  # Implémentation de la récupération HTTP
│   │   └── country_data_controller.dart    # ChangeNotifier (Provider) pour gérer l’état
│   ├── models/             # Définition des modèles de données
│   │   ├── api_client.dart # Client HTTP (dio) générique
│   │   └── country.dart    # Classe Country avec ses attributs (nom, drapeau, etc.)
│   ├── widgets/            # Composants réutilisables
│   │   └── country_detailled_widget.dart    # Affichage des détails d’un pays
│   ├── views/            # Écrans de l’application
│   │   ├── welcome_screen.dart      # Écran d’accueil
│   │   └── country_search_screen.dart       # Recherche et résultats
│   └── main.dart           # Point d’entrée de l’application
├── test/                   # Tests unitaires
├── .env                    # Variables d’environnement (API keys, etc.)
├── pubspec.yaml            # Dépendances et configuration Flutter
└── README.md               
```

## 🏗️ Architecture

L’application suit une architecture **séparant clairement** trois couches :

1. **Modèle (models/)**

    * Représente les entités métier (`Country`).
2. **Données & Logique métier (data/)**

    * **CountryRemoteDataSource** : interface + implémentation pour interroger l’API REST Countries via `ApiClient`.
    * **CountryDataController** : étend `ChangeNotifier`, gère l’état de l’application (chargement, données récupérées, erreurs) et notifie l’UI.
3. **Présentation (screens/, widgets/)**

    * **country\_search\_screen** : écran principal avec un champ de recherche à suggestions (`flutter_typeahead`) et gestion des états (chargement, erreur, succès).
    * **country\_detailled\_widget** : composant dédié à l’affichage harmonieux des informations d’un pays (drapeau, nom, capitale, population, etc.).

La communication entre les couches se fait ainsi :

```
UI (écran) ----> CountryDataController (Provider) ----> CountryRemoteDataSource ----> ApiClient (HTTP)
         <---- notifications (ChangeNotifier)
```

## 🚀 Fonctionnalités principales

* **Recherche intelligente** : autocomplétion des noms de pays avec `flutter_typeahead`.
* **Affichage de détails** : drapeau (avec animation Hero si souhaité), nom officiel, capitale, région, population, langues, devises.
* **Gestion d’état** : indicateur de chargement (animation Lottie), messages d’erreur.
* **Séparation claire** : modèle, couche de données et présentation indépendants.
* **Styles unifiés** : constantes de couleur et typographie (Poppins).

## ⚙️ Installation & lancement

1. Cloner le projet :

   ```bash
   git clone https://github.com/ciajudith/countries_app.git
   cd countries_app
   ```
2. Installer les dépendances :

   ```bash
   flutter pub get
   ```
3. Lancer sur un simulateur ou un appareil :

   ```bash
   flutter run
   ```
   
## 📚 Ressources & API

* **REST Countries** : [https://restcountries.com/v3.1](https://restcountries.com/v3.1) (récupération des données de chaque pays)
* **Flutter TypeAhead** : [https://pub.dev/packages/flutter\_typeahead](https://pub.dev/packages/flutter_typeahead)
* **Lottie for Flutter** : [https://pub.dev/packages/lottie](https://pub.dev/packages/lottie)
* **Provider** : [https://pub.dev/packages/provider](https://pub.dev/packages/provider)

## 🤝 Contribution

Les contributions sont les bienvenues ! Pour proposer des améliorations :

1. Forkez le dépôt.
2. Créez une branche (`git checkout -b feature/ma-fonctionnalité`).
3. Committez vos modifications (`git commit -m 'Ajout : nouvelle fonctionnalité'`).
4. Pushez sur votre branche (`git push origin feature/ma-fonctionnalité`).
5. Ouvrez une Pull Request.



*ciajudith*
