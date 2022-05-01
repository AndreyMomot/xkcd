//
//  Storable.swift
//  xkcd
//
//  Created by Andrii Momot on 01.05.2022.
//

import Foundation

protocol Storable {
    func store<T: Codable>(_ item: T) where T: Identifiable
    func getItems<T: Decodable>() -> [T] where T: Identifiable
    func remove<T: Codable>(_ item: T) where T: Identifiable
}
