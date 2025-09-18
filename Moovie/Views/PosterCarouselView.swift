//
//  PosterCarousel.swift
//  Moovie
//
//  Created by Vena Feranica on 12/09/25.
//

import SwiftUI

struct PosterCarouselView: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movies) { movie in
                        
                        NavigationLink {
                            MovieDetailView(movieId: movie.id)
                        } label: {
                            PosterCard(movie: movie)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PosterCarouselView(title: "Now Playing", movies: Movie.stubbedMovies)
}
