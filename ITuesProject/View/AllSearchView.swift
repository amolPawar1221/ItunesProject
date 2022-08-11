//
//  AllSearchView.swift
//  ITuesProject
//
//  Created by Amol Pawar on 01/08/22.
//

import SwiftUI

struct AllSearchView: View {

    @State var searchTerm = ""
    @State var group: EntityType = EntityType.all

    @StateObject var songViewModel = SongViewModel()
    @StateObject var movieViewModel = MovieViewModel()
    @StateObject var albumViewModel = AlbumViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Picker(group.name(), selection: $group) {
                    ForEach(EntityType.allCases, id: \.self) { type in
                        Text(type.name())
                            .font(.title)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                Divider()

                if searchTerm.isEmpty {
                    AlbumPlaceholderView(searchTerm: $searchTerm)
                        .frame(maxHeight: .infinity)
                } else {
                    switch group {
                    case .all:
                        SearchView(songViewModel: songViewModel, movieViewModel: movieViewModel, albumViewModel: albumViewModel)
                            .frame(maxHeight: .infinity)
                            .onAppear {
                                songViewModel.serachTerm = searchTerm
                                movieViewModel.serachTerm = searchTerm
                                albumViewModel.serachTerm = searchTerm
                            }
                        Spacer()
                    case .song:
                        SongView(viewModel: songViewModel)
                            .onAppear {
                                songViewModel.serachTerm = searchTerm
                            }
                    case .movie:
                        MovieView(viewModel: movieViewModel)
                            .onAppear {
                                movieViewModel.serachTerm = searchTerm
                            }
                    case .album:
                        AlbumView(viewModel: albumViewModel)
                            .onAppear {
                                albumViewModel.serachTerm = searchTerm
                            }
                    }
                }
            }
            .searchable(text: $searchTerm)
            .navigationTitle("Search All")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: searchTerm) { newValue in
            switch group {
            case .all:
                songViewModel.serachTerm = newValue
                movieViewModel.serachTerm = newValue
                albumViewModel.serachTerm = newValue
            case .album:
                albumViewModel.serachTerm = newValue
            case .movie:
                movieViewModel.serachTerm = newValue
            case .song:
                songViewModel.serachTerm = newValue
            }

        }
    }
}

struct AllSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AllSearchView()
    }
}
