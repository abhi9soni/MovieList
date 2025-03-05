//
//  MovieDetailTVC.swift
//  MovieList
//
//  Created by Abhinav Soni on 04/03/25.
//

import UIKit

class MovieDetailTVC: UITableViewCell {
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblAvailableLng: UILabel!
    @IBOutlet weak var lblFormat: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var viewLineSeprator: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func displayMovieData(_ item: MovieDetail){
        self.viewLineSeprator.isHidden = true
        self.lblRating.text = "U"
        self.lblReleaseDate.text = item.releaseDate
        let arrLang = item.spokenLanguages ?? [SpokenLanguage]()
        var arr = [String]()
        for i in arrLang{
            arr.append(i.englishName ?? "")
        }
        self.lblAvailableLng.text = arr.joined(separator: ", ")
        
        
        self.lblFormat.text = item.title
        self.lblDuration.text = "\(item.runtime ?? 0) min"
      

    }
  
    
}
