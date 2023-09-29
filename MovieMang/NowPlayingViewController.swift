//
//  NowPlayingViewController.swift
//  MovieMang
//
//  Created by Jesse Hough on 9/27/23.
//

import UIKit
import Nuke

class NowPlayingViewController: UIViewController, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        movies.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCell", for: indexPath) as! NowPlayingCell

          
           let movies = movies[indexPath.item]

           
        if let imageUrl = movies.fullPosterURL {
            Nuke.loadImage(with: imageUrl, into: cell.nowPlayingImageView)
        }


           return cell
    }
    

    
    let apiKey = "c29e64d7e7d75e4e19c2f444df09ef4d"
    
    
    var movies: [NowPlaying] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNowPlayingMovies()
        
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        layout.minimumInteritemSpacing = 0

        layout.minimumLineSpacing = 0

        let numberOfColumns: CGFloat = 2

        let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 2)) / numberOfColumns

        layout.itemSize = CGSize(width: width, height: width)    }
    
    func fetchNowPlayingMovies() {
        let baseURL = "https://api.themoviedb.org/3/movie/now_playing"
        let urlString = "\(baseURL)?api_key=\(apiKey)"
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("No data received.")
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(NowPlayingSearchResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self?.movies = response.results
                        
                        self?.collectionView.reloadData()
                        
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
}
