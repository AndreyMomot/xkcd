//
//  APITests.swift
//  xkcdTests
//
//  Created by Andrii Momot on 02.05.2022.
//

import XCTest
@testable import xkcd

class APITests: XCTestCase {
    let api: API = AppAPI()
    
    func testSearchResponse() {
        let expectation = self.expectation(description: "expectation")

        let request = SearchRequest(id: 615)
        api.send(request) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.id, 615)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
