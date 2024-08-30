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
    
    func viewDidLoad() {
        interactor?.getTodoList()
    }
    
    func addTodoItem(_ todoItem: TodoItem) {
        interactor?.addTodoItem(todoItem)
    }
    
    func removeTodoItem(_ todoItem: TodoItem) {
        interactor?.removeTodoItem(todoItem)
    }
}

extension MainPresenter: MainInteractorOutputProtocol {
    
    func didGetTodoList(_ todoList: [TodoItem]) {
        view?.showTodoList(todoList)
    }
    
    func didAddTodoItem(_ todoItem: TodoItem) {
        interactor?.getTodoList()
    }
    
    func didRemoveTodoItem(_ todoItem: TodoItem) {
        interactor?.getTodoList()
    }
    
    func onError(errorMessage: String) {
        view?.showErrorAllert(errorMessage)
    }
}
