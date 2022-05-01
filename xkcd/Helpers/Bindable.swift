//
//  Bindable.swift
//  xkcd
//
//  Created by Andrii Momot on 01.05.2022.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    private var observer: ((T?) -> Void)?
    
    func bind(_ observer: @escaping (T?) -> Void) {
        self.observer = observer
    }
}
