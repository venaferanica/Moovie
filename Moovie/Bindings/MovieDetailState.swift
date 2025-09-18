//
//  MovieDetailState.swift
//  Moovie
//
//  Created by Vena Feranica on 16/09/25.
//

import SwiftUI

@MainActor
class MovieDetailState: ObservableObject {
    
    @Published var movie: Movie?
    @Published var isLoading: Bool = false
    @Published var error: NSError?
    
    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadMovie(id: Int) async {
    
        
        self.movie = nil
        self.isLoading = true
        self.error = nil
        
        
        do {
            let movie = try await self.movieService.fetchMovie(id: id)
            self.isLoading = false
            self.movie = movie
            
        } catch {
            self.isLoading = false
            self.error = error as NSError
        }
    }
    
}
