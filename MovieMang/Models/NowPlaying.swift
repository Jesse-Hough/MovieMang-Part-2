//
//  File.swift
//  MovieMang
//
//  Created by Jesse Hough on 9/27/23.
//

import Foundation


struct NowPlayingSearchResponse: Decodable {
    let results: [NowPlaying]
}

struct NowPlaying: Decodable {
    
    let poster_path: String?
    
    var fullPosterURL: URL? {
            guard let path = poster_path else { return nil }
            return URL(string: "https://image.tmdb.org/t/p/original" + path)
    }
    
}
