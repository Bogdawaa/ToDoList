//
//  EditItemConfigurator.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 29.08.2024.
//

import Foundation

final class EditItemConfigurator: EditItemConfiguratorProtocol {
    
    func configure(viewController: EditItemViewController, with todoItem: TodoItem) {
        let presenter: EditItemPresenterProtocol & EditItemInteractorOutputProtocol = EditItemPresenter()
        let interactor: EditItemInteractorInputProtocol = EditItemInteractor()
        let router = EditItemRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.todoItem = todoItem
    }
}
