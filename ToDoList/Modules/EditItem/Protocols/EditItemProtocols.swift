//
//  EditItemProtocols.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 29.08.2024.
//

import UIKit

protocol EditItemViewProtocol: AnyObject {
    var presenter: EditItemPresenterProtocol? { get set }
    func showTodoItem(_ todoItem: TodoItem)
}

protocol EditItemPresenterProtocol: AnyObject {
    var view: EditItemViewProtocol? { get set }
    var interactor: EditItemInteractorInputProtocol? { get set}
    var router: EditItemRouterProtocol? { get set }
    
    func viewDidLoad()
    func editAndSaveTodoItem(title: String, description: String?, isCompleted: Bool)
}

protocol EditItemInteractorInputProtocol: AnyObject {
    // presenter -> interactor
    var presenter: EditItemInteractorOutputProtocol? { get set }
    var todoItem: TodoItem? { get set }
    
    func editAndSaveTodoItem(title: String, description: String?, isCompleted: Bool)
}

protocol EditItemInteractorOutputProtocol: AnyObject {
    // interactor -> presenter
    func didEditAndSaveTodoItem(_ todoItem: TodoItem)
}

protocol EditItemRouterProtocol: AnyObject {
    func navigateBackToMainView(from view: EditItemViewProtocol)
}

protocol EditItemConfiguratorProtocol: AnyObject {
    func configure(viewController: EditItemViewController, with todoItem: TodoItem)
}
