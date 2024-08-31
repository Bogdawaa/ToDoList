//
//  EditItemPresenter.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 29.08.2024.
//

import Foundation

final class EditItemPresenter: EditItemPresenterProtocol {
    
    weak var view: EditItemViewProtocol?
    var interactor: EditItemInteractorInputProtocol?
    var router: EditItemRouterProtocol?
    
    func viewDidLoad() {
        if let todoItem = interactor?.todoItem {
            view?.showTodoItem(todoItem)
        }
    }
    
    func editAndSaveTodoItem(title: String, description: String?, isCompleted: Bool) {
        interactor?.editAndSaveTodoItem(
            title: title,
            description: description,
            isCompleted: isCompleted
        )
    }
}

extension EditItemPresenter: EditItemInteractorOutputProtocol {
    func didEditAndSaveTodoItem() {
        if let view = view {
            router?.navigateBackToMainView(from: view)
        }
    }
}
