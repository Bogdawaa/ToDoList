//
//  MainRouter.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 23.08.2024.
//

import Foundation

class MainRouter: MainRouterProtocol {
    
    weak var viewController: MainViewController?
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController?.dismiss(animated: true)
    }
}
