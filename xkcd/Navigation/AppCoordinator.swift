//
//  AppCoordinator.swift
//  xkcd
//
//  Created by Andrii Momot on 01.05.2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    let api: API
    let storage: Storable
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private let homeCoordinator: HomeCoordinator
    
    // MARK: - Place to declare initial viewCOntroller
    init(window: UIWindow) {
        self.window = window
        api = AppAPI()
        storage = Storage()
        rootViewController = UINavigationController()
        
        homeCoordinator = HomeCoordinator(presenter: rootViewController, api: api, storage: storage)
    }
    
    func start() {
        window.rootViewController = rootViewController
        homeCoordinator.start()
        window.makeKeyAndVisible()
    }
}
