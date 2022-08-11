//
//  EntityType.swift
//  ITuesProject
//
//  Created by Amol Pawar on 01/08/22.
//

import Foundation

enum EntityType: String, CaseIterable {
    case all
    case album
    case movie
    case song

    func name() -> String {

        switch self {
        case .album:
            return "Album"
        case .song:
            return "Song"
        case .movie:
            return "Movie"
        case .all:
            return "All"
        }
    }
}
