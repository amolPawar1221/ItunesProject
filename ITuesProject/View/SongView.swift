//
//  SongView.swift
//  ITuesProject
//
//  Created by Amol Pawar on 01/08/22.
//

import SwiftUI

struct SongView: View {
    @ObservedObject var viewModel = SongViewModel()

    var body: some View {
            List {
                ForEach(viewModel.songs) { song in
                    SongRowView(song: song)
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

struct ImageLoadingView: View {

    let urlString: String?
    let size: CGSize

    var body: some View {
        AsyncImage(url: URL(string: urlString ?? "")){ phase in
            switch phase {
            case .empty:
                ProgressView()
            case .failure(_):
                Color.clear
            case .success(let image):
                image
                    .resizable()
                    .border(.white.opacity(0.8))
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: size.width, height: size.height)
    }
}

struct SongRowView: View {
    let song: Song

    var body: some View {
        HStack() {

            ImageLoadingView(urlString: song.artworkUrl60, size: .init(width: 60, height: 60))

            VStack(alignment: .leading) {
                Text(song.artistName ?? "")
                    .font(.title3)
                Text(song.collectionName ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
            }.lineLimit(2)

            Spacer()

            BuyButton(urlString: song.trackViewURL ?? "", price: song.trackPrice, currency: song.currency ?? "")
        }
    }
}

struct BuyButton: View {

    let urlString: String
    let price: Double?
    let currency: String

    var body: some View {
        if let url = URL(string: urlString), let price = price {
            Link(destination: url) {
                Text("\(Int(price)) \(currency)")
            }
            .buttonStyle(BuyButtonStyle())
        }
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView(viewModel: SongViewModel.example())
    }
}

