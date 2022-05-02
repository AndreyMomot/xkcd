//
//  DetailsCoordinator.swift
//  xkcd
//
//  Created by Andrii Momot on 01.05.2022.
//

import UIKit

final class DetailsCoordinator: BaseCoordinator {
    private let presenter: UINavigationController
    private let comics: Comics
    private var detailsViewController: DetailsViewController?

    init(presenter: UINavigationController, comics: Comics) {
      self.presenter = presenter
      self.comics = comics
    }
    
    override func start() {
        let viewModel = DetailsViewModel(with: comics)
        let viewController = instantiate(DetailsViewController.self)
        viewController.viewModel = viewModel
        
        presenter.pushViewController(viewController, animated: true)
        
        self.detailsViewController = viewController
    }
}
