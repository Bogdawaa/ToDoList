//
//  AddItemConfigurator.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 31.08.2024.
//

import Foundation

final class AddItemConfigurator: AddItemConfiguratorProtocol {
    
    func configure(viewController: AddItemViewController) {
        let presenter: AddItemPresenterProtocol & AddItemInteractorOutputProtocol = AddItemPresenter()
        let interactor: AddItemInteractorInputProtocol = AddItemInteractor()
        let router = AddItemRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
    }
}
