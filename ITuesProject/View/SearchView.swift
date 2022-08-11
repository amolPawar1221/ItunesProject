//
//  SearchView.swift
//  ITuesProject
//
//  Created by Amol Pawar on 02/08/22.
//

import SwiftUI

struct SearchView: View {

    @ObservedObject var songViewModel = SongViewModel()
    @ObservedObject var movieViewModel = MovieViewModel()
    @ObservedObject var albumViewModel = AlbumViewModel()

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                HStack {
                    Text("Songs")
                        .font(.title2)
                    Spacer()
                    NavigationLink {
                        SongView(viewModel: songViewModel)
                    } label: {
                        HStack {
                            Text("See all")
                            Image("chevronn.right")
                        }
                    }
                }
                .padding()

                SongSectionView(songs: songViewModel.songs)
                Divider()

                HStack {
                    Text("Albums")
                        .font(.title2)
                    Spacer()
                    NavigationLink {
                        AlbumView(viewModel: albumViewModel)
                    } label: {
                        HStack {
                            Text("See all")
                            Image("chevronn.right")
                        }
                    }
                }
                .padding()

                AlbumSectionView(albums: albumViewModel.albums)
                Divider()

                HStack {
                    Text("Movies")
                        .font(.title2)
                    Spacer()
                    NavigationLink {
                        MovieView(viewModel: movieViewModel)
                    } label: {
                        HStack {
                            Text("See all")
                            Image("chevron.right")
                        }
                    }
                }
                .padding()

                MovieSectionView(movies: movieViewModel.movies)
                Divider()
                
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
