//
//  FetchState.swift
//  ITuesProject
//
//  Created by Amol Pawar on 01/08/22.
//

import Foundation

enum FetchState: Comparable {
    case good
    case Loading
    case AllLoaded
    case error(String)
}
