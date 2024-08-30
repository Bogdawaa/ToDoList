//
//  EditItemInteractor.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 29.08.2024.
//

import Foundation

final class EditItemInteractor: EditItemInteractorInputProtocol {
    
    var presenter: EditItemInteractorOutputProtocol?
    
    let todoItemStore: TodoItemStoreProtocol = TodoItemStore() // TODO: - delegate  + DI ??
    
    var todoItem: TodoItem?
    
    func editAndSaveTodoItem(title: String, description: String?, isCompleted: Bool) {
        guard let todoItem = todoItem else { return }
        todoItemStore.update(todoItemID: todoItem.id, with: title, description: description, isCompleted: isCompleted)
        guard let updatedItem =  todoItemStore.fetchItem(with: todoItem.id) else { return }
        presenter?.didEditAndSaveTodoItem(updatedItem)
    }
    
    
}
