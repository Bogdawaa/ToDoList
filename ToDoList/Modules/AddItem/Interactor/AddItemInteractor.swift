//
//  AddItemInteractor.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 30.08.2024.
//

import Foundation

final class AddItemInteractor: AddItemInteractorInputProtocol {
    
    var presenter: AddItemInteractorOutputProtocol?
    
    let todoItemStore: TodoItemStoreProtocol = TodoItemStore() // TODO: - delegate  + DI ??
    
    func editAndSaveTodoItem(title: String, description: String?) {
        let item = TodoItem(
            id: Int.random(in: 0...Int.max),
            title: title,
            description: description,
            createdAt: Date(),
            completed: false,
            userId: Int.random(in: 0...Int.max)
        )
        todoItemStore.addItem(item)
        presenter?.didEditAndSaveTodoItem(item)
    }
}
