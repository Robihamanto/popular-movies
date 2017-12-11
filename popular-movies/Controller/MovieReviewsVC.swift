//
//  MovieReviewsVC.swift
//  popular-movies
//
//  Created by Robihamanto on 10/12/17.
//  Copyright © 2017 Robihamanto. All rights reserved.
//

import UIKit
import Alamofire

class MovieReviewsVC: UIViewController {
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    var movieReviews = [Review]()

    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
    }
    
    func initData(_ data: [Review]) {
        self.movieReviews = data
    }
    
}

extension MovieReviewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: "reviewCell") as? ReviewCell else { return ReviewCell()}
        cell.updateView(movieReviews[indexPath.row].author, movieReviews[indexPath.row].review)
        return cell
    }
    
    
}
