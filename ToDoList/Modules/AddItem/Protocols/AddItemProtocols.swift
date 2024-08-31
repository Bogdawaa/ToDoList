//
//  AddItemProtocols.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 30.08.2024.
//

import UIKit

protocol AddItemViewProtocol: AnyObject {
    var presenter: AddItemPresenterProtocol? { get set }
}

protocol AddItemPresenterProtocol: AnyObject {
    var view: AddItemViewProtocol? { get set }
    var interactor: AddItemInteractorInputProtocol? { get set}
    var router: AddItemRouterProtocol? { get set }
    
    func editAndSaveTodoItem(title: String, description: String?)
}

protocol AddItemInteractorInputProtocol: AnyObject {
    // presenter -> interactor
    var presenter: AddItemInteractorOutputProtocol? { get set }
    func editAndSaveTodoItem(title: String, description: String?)
}

protocol AddItemInteractorOutputProtocol: AnyObject {
    // interactor -> presenter
    func didEditAndSaveTodoItem(_ todoItem: TodoItem)
}

protocol AddItemRouterProtocol: AnyObject {
    func navigateBackToMainView(from view: AddItemViewProtocol)
}

protocol AddItemConfiguratorProtocol: AnyObject {
    func configure(viewController: AddItemViewController)
}
