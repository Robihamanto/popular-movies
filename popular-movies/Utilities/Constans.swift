//
//  Constans.swift
//  popular-movies
//
//  Created by Robihamanto on 09/12/17.
//  Copyright © 2017 Robihamanto. All rights reserved.
//

import Foundation

let apiKey = "da209a7103025d781fc585c70b0816fb"

func popularMovieUrl(forApiKey apiKey: String) -> String {
    let url = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
    return url
}

func upcomingMovieUrl(forApiKey apiKey: String) -> String {
    let url = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=en-US&page=1"
    return url
}

func nowPlayingMovieUrl(forApiKey apiKey: String) -> String {
    let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=1"
    return url
}

func movieDetail(forApiKey apiKey: String, forMovieId movieId: String) -> String {
    let url = "https://api.themoviedb.org/3/movie/\(346364)?api_key=\(apiKey)&language=en-US"

    return url
}

func movieReview(forApiKey apiKey: String, forMovieId movieId: String) -> String {
    let url = "https://api.themoviedb.org/3/movie/\(movieId)/reviews?api_key=\(apiKey)&language=en-US&page=1"
    return url
}

func moviePoster(forApiKey apiKey: String, forPosterPath posterPath: String) -> String {
    let url = "https://image.tmdb.org/t/p/w1280/\(posterPath)"
    return url
}
