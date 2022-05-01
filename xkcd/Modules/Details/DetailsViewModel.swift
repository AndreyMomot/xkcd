//
//  DetailsViewModel.swift
//  xkcd
//
//  Created by Andrii Momot on 01.05.2022.
//

import Foundation

protocol DetailsViewModelProtocol {
    var comics: Comics { get }
}

final class DetailsViewModel: DetailsViewModelProtocol {
    let comics: Comics
    
    init(with comics: Comics) {
        self.comics = comics
    }
}
