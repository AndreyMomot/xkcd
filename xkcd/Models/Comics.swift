//
//  Comics.swift
//  xkcd
//
//  Created by Andrii Momot on 01.05.2022.
//

import Foundation

struct Comics: Decodable {
    let id: Int
    let title: String
    let description: String?
    let image: String?
    
    private enum CodingKeys : String, CodingKey {
        case id = "num", title, description = "alt", image = "img"
    }
}
