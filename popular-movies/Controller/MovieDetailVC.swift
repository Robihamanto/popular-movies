//
//  MovieDetailVC.swift
//  popular-movies
//
//  Created by Robihamanto on 10/12/17.
//  Copyright © 2017 Robihamanto. All rights reserved.
//

import UIKit
import Alamofire

class MovieDetailVC: UIViewController {

    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var synopsisTextView: UITextView!
    
    var movie: Movie!
    var movieReviews = [Review]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = movie.title as? String
        releaseDateLabel.text = movie.releaseDate as? String
        synopsisTextView.text = movie.overview as? String
        moviePosterImage.image = movie.posterImage as? UIImage
        retrieveReview(String(describing: movie.id))
    }
    
    @IBAction func reviewButtonDidTap(_ sender: Any) {
        performSegue(withIdentifier: "movieReview", sender: movieReviews)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let MovieReviewsVC = segue.destination as? MovieReviewsVC else { return }
        MovieReviewsVC.initData((sender as? [Review])!)
    }
    
    func initMovieDetail(_ movie: Movie) {
        self.movie = movie
        navigationItem.backBarButtonItem?.title = ""
        navigationItem.title = movie.title as? String
    }
    
    func retrieveReview(_ movieId: String) {
        Alamofire.request(movieReview(forApiKey: apiKey, forMovieId: movieId)).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String, AnyObject> else { return }
            let reviewDict = json["results"] as! [Dictionary<String, AnyObject>]
            for reviews in reviewDict {
                let review = Review(reviews["author"]!, reviews["content"]!)
                self.movieReviews.append(review)
            }
        }
    }
    
    
    
    
}
