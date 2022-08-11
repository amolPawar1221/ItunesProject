//
//  MovieSearchView.swift
//  ITuesProject
//
//  Created by Amol Pawar on 01/08/22.
//

import SwiftUI

struct MovieSearchView: View {

    @StateObject var viewModel = MovieViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.serachTerm.isEmpty {
                    AlbumPlaceholderView(searchTerm: $viewModel.serachTerm)
                } else {
                    MovieView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.serachTerm)
            .navigationTitle("Search Movie")
        }
    }
}
