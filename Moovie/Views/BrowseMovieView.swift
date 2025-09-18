//
//  BrowseView.swift
//  Moovie
//
//  Created by Vena Feranica on 13/09/25.
//

import SwiftUI

struct BrowseMovieView: View {
    
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var upcomingState = MovieListState()
    @ObservedObject private var popularState = MovieListState()
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    ZStack {
                        if nowPlayingState.movies != nil {
                            PosterCarouselView(title: "Now Playing", movies: nowPlayingState.movies ?? Movie.stubbedMovies)
                        } else {
                            ProgressView()
                        }
                    }
                    
                }
                .task {
                    await nowPlayingState.loadMovies(with: MovieEndpoint.nowPlaying)
                }
                Group {
                    ZStack {
                        if popularState.movies != nil {
                            PosterCarouselView(title: "Popular", movies: popularState.movies ?? Movie.stubbedMovies)
                        } else {
                            ProgressView()
                        }
                    }
                }
                .task {
                    await popularState.loadMovies(with: MovieEndpoint.popular)
                }
                
                Group {
                    ZStack {
                        if upcomingState.movies != nil {
                            PosterCarouselView(title: "Upcoming", movies: upcomingState.movies ?? Movie.stubbedMovies)
                        } else {
                            ProgressView()
                        }
                    }
                }
                .task {
                    await upcomingState.loadMovies(with: MovieEndpoint.upcoming)
                }
            }
            .listStyle(.plain)
        }
    }
    
}

#Preview {
    BrowseMovieView()
}
