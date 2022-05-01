//
//  Storage.swift
//  xkcd
//
//  Created by Andrii Momot on 01.05.2022.
//

import Foundation

final class Storage: Storable {
    let storage = UserDefaults.standard
    let key = "favourites"
    
    func store<T: Codable>(_ item: T) where T: Identifiable {
        var items: [T] = []

        if let data = storage.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let storedItems = try decoder.decode([T].self, from: data)
                items = storedItems
            } catch {
                print("Unable to Decode: (\(error))")
            }
        }
        
        guard !items.contains(where: { $0.id == item.id }) else { return }
        
        do {
            items.append(item)
            let encoder = JSONEncoder()
            let data = try encoder.encode(items)
            storage.set(data, forKey: key)
        } catch {
            print("Unable to Encode: (\(error))")
        }
    }
    
    func getItems<T: Decodable>() -> [T] where T: Identifiable {
        var items: [T] = []
        if let data = storage.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let storedItems = try decoder.decode([T].self, from: data)
                items = storedItems
            } catch {
                print("Unable to Decode: (\(error))")
            }
        }
        return items
    }
    
    func remove<T: Codable>(_ item: T) where T: Identifiable {
        var items: [T] = []

        if let data = storage.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let storedItems = try decoder.decode([T].self, from: data)
                items = storedItems
            } catch {
                print("Unable to Decode: (\(error))")
            }
        }
                
        do {
            items.removeAll(where: { $0.id == item.id })
            let encoder = JSONEncoder()
            let data = try encoder.encode(items)
            storage.set(data, forKey: key)
        } catch {
            print("Unable to Encode: (\(error))")
        }
    }
}
