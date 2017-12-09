//
//  MoviesVC.swift
//  popular-movies
//
//  Created by Robihamanto on 09/12/17.
//  Copyright © 2017 Robihamanto. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension MoviesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollection", for: indexPath) as? MovieCell else { return MovieCell()}
        cell.initData("Thor.jpg")
        return cell
    }
    
    
}
