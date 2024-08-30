//
//  MainInteractorProtocol.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 23.08.2024.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
    func showTodoList(_ todoList: [TodoItem])
    func showErrorAllert(_ errorMessage: String)
}

protocol MainPresenterProtocol: AnyObject {
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorInputProtocol? { get set}
    var router: MainRouterProtocol? { get set }
    
//    func configureView()
    func viewWillAppear()
    func addTodoItemClicked()
    func editTodoItemClicked(todoItem: TodoItem)
    func removeTodoItem(_ todoItem: TodoItem)
}

protocol MainInteractorInputProtocol: AnyObject {
    // presenter -> interactor
    var presenter: MainInteractorOutputProtocol? { get set }
    func getTodoList()
    func addTodoItem(_ todoItem: TodoItem)
    func removeTodoItem(_ todoItem: TodoItem)
}

protocol MainInteractorOutputProtocol: AnyObject {
    // interactor -> presenter
    func didGetTodoList(_ todoList: [TodoItem])
    func didAddTodoItem(_ todoItem: TodoItem)
    func didRemoveTodoItem(_ todoItem: TodoItem)
    func onError(errorMessage: String)
}

protocol MainRouterProtocol: AnyObject {
    func showAddNewItemScene()
    func showEditItemScene(for todoItem: TodoItem)
}

protocol MainConfiguratorProtocol: AnyObject {
    func configure(with viewController: MainViewController)
}
