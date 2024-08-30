//
//  MainRouter.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 23.08.2024.
//

import Foundation
import UIKit // ?

class MainRouter: MainRouterProtocol {
    
    weak var viewController: MainViewController?
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func showAddNewItemScene() {
        // todo
    }
    
    func showEditItemScene(for todoItem: TodoItem) {
        let editVC = EditItemViewController()
        let editConfigurator: EditItemConfiguratorProtocol = EditItemConfigurator()
        editConfigurator.configure(viewController: editVC, with: todoItem)
        viewController?.navigationController?.pushViewController(editVC, animated: true)
    }
}
