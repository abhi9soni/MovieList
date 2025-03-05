//
//  ViewController.swift
//  MovieList
//
//  Created by Abhinav Soni on 03/03/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnGoAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    

}

