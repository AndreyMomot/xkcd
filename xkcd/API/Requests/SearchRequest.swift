//
//  SearchRequest.swift
//  xkcd
//
//  Created by Andrii Momot on 01.05.2022.
//

import Foundation

struct SearchRequest: APIRequest {
    typealias Response = Comics
    
    var path: String {
        return "\(id)/info.0.json"
    }
    
    private(set) var id: Int
    
    init(id: Int) {
        self.id = id
    }
}

