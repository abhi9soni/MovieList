//
//  SearchViewController.swift
//  MovieList
//
//  Created by Abhinav Soni on 03/03/25.
//

import UIKit
import Kingfisher

// MARK: - Search View Controller
/// ViewController responsible for searching and displaying movies.
class SearchViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewSearchBack: UIView!
    @IBOutlet weak var viewNoDataFound: UIView!
    @IBOutlet weak var txtFieldSearch: UITextField!
    
    // MARK: - Properties
    /// ViewModel handling movie data fetching.
    var viewModel = MovieViewModel()
    
    /// ViewModel for managing favorites.
    var favViewModel = FavoritesViewModel()
    
    /// List of movies based on search results.
    var movieList = [Movie]()
    
    /// Full list of movies before filtering.
    var dummyMovieList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        fetchMovies()
    }
    
    // MARK: - UI Setup
    /// Configures the UI elements.
    func setupUI() {
        viewSearchBack.layer.cornerRadius = viewSearchBack.frame.height / 2
        viewSearchBack.layer.borderColor = UIColor.lightGray.cgColor
        viewSearchBack.layer.borderWidth = 1.0
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.Cell.MovieCVC, bundle: nil),
                                forCellWithReuseIdentifier: Constants.Cell.MovieCVC)
    }
    
    // MARK: - Fetch Movies
    /// Fetches movies for the search screen.
    func fetchMovies() {
        viewModel.searchMovies { status in
            if status {
                self.movieList = self.viewModel.movies
                self.dummyMovieList = self.viewModel.movies
                self.collectionView.reloadData()
            } else {
                print("Error fetching movies.")
            }
        }
    }
    
    // MARK: - Button Actions
    @IBAction func btnFavListAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: Constants.StoryBoard.Main, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Controller.FavViewController) as! FavViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func txtFieldTextChange(_ sender: UITextField) {
        guard let searchText = txtFieldSearch.text, !searchText.isEmpty else {
            movieList = dummyMovieList
            updateNoDataFoundView()
            collectionView.reloadData()
            return
        }
        
        movieList = dummyMovieList.filter { $0.title?.localizedCaseInsensitiveContains(searchText) ?? false }
        
        updateNoDataFoundView()
        collectionView.reloadData()
    }
    
    /// Updates the visibility of the "No Data Found" view.
    func updateNoDataFoundView() {
        viewNoDataFound.isHidden = !movieList.isEmpty
    }
    
    /// Handles the favorite button tap.
    @objc func btnLikeAction(_ sender: UIButton) {
        let movie = movieList[sender.tag]
        favViewModel.toggleFavorite(movie: movie)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cell.MovieCVC, for: indexPath) as! MovieCVC
        let movie = movieList[indexPath.item]
        cell.displayMovieData(movie)
        let isFavorite = FavoritesManager.shared.isFavorite(movie: movie)
        let imageName = isFavorite ? "heart.fill" : "heart"
        cell.btnLike.setImage(UIImage(systemName: imageName), for: .normal)
        cell.btnLike.tag = indexPath.row
        cell.btnLike.addTarget(self, action: #selector(btnLikeAction), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: 330)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Constants.StoryBoard.Main, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Controller.MovieDetailViewController) as! MovieDetailViewController
        vc.movieId = "\(movieList[indexPath.item].id)"
        navigationController?.pushViewController(vc, animated: true)
    }
}
