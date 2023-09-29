//
//  ViewController.swift
//  MovieMang
//
//  Created by Jesse Hough on 09/19/23.
//

import UIKit

class TracksViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell

        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        
        let movie = movie[indexPath.row]

        cell.configure(with: movie)

        return cell
    }
    

    var movie: [Movie] = []

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=c29e64d7e7d75e4e19c2f444df09ef4d")!

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }

            guard let data = data else {
                print("❌ Data is nil")
                return
            }

            do {

                let decoder = JSONDecoder()
                
                let response = try decoder.decode(MovieResponse.self, from: data)
                
                let movies = response.results
                DispatchQueue.main.async {

                    self?.movie = movies

                    self?.tableView.reloadData()
                }
                print("✅ \(movies)")
            }
            catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }

        task.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? UITableViewCell,

           let indexPath = tableView.indexPath(for: cell),

           let detailViewController = segue.destination as? DetailViewController {

            let movie = movie[indexPath.row]

            detailViewController.movie = movie
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }



}
