//
//  MainPresenter.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 23.08.2024.
//

import Foundation

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
    var router: MainRouterProtocol?
    
    func viewWillAppear() {
        interactor?.getTodoList()
    }
    
    func editTodoItemClicked(todoItem: TodoItem) {
        router?.showEditItemScene(for: todoItem)
    }
    
    func addTodoItemClicked() {
        router?.showAddNewItemScene()
    }
    
    func removeTodoItem(_ todoItem: TodoItem) {
        interactor?.removeTodoItem(todoItem)
    }
}

extension MainPresenter: MainInteractorOutputProtocol {
    
    func didGetTodoList(_ todoList: [TodoItem]) {
        view?.showTodoList(todoList)
    }
    
    func didRemoveTodoItem(_ todoItem: TodoItem) {
        interactor?.getTodoList()
    }
    
    func onError(errorMessage: String) {
        view?.showErrorAllert(errorMessage)
    }
}
