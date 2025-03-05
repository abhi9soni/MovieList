//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Abhinav Soni on 04/03/25.
//

import UIKit

// MARK: - Movie Detail View Controller
/// ViewController responsible for displaying detailed information about a selected movie.
class MovieDetailViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLike: UIButton!
    var viewModel = MovieDetailViewModel()
    var favViewModel = FavoritesViewModel()
    var movieId = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieDetails()
    }
    
    // MARK: - Load Movie Details
    /// Fetches movie details using `viewModel`.
    func loadMovieDetails() {
        if !movieId.isEmpty {
            viewModel.movieDetailApi(movieId: movieId) { status in
                if status {
                    self.setupUI()
                    self.tableView.reloadData()
                } else {
                    print("Error fetching movie details.")
                }
            }
        }
    }
    
    // MARK: - Setup UI
    /// Configures UI elements and updates the like button state.
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.Cell.MovieDetailTVC, bundle: nil),
                           forCellReuseIdentifier: Constants.Cell.MovieDetailTVC)
        tableView.register(UINib(nibName: Constants.Cell.MoviePosterTVC, bundle: nil),
                           forCellReuseIdentifier: Constants.Cell.MoviePosterTVC)
        tableView.register(UINib(nibName: Constants.Cell.OverviewTVC, bundle: nil),
                           forCellReuseIdentifier: Constants.Cell.OverviewTVC)
        
        if let data = viewModel.moviesDetail {
            let movie = Movie(id: data.id ?? 0, title: data.title, adult: false,
                              originalTitle: data.originalTitle, overview: data.overview,
                              posterPath: data.posterPath, backdropPath: data.backdropPath,
                              releaseDate: data.releaseDate, voteAverage: 0,
                              voteCount: 0, popularity: 0, genreIDs: [])
            
            updateLikeButton(for: movie)
        }
    }
    
    // MARK: - Update Like Button State
    /// Updates the like button image based on whether the movie is in favorites.
    ///
    /// - Parameter movie: The movie to check for favorite status.
    func updateLikeButton(for movie: Movie) {
        let isFavorite = FavoritesManager.shared.isFavorite(movie: movie)
        let imageName = isFavorite ? "heart.fill" : "heart"
        btnLike.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    // MARK: - Button Actions
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    /// Toggles the favorite status of the movie.
    @IBAction func btnLikeAction(_ sender: UIButton) {
        if let data = viewModel.moviesDetail {
            let movie = Movie(id: data.id ?? 0, title: data.title, adult: false,
                              originalTitle: data.originalTitle, overview: data.overview,
                              posterPath: data.posterPath, backdropPath: data.backdropPath,
                              releaseDate: data.releaseDate, voteAverage: 0,
                              voteCount: 0, popularity: 0, genreIDs: [])
            
            favViewModel.toggleFavorite(movie: movie)
            updateLikeButton(for: movie)
            tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.MoviePosterTVC, for: indexPath) as! MoviePosterTVC
            if let data = viewModel.moviesDetail {
                cell.displayMovieData(data)
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.OverviewTVC, for: indexPath) as! OverviewTVC
            cell.lblPlotDetail.text = viewModel.moviesDetail?.overview
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.MovieDetailTVC, for: indexPath) as! MovieDetailTVC
            if let data = viewModel.moviesDetail {
                cell.displayMovieData(data)
            }
            return cell
        }
    }
}
