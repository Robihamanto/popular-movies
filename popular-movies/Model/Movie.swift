//
//  Movie.swift
//  popular-movies
//
//  Created by Robihamanto on 10/12/17.
//  Copyright © 2017 Robihamanto. All rights reserved.
//

import Foundation
import UIKit

class Movie {
    
    private (set) public var id: AnyObject
    private (set) public var title: AnyObject
    private (set) public var posterPath: AnyObject
    private (set) public var overview: AnyObject
    private (set) public var releaseDate: AnyObject
    private (set) public var posterImage: AnyObject
    
    init(_ id: AnyObject, _ title: AnyObject, _ posterPath: AnyObject, _ overview: AnyObject, _ releaseDate: AnyObject, _ posterImage: AnyObject) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.posterImage = posterImage
    }
    
    func addPoster(forPoster poster: UIImage){
        self.posterImage = poster
    }
}
