//
//  Comics.swift
//  xkcd
//
//  Created by Andrii Momot on 01.05.2022.
//

import Foundation

struct Comics: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let image: String?
    var isStored: Bool = false
    
    private enum CodingKeys : String, CodingKey {
        case id = "num", title, description = "alt", image = "img"
    }
}
