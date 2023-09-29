//
//  MovieCell.swift
//  MovieMang
//
//  Created by Jesse Hough on 9/19/23.
//
import Nuke
import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var posterPath: UIImageView!
    
    @IBOutlet weak var originalTitle: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    func configure(with movie: Movie) {
        originalTitle.text = movie.original_title
        releaseDate.text = movie.release_date

        if let posterPathURL = movie.fullPosterURL?.absoluteString, let url = URL(string: posterPathURL) {
                let request = ImageRequest(url: url)
                Nuke.loadImage(with: request, into: posterPath)
        }


    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
