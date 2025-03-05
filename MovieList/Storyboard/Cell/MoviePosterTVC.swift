//
//  MoviePosterTVC.swift
//  MovieList
//
//  Created by Abhinav Soni on 04/03/25.
//

import UIKit

class MoviePosterTVC: UITableViewCell {
    //MARK: - UIImages
    @IBOutlet weak var imgMovie: UIImageView!
    
    //MARK: - UILabel
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblFormat4: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func displayMovieData(_ item: MovieDetail){
        self.lblMovieName.text = item.title
        let arrGenres = item.genres ?? [Genre]()
        var arrGenr = [String]()
        for i in arrGenres{
            arrGenr.append(i.name ?? "")
        }
        self.lblGenre.text = arrGenr.joined(separator: ", ")
        let imgPath = "https://image.tmdb.org/t/p/w500\(item.backdropPath ?? "")"
        self.imgMovie.kf.setImage(with: URL(string: imgPath) , placeholder: UIImage(named: "placeholderHorizontal") )

    }
    
}
