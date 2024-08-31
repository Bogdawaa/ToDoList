//
//  AddItemInteractor.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 30.08.2024.
//

import Foundation

final class AddItemInteractor: AddItemInteractorInputProtocol {
    
    var presenter: AddItemInteractorOutputProtocol?
    
    let todoItemStore: TodoItemStoreProtocol = TodoItemStore()
    
    func editAndSaveTodoItem(title: String, description: String?) {
        let item = TodoItem(
            id: Int64.random(in: 0...Int64.max),
            title: title,
            description: description,
            createdAt: Date(),
            completed: false,
            userId: Int64.random(in: 0...Int64.max)
        )
        todoItemStore.addItem(item)
        presenter?.didEditAndSaveTodoItem(item)
    }
}
