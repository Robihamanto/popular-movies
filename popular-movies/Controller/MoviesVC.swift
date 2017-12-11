//
//  MoviesVC.swift
//  popular-movies
//
//  Created by Robihamanto on 09/12/17.
//  Copyright © 2017 Robihamanto. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MoviesVC: UIViewController {
    
    var moviesCollection: UICollectionView?
    var flowLayout = UICollectionViewFlowLayout()
    
    var screenSize = UIScreen.main.bounds
    var category: String = "popular"
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Popular"
        moviesCollection = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        moviesCollection?.register(MovieCell.self, forCellWithReuseIdentifier: "movieCell")
        moviesCollection?.delegate = self
        moviesCollection?.dataSource = self
        moviesCollection?.isScrollEnabled = true
        moviesCollection?.alwaysBounceVertical = true
        view.addSubview(moviesCollection!)
        
        retrieveUrls { (finished) in
            if finished {
                self.retrieveImage()
            }
        }
    }
    
    func retrieveImage() {
        self.retrieveImages(completion: { (finished) in
            if finished {
                self.moviesCollection?.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesCollection?.reloadData()
    }

    @IBAction func categoryBarButton(_ sender: Any) {
        let alertController = UIAlertController(title: "PICK CATEGORY", message: "Please choose category", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        let popular = UIAlertAction(title: "Popular Movie", style: .default) { (action) in
            self.category = "popular"
            self.navigationItem.title = "Popular"
            self.retrieveUrls(completion: { (finished) in
                self.retrieveImage()
            })
        }
        
        let topRated = UIAlertAction(title: "Upcoming Movie", style: .default) { (action) in
            self.category = "upcoming"
            self.navigationItem.title = "Upcoming"
            self.retrieveUrls(completion: { (finished) in
                self.retrieveImage()
            })
        }
        
        let nowPlaying = UIAlertAction(title: "Now Playing Movie", style: .default) { (action) in
            self.navigationItem.title = "Now Playing"
            self.category = "nowplaying"
            self.retrieveUrls(completion: { (finished) in
                self.retrieveImage()
            })
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(popular)
        alertController.addAction(topRated)
        alertController.addAction(nowPlaying)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getCategory() -> String {
        return self.category
    }
    
    func getUrl(_ category: String) -> String {
        if category == "popular" {
            return popularMovieUrl(forApiKey: apiKey)
        }
        
        if category == "upcoming" {
            return upcomingMovieUrl(forApiKey: apiKey)
        }
        
        if category == "nowplaying" {
            return nowPlayingMovieUrl(forApiKey: apiKey)
        }
        
        return "popular"
    }
    
    func retrieveUrls(completion: @escaping (_ finished: Bool) -> ()) {
        movies = []
        Alamofire.request(getUrl(getCategory())).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String, AnyObject> else { return }
            let moviesDict = json["results"] as! [Dictionary<String, AnyObject>]
            for movieDict in moviesDict {
                guard let movie = Movie(movieDict["id"]! , movieDict["title"]! , movieDict["poster_path"]! , movieDict["overview"]! , movieDict["release_date"]!, moviePoster(forApiKey: apiKey, forPosterPath: movieDict["poster_path"] as! String) as AnyObject) as? Movie else { return }
                self.movies.append(movie)
            }
            completion(true)
        }
    }
    
    func retrieveImages(completion: @escaping (_ finished: Bool) -> ()) {
        for movie in movies {
            let url = moviePoster(forApiKey: apiKey, forPosterPath: movie.posterPath as! String)
            Alamofire.request(url).responseImage(completionHandler: { (response) in
                guard let image = response.result.value else { return }
                movie.addPoster(forPoster: image)
            })
        }
        completion(true)
    }
    
}

extension MoviesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCell else { return MovieCell()}
        let imageForIndex = movies[indexPath.row].posterImage as? UIImage
        let imageView = UIImageView(image: imageForIndex)
        imageView.frame.size = cell.frame.size
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        cell.contentMode = UIViewContentMode.scaleAspectFill
        cell.clipsToBounds = true
        cell.addSubview(imageView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        performSegue(withIdentifier: "movieDetail", sender: movie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let MovieDetail = segue.destination as? MovieDetailVC {
            guard let movie = sender as? Movie else { return }
            MovieDetail.initMovieDetail(movie)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (screenSize.width/2)-5, height: (screenSize.height/3))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }    
    
}
