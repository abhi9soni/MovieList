//
//  MovieCVC.swift
//  MovieList
//
//  Created by Abhinav Soni on 04/03/25.
//

import UIKit
import Kingfisher


class MovieCVC: UICollectionViewCell {

    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var btnMerchandise: UIButton!
    @IBOutlet weak var viewBtnMerchandiseBack: UIView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lblCertificate: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var viewSeperatorDot: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
      
          
    }
    func displayMovieData(_ item: Movie){
        self.lblMovieName.text = item.title
        self.lblCertificate.text = item.releaseDate
        
        self.lblLanguage.text = item.adult ?? false ? "A" : ""
        self.viewSeperatorDot.isHidden = item.adult ?? false ? false : true
        self.lblGenre.text = ""
        let imgPath = "https://image.tmdb.org/t/p/w500\(item.posterPath ?? "")"
        self.imgBanner.kf.setImage(with: URL(string: imgPath) , placeholder: UIImage(named: "placeholderHorizontal") )
//        https://image.tmdb.org/t/p/w500/mQZJoIhTEkNhCYAqcHrQqhENLdu.jpg

    }
}
