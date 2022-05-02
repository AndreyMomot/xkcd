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
    private let storage: Storable
    private var homeViewController: HomeViewController?
    private var detailsCoordinator: DetailsCoordinator?
    
    init(presenter: UINavigationController, api: API, storage: Storable) {
      self.presenter = presenter
      self.api = api
        self.storage = storage
    }
    
    override func start() {
        let viewModel = HomeViewModel(with: api, storage: storage)
        let homeViewController = instantiate(HomeViewController.self)
        homeViewController.viewModel = viewModel
        homeViewController.onShowDetails = {[weak self] comics in
            self?.showDetails(with: comics)
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
