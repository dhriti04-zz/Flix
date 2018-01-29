//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Dhriti Chawla on 1/13/18.
//  Copyright © 2018 Dhriti Chawla. All rights reserved.
//

import UIKit
import AlamofireImage


class NowPlayingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: . valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        
        self.navigationItem.title = "Now Playing Movies"
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.tintColor = UIColor(red: 1.0, green: 0.25, blue: 0.75, alpha: 0.8)
            
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.gray.withAlphaComponent(0.5)
            shadow.shadowBlurRadius = 4
            navigationBar.titleTextAttributes = [
                NSAttributedStringKey.foregroundColor : UIColor(red: 0.5, green: 0.15, blue: 0.45, alpha: 0.8),
                NSAttributedStringKey.shadow : shadow
            ]
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 180
        
        fetchMovies()
        
        
        //        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        //        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        //        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        //        let task = session.dataTask(with: request) { (data, response, error) in
        //            // This will run when the network request returns
        //            if let error = error {
        //                print(error.localizedDescription)
        //            } else if let data = data {
        //                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        //
        //                // TODO: Get the array of movies
        //                // TODO: Store the movies in a property to use elsewhere
        //                // TODO: Reload your table view data
        //
        //                let movies = dataDictionary["results"] as! [[String: Any]]
        //
        //                self.movies = movies
        //
        //                self.tableView.reloadData()
        //
        //            }
        //        }
        //        task.resume()
        
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchMovies()
    }
    
    func fetchMovies(){
            // Start the activity indicator
            activityIndicator.startAnimating()
            
            
            let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { (data, response, error) in
                // This will run when the network request returns
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data
                    
                    let movies = dataDictionary["results"] as! [[String: Any]]
                    
                    self.movies = movies
                    
                    // Stop the activity indicator
                    // Hides automatically if "Hides When Stopped" is enabled
                    
                    self.activityIndicator.stopAnimating()
                    
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                    
                }
            }
            task.resume()
            
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movies.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
            
            let movie = movies[indexPath.row]
            
            let title = movie["title"] as! String
            let overview = movie["overview"] as! String
            
            cell.titleLabel.text = title
            cell.overviewLabel.text = overview
            
            let posterPathString = movie["poster_path"] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let posterURL = URL(string: baseURLString + posterPathString)!
            cell.myImageView.af_setImage(withURL: posterURL)
            
            
            return cell
            
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell){
            let movie = movies [indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
