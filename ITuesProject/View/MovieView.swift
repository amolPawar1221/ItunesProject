//
//  MovieView.swift
//  ITuesProject
//
//  Created by Amol Pawar on 01/08/22.
//

import SwiftUI

struct MovieView: View {
    @ObservedObject var viewModel = MovieViewModel()

    var body: some View {
            List {
                ForEach(viewModel.movies) { movie in
                    HStack() {
                        ImageLoadingView(urlString: movie.artworkUrl100, size: .init(width: 100, height: 100))
                        VStack(alignment: .leading) {
                            Text(movie.trackName ?? "")
                            Text(movie.artistName ?? "")
                                .foregroundColor(.gray)
                            Text(movie.releaseDate ?? "")
                                .foregroundColor(.gray)
                        }
                        .font(.caption)
                        .lineLimit(2)

                        Spacer(minLength: 20)
                        BuyButton(urlString: movie.previewURL ?? "", price: movie.trackPrice, currency: movie.currency ?? "")
                    }
                }

                switch viewModel.state {
                case .good:
                    Color.clear
                        .onAppear {
                            Task {
                                await viewModel.loadMore()
                            }
                        }
                case .Loading:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(maxWidth: .infinity)
                case .AllLoaded:
                    Color.clear
                case .error(let error):
                    Text(error)
                        .foregroundColor(.pink)
                }
            }
            .listStyle(.plain)
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(viewModel: MovieViewModel.example())
    }
}
