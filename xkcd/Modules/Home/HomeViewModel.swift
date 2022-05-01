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
    
    var comics: Bindable<Comics> { get }
    var error: Bindable<Error> { get }
}

final class HomeViewModel: HomeViewModelProtocol {
    private let api: API
    let comics = Bindable<Comics>()
    let error = Bindable<Error>()
    private var random: Int {
        return Int.random(in: 1..<2613)
    }
    
    init(with api: API) {
        self.api = api
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
