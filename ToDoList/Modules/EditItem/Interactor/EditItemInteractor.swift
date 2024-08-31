//
//  EditItemInteractor.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 29.08.2024.
//

import Foundation

final class EditItemInteractor: EditItemInteractorInputProtocol {
    
    var presenter: EditItemInteractorOutputProtocol?
    
    let todoItemStore: TodoItemStoreProtocol = TodoItemStore()
    
    var todoItem: TodoItem?
    
    func editAndSaveTodoItem(title: String, description: String?, isCompleted: Bool) {
        guard let todoItem = todoItem else { return }
        print("before coredata: \(todoItem.id)")
        todoItemStore.update(todoItemID: todoItem.id, with: title, description: description, isCompleted: isCompleted)
        presenter?.didEditAndSaveTodoItem()
    }
    
    
}
