//
//  ContentView.swift
//  ITuesProject
//
//  Created by Amol Pawar on 31/07/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {

            AllSearchView()
                .tabItem {
                    Label("All", systemImage: "magnifyingglass")
                }

            AlbumSearchView()
                .tabItem {
                    Label("Album", systemImage: "music.note")
                }

            MovieSearchView()
                .tabItem {
                    Label("Movie", systemImage: "tv")
                }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
