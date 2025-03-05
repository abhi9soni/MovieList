//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Abhinav Soni on 04/03/25.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var btnLike: UIButton!
    var viewModel = MovieDetailViewModel()
    var favViewModel = FavoritesViewModel()
    var movieId = ""
    var addMore = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.movieId != ""{
            viewModel.movieDetailApi(movieId: self.movieId) { status in
                if status{
                    self.setupUI()
                    self.tableView.reloadData()
                }else{
                    print("XXXXXXX")
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MovieDetailTVC", bundle: nil), forCellReuseIdentifier: "MovieDetailTVC")
        self.tableView.register(UINib(nibName: "MoviePosterTVC", bundle: nil), forCellReuseIdentifier: "MoviePosterTVC")
        self.tableView.register(UINib(nibName: "OverviewTVC", bundle: nil), forCellReuseIdentifier: "OverviewTVC")
        if let data = self.viewModel.moviesDetail{
            let movie = Movie(id: data.id ?? 0, title: data.title, adult: false, originalTitle: data.originalTitle, overview: data.overview, posterPath: data.posterPath, backdropPath: data.backdropPath, releaseDate: data.releaseDate, voteAverage: 0, voteCount: 0, popularity: 0, genreIDs: [])
            if FavoritesManager.shared.isFavorite(movie: movie){
                self.btnLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }else{
                self.btnLike.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnLikeAction(_ sender: UIButton) {
        if let data = viewModel.moviesDetail{
            let movie = Movie(id: data.id ?? 0, title: data.title, adult: false, originalTitle: data.originalTitle, overview: data.overview, posterPath: data.posterPath, backdropPath: data.backdropPath, releaseDate: data.releaseDate, voteAverage: 0, voteCount: 0, popularity: 0, genreIDs: [])
            self.favViewModel.toggleFavorite(movie: movie)
            if FavoritesManager.shared.isFavorite(movie: movie){
                self.btnLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }else{
                self.btnLike.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            self.tableView.reloadData()
        }
    }
}
extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoviePosterTVC", for: indexPath) as! MoviePosterTVC
            if let data = viewModel.moviesDetail{
                cell.displayMovieData(data)
            }
            return cell
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTVC", for: indexPath) as! OverviewTVC
            cell.lblPlotDetail.text = viewModel.moviesDetail?.overview
            return cell
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailTVC", for: indexPath) as! MovieDetailTVC
            if let data = viewModel.moviesDetail{
                cell.displayMovieData(data)
            }
            return cell
        }
    }
}
