//
//  AlbumSearchView.swift
//  ITuesProject
//
//  Created by Amol Pawar on 01/08/22.
//

import SwiftUI

struct AlbumSearchView: View {

    @StateObject var viewModel = AlbumViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.serachTerm.isEmpty {
                    AlbumPlaceholderView(searchTerm: $viewModel.serachTerm)
                } else {
                    AlbumView(viewModel: viewModel)
                }
            }
            .navigationTitle("Search Album")
            .searchable(text: $viewModel.serachTerm)
        }
    }
}

struct AlbumPlaceholderView: View {
    @Binding var searchTerm: String
    let suggestions = ["rammstain", "cry to me", "maneski"]

    var body: some View {
        VStack(spacing: 20) {
            Text("Treding")
                .font(.title)
            ForEach(suggestions, id: \.self) { text in
                Button {
                    searchTerm = text
                } label: {
                    Text(text)
                        .font(.title2)
                }
            }
        }
    }
}
