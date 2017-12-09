//
//  MovieCell.swift
//  popular-movies
//
//  Created by Robihamanto on 09/12/17.
//  Copyright © 2017 Robihamanto. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var moviePoster: UIImageView!
    
    func initData(_ imageName: String){
        self.moviePoster.image = UIImage(named: imageName)
        print("Init called")
    }
    
}
