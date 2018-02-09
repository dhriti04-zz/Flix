//
//  DetailViewController.swift
//  Flix
//
//  Created by Dhriti Chawla on 1/19/18.
//  Copyright © 2018 Dhriti Chawla. All rights reserved.
//

import UIKit
enum MovieKys {
    static let title = "title"
    static let posterPath = "poster_path"
}

class DetailViewController: UIViewController {

    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        if let movie = movie {
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            releaseDateLabel.text = movie.relDate
            let backdropURL = movie.backdropUrl
            backDropImageView.af_setImage(withURL: backdropURL!)
            let posterPathURL = movie.posterUrl
            posterImageView.af_setImage(withURL: posterPathURL!)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
