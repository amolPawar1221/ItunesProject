//
//  SongViewModel.swift
//  ITuesProject
//
//  Created by Amol Pawar on 01/08/22.
//

import Foundation
import Combine

class SongViewModel: ObservableObject {
    @Published var songs: [Song] = []
    @Published var state: FetchState = .good
    @Published var serachTerm: String = ""

    private var page = 0
    private var limit = 20
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
                        self?.clear()
                    }
                    await self?.getSong(for: term)
                }
            }.store(in: &subs)

    }

    private func clear() {
        state = .good
        songs = []
        page = 0
    }

    func loadMore() async {
        await getSong(for: serachTerm)
    }

    func getSong(for serachText: String = "") async {
        guard !serachText.isEmpty else {
            return
        }
        guard state == .good else {
            return
        }

        DispatchQueue.main.async {
            self.state = .Loading
        }

        let url = Endpoint.search(matching: serachText, page: page, entity: .song).url

        let result = await networkService.getAPI(url: url, responseModel: SongModel.self)
        switch result {
        case .success(let model):
            DispatchQueue.main.async {
                for song in model.songs {
                    self.songs.append(song)
                }
                self.page += 1
                self.state = (model.songs.count == self.limit) ? .good : .AllLoaded
            }
        case .failure(let error):
            DispatchQueue.main.async {
                self.state = .error(error.localizedDescription)
            }
        }
    }

    static func example() -> SongViewModel {
        let vm = SongViewModel()
        vm.songs = Song.loadData()
        return vm
    }
}
