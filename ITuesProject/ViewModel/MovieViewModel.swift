//
//  MovieViewModel.swift
//  ITuesProject
//
//  Created by Amol Pawar on 01/08/22.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var state: FetchState = .good
    @Published var serachTerm: String = ""

    private var subs = Set<AnyCancellable>()
    private var networkService: NetworkService

    init(networkService: NetworkService = NetworkManager.shared) {

        self.networkService = networkService

        $serachTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { term in
                Task { [weak self] in
                    DispatchQueue.main.async { [weak self] in
                        self?.state = .good
                        self?.movies = []
                    }
                    await self?.getAlbum(for: term)
                }
            }.store(in: &subs)
    }

    func loadMore() async {
        await getAlbum(for: serachTerm)
    }

    func getAlbum(for serachText: String = "") async {
        guard !serachText.isEmpty else {
            return
        }
        guard state == .good else {
            return
        }

        DispatchQueue.main.async {
            self.state = .Loading
        }

        let url = Endpoint.search(matching: serachText, page: nil, entity: .song).url

        let result = await networkService.getAPI(url: url, responseModel: MovieModel.self)
        switch result {
        case .success(let model):
            DispatchQueue.main.async {
                self.movies = model.movies
                self.state = .good
            }
        case .failure(let error):
            DispatchQueue.main.async {
                self.state = .error(error.localizedDescription)
            }
        }
    }

    static func example() -> MovieViewModel {
        let vm = MovieViewModel()
        vm.movies = Movie.loadData()
        return vm
    }
}

