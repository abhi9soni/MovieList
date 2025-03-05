//
//  SearchViewController.swift
//  MovieList
//
//  Created by Abhinav Soni on 03/03/25.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var viewSearchBack: UIView!
    @IBOutlet weak var viewNoDataFound: UIView!
    @IBOutlet weak var txtFieldSearch: UITextField!
    var viewModel = MovieViewModel()
    var favViewModel = FavoritesViewModel()
    var movieList = [Movie]()
    var dummyMovieList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupUI()
        viewModel.searchMovies { status in
            if status{
                self.movieList = self.viewModel.movies
                self.dummyMovieList = self.viewModel.movies
                self.collectionView.reloadData()
            }else{
                print("XXXXXXX")
            }
        }
    }
    
    func setupUI(){
        self.viewSearchBack.layer.cornerRadius = viewSearchBack.frame.height / 2
        self.viewSearchBack.layer.borderColor = #colorLiteral(red: 0.8602910638, green: 0.8602909446, blue: 0.8602909446, alpha: 1)
        self.viewSearchBack.layer.borderWidth = 1.0
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "MovieCVC", bundle: nil), forCellWithReuseIdentifier: "MovieCVC")
        
    }
    @IBAction func btnFavListAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"FavViewController") as! FavViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func txtFieldTextChange(_ sender: UITextField) {
        self.movieList = self.dummyMovieList.filter{ dict in
            var v = true
            if ((!((self.txtFieldSearch.text?.isEmpty)!))){
                let ds = dict.title ?? ""
                v = (v && ((ds.localizedCaseInsensitiveContains(self.txtFieldSearch.text!))))
            }
            return v
        }
        
        print(self.movieList)
        print(self.dummyMovieList)
        if movieList.count > 0{
            self.collectionView.reloadData()
            self.viewNoDataFound.isHidden = true
        }else{
            self.viewNoDataFound.isHidden = false
        }
    }
    @objc func btnLikeAction(_ sender: UIButton) {
        let movie = self.movieList[sender.tag]
        self.favViewModel.toggleFavorite(movie: movie)
        self.collectionView.reloadData()
    }
}
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVC", for: indexPath) as! MovieCVC
        let data = movieList
        if data.count > 0{
            cell.displayMovieData(data[indexPath.item])
        }
        
        if FavoritesManager.shared.isFavorite(movie: movieList[indexPath.item]){
            cell.btnLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            cell.btnLike.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        cell.btnLike.tag = indexPath.row
        cell.btnLike.addTarget(self, action: #selector(btnLikeAction), for: .touchUpInside)
        return cell

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width/2 - 10, height: 330)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"MovieDetailViewController") as! MovieDetailViewController
        vc.movieId = "\(movieList[indexPath.item].id)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
