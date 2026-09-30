# Movie App

A modern Flutter movie application built with **TMDB API**, **Firebase Authentication**, and **Cloud Firestore**.

The app allows users to discover movies, search for their favorite movies, view detailed information, and save movies to a personal wishlist.

---

## Features

* User authentication with Firebase
* Google Sign-In
* Browse popular movies
* Browse top-rated movies
* Browse now-playing movies
* Browse upcoming movies
* Search movies
* Movie details
* Movie ratings and information
* Add movies to wishlist
* Remove movies from wishlist
* Wishlist stored per user using Firestore
* Responsive UI
* Clean and organized project structure
* State management using Bloc/Cubit
* Dependency injection using GetIt

---

## Screenshots

### Home

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/80dd6d8c-6182-449b-92be-bbdd9d55ba05" />
  <img width="250" src="https://github.com/user-attachments/assets/4bc8edcc-67f0-4b72-a1a4-623cfe5b65b0" />
</p>

### Movie Details

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/92bcf6f9-81ae-4336-8f0b-18740fec78a5" />
  <img width="250" src="https://github.com/user-attachments/assets/a27345a2-e7d0-4afd-bf64-fd7af6565b99" />
</p>

### Wishlist / Search

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/ab4549cf-8cda-4200-aa23-ab8b0bebbc71" />
</p>

---

## Tech Stack

### Frontend

* Flutter
* Dart
* Material Design
* Flutter ScreenUtil

### State Management

* Flutter Bloc
* Cubit

### Backend & Services

* Firebase Authentication
* Google Sign-In
* Cloud Firestore
* TMDB API

### Networking

* Dio
* REST API
* Flutter Dotenv

### Architecture & Tools

* Feature-based architecture
* Repository Pattern
* Dependency Injection
* GetIt
* Git & GitHub

---

## Architecture

The project follows a feature-based structure to keep the application organized and maintainable.

```text
lib/
│
├── core/
│   ├── di/
│   ├── network/
│   ├── routes/
│   ├── theme/
│   └── widgets/
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   └── presentation/
│   │
│   ├── home/
│   │   ├── data/
│   │   └── presentation/
│   │
│   ├── movie_details/
│   │   └── presentation/
│   │
│   └── wishlist/
│       ├── data/
│       └── presentation/
│
└── main.dart
```

---

## API

The application uses **The Movie Database (TMDB)** API to retrieve movie data.

The app uses endpoints for:

* Popular movies
* Top-rated movies
* Now-playing movies
* Upcoming movies
* Movie search
* Movie details

---

## Authentication

Firebase Authentication is used to handle user authentication.

Supported authentication methods:

* Email & Password
* Google Sign-In

User information is stored in Firestore after authentication.

---

## Wishlist

Each authenticated user has their own wishlist stored in Firestore.

```text
users
└── {userId}
    └── wishlist
        ├── {movieId}
        ├── {movieId}
        └── ...
```

Users can:

* Add a movie to their wishlist
* Remove a movie
* View all saved movies
* Open movie details directly from the wishlist

---

## Search

The home screen includes movie search using the TMDB search API.

The search feature includes a debounce mechanism to reduce unnecessary API requests while the user is typing.

---

## Movie Details

The movie details screen displays:

* Movie poster
* Backdrop
* Title
* Rating
* Vote count
* Release date
* Genres
* Tagline
* Overview
* Runtime
* Status
* Wishlist action

---

## Environment Variables

The TMDB access token is stored in a `.env` file instead of being hardcoded into the application.

Example:

```env
TMDB_ACCESS_TOKEN=your_tmdb_access_token
```

Make sure `.env` is included in `.gitignore` and never commit your real API credentials to GitHub.

---

## Installation

Clone the repository:

```bash
git clone YOUR_REPOSITORY_URL
```

Navigate to the project:

```bash
cd iti_training
```

Install dependencies:

```bash
flutter pub get
```

Create your `.env` file:

```env
TMDB_ACCESS_TOKEN=your_tmdb_access_token
```

Configure Firebase for your Flutter project and make sure the required Firebase configuration files are available.

Run the application:

```bash
flutter run
```

---

## Main Packages

```yaml
flutter_bloc
firebase_core
firebase_auth
cloud_firestore
google_sign_in
dio
get_it
flutter_dotenv
flutter_screenutil
```

---

## Project Goals

This project was built to practice and demonstrate:

* Flutter application development
* REST API integration
* Firebase Authentication
* Cloud Firestore
* State management with Bloc/Cubit
* Repository Pattern
* Dependency Injection
* Feature-based architecture
* Responsive UI
* Search and filtering
* Persistent user data

---

## Author

**John Adel**

Computer Science Student | Flutter Developer

[GitHub](https://github.com/johnadelm23-beep)

[LinkedIn](https://www.linkedin.com/in/john-adel-498910328/)

---

## License

This project is for educational and portfolio purposes.

```

ده هيبقى أنسب بكتير من الـ README الافتراضي، خصوصًا إن المشروع دلوقتي فيه Features حقيقية مش مجرد Flutter starter.
```
