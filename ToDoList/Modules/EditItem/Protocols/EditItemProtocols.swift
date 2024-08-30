//
//  EditItemProtocols.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 29.08.2024.
//

import Foundation

protocol EditItemViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
    func showTodoList(_ todoList: [TodoItem])
    func showErrorAllert(_ errorMessage: String)
}

protocol EditItemPresenterProtocol: AnyObject {
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorInputProtocol? { get set}
    var router: MainRouterProtocol? { get set }
    
//    func configureView()
    func viewDidLoad()
    func addTodoItemClicked()
    func removeTodoItem(_ todoItem: TodoItem)
}

protocol EditItemInteractorInputProtocol: AnyObject {
    // presenter -> interactor
    var presenter: MainInteractorOutputProtocol? { get set }
    func getTodoList()
    func addTodoItem(_ todoItem: TodoItem)
    func removeTodoItem(_ todoItem: TodoItem)
}

protocol EditItemnteractorOutputProtocol: AnyObject {
    // interactor -> presenter
    func didGetTodoList(_ todoList: [TodoItem])
    func didAddTodoItem(_ todoItem: TodoItem)
    func didRemoveTodoItem(_ todoItem: TodoItem)
    func onError(errorMessage: String)
}

protocol EditItemRouterProtocol: AnyObject {
    func showAddNewItemScene()
}

protocol EditItemConfiguratorProtocol: AnyObject {
    func configure(with viewController: MainViewController)
}
