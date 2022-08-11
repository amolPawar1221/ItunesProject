//
//  NetworkError.swift
//  ITuesProject
//
//  Created by Amol Pawar on 01/08/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case apiError(String)
    case statusisnotOK
    case encodingFailed
}
