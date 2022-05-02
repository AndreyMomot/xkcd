//
//  HomeViewModel.swift
//  xkcd
//
//  Created by Andrii Momot on 01.05.2022.
//

import Foundation

enum Request {
    case previous
    case next
    case random
}

protocol HomeViewModelProtocol {
    func search(for request: Request)
    func storeComics()
    func getStoredComics()
    
    var storedComicses: Bindable<[Comics]> { get}
    var comics: Bindable<Comics> { get }
    var error: Bindable<Error> { get }
}

final class HomeViewModel: HomeViewModelProtocol {
    private let api: API
    private let storage: Storable
    let storedComicses = Bindable<[Comics]>()
    let comics = Bindable<Comics>()
    let error = Bindable<Error>()
    private var random: Int {
        return Int.random(in: 1..<2613)
    }
    
    init(with api: API, storage: Storable) {
        self.api = api
        self.storage = storage
    }
    
    func storeComics() {
        guard let comicsToStore = comics.value else { return }
        switch comicsToStore.isStored {
        case false:
            storage.store(comicsToStore)
            comics.value?.isStored = true
        case true:
            storage.remove(comicsToStore)
            comics.value?.isStored = false
        }
        getStoredComics()
    }
    
    func getStoredComics() {
        storedComicses.value = storage.getItems()
    }
    
    func search(for request: Request) {
        var id = comics.value?.id ?? random
        switch request {
        case .previous:
            id -= 1
        case .next:
            id += 1
        case .random:
            id = random
        }
        
        storedComicses.value?.forEach { storedComics in
            if storedComics.id == id {
                var stored = storedComics
                stored.isStored = true
                comics.value = stored
                return
            }
        }
        
        guard comics.value?.id != id else { return }
        
        let request = SearchRequest(id: id)
        api.send(request) {[weak self] result  in
            switch result {
            case .success(let response):
                self?.comics.value = response
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
}
