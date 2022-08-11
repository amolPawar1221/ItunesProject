//
//  AlbumSectionView.swift
//  ITuesProject
//
//  Created by Amol Pawar on 05/08/22.
//

import SwiftUI

struct AlbumSectionView: View {
    let albums: [Album]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top) {
                ForEach(albums) { album in
                    VStack(alignment: .leading) {
                        ImageLoadingView(urlString: album.artworkUrl100, size: .init(width: 100, height: 100))
                        Text(album.collectionName ?? "")
                        Text(album.artistName ?? "")
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

struct AlbumSectionView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSectionView(albums: Album.loadData())
    }
}
