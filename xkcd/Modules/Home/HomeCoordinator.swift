//
//  HomeCoordinator.swift
//  xkcd
//
//  Created by Andrii Momot on 01.05.2022.
//

import UIKit

final class HomeCoordinator: BaseCoordinator {
    private let presenter: UINavigationController
    private let api: API
    private var homeViewController: HomeViewController?
    private var detailsCoordinator: DetailsCoordinator?
    
    init(presenter: UINavigationController, api: API) {
      self.presenter = presenter
      self.api = api
    }
    
    override func start() {
        let viewModel = HomeViewModel(with: api)
        let homeViewController = instantiate(HomeViewController.self)
        homeViewController.viewModel = viewModel
        homeViewController.onShowDetails = {[weak self] comics in
            DispatchQueue.main.async {
                self?.showDetails(with: comics)
            }
        }
        
        presenter.pushViewController(homeViewController, animated: true)
        
        self.homeViewController = homeViewController
    }
}

extension HomeCoordinator {
    
    func showDetails(with comics: Comics) {
        let detailsCoordinator = DetailsCoordinator(presenter: presenter, comics: comics)
        detailsCoordinator.start()
        
        self.detailsCoordinator = detailsCoordinator
    }
}
