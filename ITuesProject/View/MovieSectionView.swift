//
//  MovieSectionView.swift
//  ITuesProject
//
//  Created by Amol Pawar on 05/08/22.
//

import SwiftUI

struct MovieSectionView: View {
    let movies: [Movie]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top) {
                ForEach(movies) { movie in
                    VStack(alignment: .leading) {
                        ImageLoadingView(urlString: movie.artworkUrl100, size: .init(width: 100, height: 100))
                        Text(movie.trackName ?? "")
                        Text(movie.artistName ?? "")
                            .foregroundColor(.gray)
                    }
                    .lineLimit(2)
                    .frame(width: 100)
                    .font(.caption)
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct MovieSectionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSectionView(movies: Movie.loadData())
    }
}
