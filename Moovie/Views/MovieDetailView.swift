//
//  MovieDetailView.swift
//  Moovie
//
//  Created by Vena Feranica on 16/09/25.
//

import SwiftUI

struct MovieDetailView: View {
    let movieId: Int
    @ObservedObject var backdropImageLoader = ImageLoader()
    @ObservedObject var posterImageLoader = ImageLoader()
    
    @ObservedObject private var movieDetailState = MovieDetailState()
    
    var body: some View {
        ZStack {
            if movieDetailState.isLoading == true {
                ProgressView()
            } else if movieDetailState.error != nil {
                Text("Error occurred")
            } else if let movie = movieDetailState.movie {
                ScrollView {
                    VStack(alignment: .leading) {
                        MovieImageView(imageLoader: backdropImageLoader, imageURL: movie.backdropURL, mask: true)
                            .containerRelativeFrame(.vertical) { size, axis in
                                size * 0.3
                            }
                        
                        VStack (alignment: .leading, spacing: 24) {
                            HStack {
                                VStack (alignment: .leading, spacing: 16) {
                                    VStack (alignment: .leading) {
                                        Text(movie.title)
                                            .font(.title)
                                            .fontWeight(.bold)
                                        Text(movie.yearText)
                                    }
                                    .frame(maxWidth: 230, alignment: .leading)
                                    VStack (alignment: .leading) {
                                        Text("Directed by")
                                        if let directors = movie.directors, !directors.isEmpty {
                                            Text(directors.map { $0.name }.joined(separator: ", "))
                                                .fontWeight(.semibold)
                                        } else {
                                            Text("N/A")
                                        }
                                    }
                                    .frame(maxWidth: 230, alignment: .leading)
                                    
                                    
                                }
                                
                                Spacer()
                                MovieImageView(imageLoader: posterImageLoader, imageURL: movie.posterURL, mask: false)
                                    .frame(width: 100, height: 180)
                                    .shadow(radius: 8)
                                
                            }
                            .padding(.horizontal, 24)
                          
                           
                            Text(movie.overview)
                                .padding(.horizontal, 24)
                              
                        }
                        .padding(.horizontal, 24)
                    }
                }
                .ignoresSafeArea(.container, edges: .top)
            } else {
                Text("No data yet")
            }
        }
        .task {
            await movieDetailState.loadMovie(id: movieId)
        }
    }
}

struct MovieImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    let mask: Bool
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                let imageView = Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                
                
                if mask == true {
                    imageView.mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black.opacity(0.6), Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                    )
                } else {
                    imageView
                }
            }
        }
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

#Preview {
    MovieDetailView(movieId: Movie.stubbedMovie.id)
}


