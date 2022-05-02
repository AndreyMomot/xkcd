//
//  xkcdTests.swift
//  xkcdTests
//
//  Created by Andrii Momot on 01.05.2022.
//

import XCTest
@testable import xkcd

class xkcdTests: XCTestCase {

    func testHomeCoordinator() {
        let bundle = Bundle(for: xkcdTests.self)
        guard let url = bundle.url(forResource: "comics", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(Comics.self, from: data)
            
            let nav = UINavigationController()
            let coordinator = DetailsCoordinator(presenter: nav, comics: response)
            coordinator.start()
            
            XCTAssertEqual(coordinator.detailsViewController?.viewModel?.comics.id, 615)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testDetailsViewModel() {
        let bundle = Bundle(for: xkcdTests.self)
        guard let url = bundle.url(forResource: "comics", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(Comics.self, from: data)
            
            let viewModel = DetailsViewModel(with: jsonData)
            let viewController = DetailsViewController.loadFromNib()
            viewController.viewModel = viewModel
            
            XCTAssertEqual(viewModel.comics.id, 615)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
