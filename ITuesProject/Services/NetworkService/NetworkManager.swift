//
//  File.swift
//  ITuesProject
//
//  Created by Amol Pawar on 31/07/22.
//

import Foundation

protocol NetworkService {
    func getAPI<T: Decodable>(url: URL?, responseModel: T.Type) async -> Result<T, Error>
    func postAPI<T: Decodable, M: Encodable>(url: URL?, body: M, responseModel: T.Type) async -> Result<T, Error>
}

class NetworkManager: NetworkService {
    static let shared = NetworkManager()

    private init() { }

    func getAPI<T: Decodable>(url: URL?, responseModel: T.Type) async -> Result<T, Error> {
        await api(url: url, httpMethod: .GET, responseModel: responseModel)
    }

    func postAPI<T: Decodable, M: Encodable>(url: URL?, body: M, responseModel: T.Type) async -> Result<T, Error> {
        guard let requsetBody = try? JSONEncoder().encode(body) else {
            return .failure(NetworkError.encodingFailed)
        }
        return await api(url: url, httpMethod: .POST, body: requsetBody, responseModel: responseModel)
    }

    private func api<T: Decodable>(url: URL?, httpMethod: HttpMethod, body: Data? = nil, responseModel: T.Type) async -> Result<T, Error> {
        guard let url = url else {
            return .failure(NetworkError.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpBody = body
        request.url = url
        request.httpMethod = httpMethod.rawValue
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                return .failure(NetworkError.statusisnotOK)
            }
            let model = try JsonDecoderHandler.decodeData(type: responseModel, data: data)
            return .success(model)
        } catch(let erro) {
            return .failure(NetworkError.apiError(erro.localizedDescription))
        }
    }
}

class JsonDecoderHandler {
    static func decodeData<T: Decodable>(type: T.Type, data: Data) throws -> T {
         try JSONDecoder().decode(type, from: data)
    }
}
