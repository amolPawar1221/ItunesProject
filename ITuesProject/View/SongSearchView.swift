//
//  SongSearchView.swift
//  ITuesProject
//
//  Created by Amol Pawar on 01/08/22.
//

import SwiftUI

struct SongSearchView: View {
    @StateObject var viewModel = SongViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.serachTerm.isEmpty {
                    AlbumPlaceholderView(searchTerm: $viewModel.serachTerm)
                } else {
                    SongView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.serachTerm)
            .navigationTitle("Search Song")
        }
    }
}

struct SongSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SongSearchView()
    }
}
