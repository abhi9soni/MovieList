# MovieList

# Movie App

## Overview
Movie App is an iOS application that fetches and displays movie details using The Movie Database (TMDB) API. Users can browse movies, view details, and manage their favorite movies using Core Data.

## Features
- Fetch and display movies from TMDB API
- View movie details
- Add and remove movies from favorites using Core Data
- Asynchronous networking with `URLSession`
- MVVM architecture for better code organization

## Prerequisites
- macOS with Xcode installed (Xcode 14+ recommended)
- Swift 5+
- iOS 14+
- Cocoapods (if dependencies are managed via pods)

## Setup Instructions
### 1. Clone the Repository
```sh
git clone https://github.com/abhi9soni/MovieList.git
cd MovieList
```

### 2. Install Dependencies
If the project uses CocoaPods, run:

pod install

Then, open the ".xcworkspace" file:

open MovieList.xcworkspace


### 3. Setup API Key
1. Get an API key from [TMDB](https://www.themoviedb.org/).
2. Create a "Constants.swift" file in the project and add:

struct Constants {
    static let apiKey = "YOUR_API_KEY"
    static let baseUrl = "https://api.themoviedb.org/3/"
}


### 4. Run the App
Select a simulator or a connected iOS device, then click **Run** (Cmd + R).

## Project Structure

MovieApp/
│── Models/              # Data models
│── ViewModels/          # Business logic and API calls
│── Views/               # UI components
│── Services/            # API and Core Data handling
│── Resources/           # Assets and supporting files
│── MovieApp.xcodeproj   # Xcode project file


## API Integration
Movie data is fetched using "MovieService". Example API call:

let movies = try await MovieService.shared.movieList(endPoint: "movie/popular")


## Core Data for Favorites
- "FavoritesManager" handles adding, removing, and fetching favorite movies.
- Example of adding a favorite movie:

FavoritesManager.shared.addFavorite(movie: selectedMovie)




## Troubleshooting
### 1. CocoaPods Issues
If you face errors with CocoaPods, try:

pod repo update
pod install --verbose

### 2. API Key Not Working
Ensure your TMDB API key is correctly added to "Constants.swift".

Made by Abhinav Soni

