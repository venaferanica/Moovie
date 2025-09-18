//
//  PosterCardView.swift
//  Moovie
//
//  Created by Vena Feranica on 12/09/25.
//

import SwiftUI

struct PosterCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    
    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 230)
                        .cornerRadius(8)
                    
                
            }
            else {
                Rectangle()
                    .fill(.gray)
                    .frame(width: 150, height: 230)
                    .cornerRadius(20)
            }
        }
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.posterURL)
        }
    }
}

#Preview {
    PosterCard(movie: Movie.stubbedMovie)
}
