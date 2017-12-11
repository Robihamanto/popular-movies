//
//  Review.swift
//  popular-movies
//
//  Created by Robihamanto on 10/12/17.
//  Copyright © 2017 Robihamanto. All rights reserved.
//

import Foundation

class Review {
    private (set) public var author: String!
    private (set) public var review: String!
    
    init(_ author: AnyObject, _ review: AnyObject) {
        self.author = author as? String
        self.review = review as? String
    }
    
}
