//
//  DetailViewController.swift
//  MovieMang
//
//  Created by Jesse Hough on 09/19/23.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {

    @IBOutlet weak var posterPath: UIImageView!
    
    @IBOutlet weak var backdropPath: UIImageView!
    
    @IBOutlet weak var originalTitle: UILabel!
    
    @IBOutlet weak var voteAverage: UILabel!
    
    @IBOutlet weak var voteCount: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var overview: UILabel!
    

    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .systemGray6

        
        if let posterPathURL = movie.fullPosterURL?.absoluteString, let url = URL(string: posterPathURL) {
                let request = ImageRequest(url: url)
                Nuke.loadImage(with: request, into: posterPath)
            }

            // Safely unwrap backdrop_path and load image
        if let backdropPathURL = movie.fullBackdropURL?.absoluteString, let url = URL(string: backdropPathURL) {
                let request = ImageRequest(url: url)
                Nuke.loadImage(with: request, into: backdropPath)
            }
                
                let stringVoteAverage = "\(movie.vote_average)"
                let stringVoteCount = "\(movie.vote_count)"
                originalTitle.text = movie.original_title
                voteAverage.text = stringVoteAverage
                voteCount.text = stringVoteCount
                releaseDate.text = movie.release_date
                overview.text = movie.overview
            
            
        


        
    }



}
