//
//  AlbumView.swift
//  ITuesProject
//
//  Created by Amol Pawar on 31/07/22.
//

import SwiftUI

struct AlbumView: View {
    @ObservedObject var viewModel: AlbumViewModel = AlbumViewModel()

    var body: some View {

            List {
                ForEach(viewModel.albums) { album in
                    HStack() {
                        ImageLoadingView(urlString: album.artworkUrl100, size: .init(width: 100, height: 100))
                        VStack(alignment: .leading) {
                            Text(album.collectionName ?? "")
                            Text(album.artistName ?? "")
                                .foregroundColor(.gray)
                        }
                        .font(.caption)
                        .lineLimit(2)

                        Spacer(minLength: 20)
                        BuyButton(urlString: album.collectionViewURL ?? "", price: album.collectionPrice, currency: album.currency ?? "")
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

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = AlbumViewModel.example()
        AlbumView(viewModel: vm)
    }
}
