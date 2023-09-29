//
//  Movie.swift
//  MovieMang
//
//  Created by Jesse Hough on 09/19/23.
//

import Foundation

struct MovieResponse: Decodable {
    var results: [Movie]
}

struct Movie: Decodable {
    let adult: Bool
    let backdrop_path: String?
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String?
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
    
    var fullBackdropURL: URL? {
            guard let path = backdrop_path else { return nil }
            return URL(string: "https://image.tmdb.org/t/p/original" + path)
        }
    var fullPosterURL: URL? {
            guard let path = poster_path else { return nil }
            return URL(string: "https://image.tmdb.org/t/p/original" + path)
        }
    
}



