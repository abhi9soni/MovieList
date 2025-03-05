//
//  FavViewController.swift
//  MovieList
//
//  Created by Abhinav Soni on 04/03/25.
//

import UIKit

class FavViewController: UIViewController {
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var viewNoDataFound: UIView!
    var movieList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.movieList = FavoritesManager.shared.getFavorites()
        print("self.movieList",self.movieList)
        setupUI()
    }
    func setupUI(){
        if movieList.count > 0{
            self.viewNoDataFound.isHidden = true
        }else{
            self.viewNoDataFound.isHidden = false
        }
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "MovieCVC", bundle: nil), forCellWithReuseIdentifier: "MovieCVC")
        self.collectionView.reloadData()
        
    }
    @objc func btnLikeAction(_ sender: UIButton) {
        let movie = self.movieList[sender.tag]
        FavoritesManager.shared.removeFavorite(movie: movie)
        self.viewWillAppear(true)
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension FavViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVC", for: indexPath) as! MovieCVC
        let data = movieList
        if data.count > 0{
            cell.displayMovieData(data[indexPath.item])
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
