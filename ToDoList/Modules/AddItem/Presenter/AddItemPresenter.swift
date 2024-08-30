//
//  AddItemPresenter.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 30.08.2024.
//

import Foundation

final class AddItemPresenter: AddItemPresenterProtocol {
    
    weak var view: AddItemViewProtocol?
    var interactor: AddItemInteractorInputProtocol?
    var router: AddItemRouterProtocol?
    
    func editAndSaveTodoItem(title: String, description: String?) {
        interactor?.editAndSaveTodoItem(
            title: title,
            description: description
        )
    }
}

extension AddItemPresenter: AddItemInteractorOutputProtocol {
    func didEditAndSaveTodoItem(_ todoItem: TodoItem) {
        if let view = view {
            router?.navigateBackToMainView(from: view)
        }
    }
}
