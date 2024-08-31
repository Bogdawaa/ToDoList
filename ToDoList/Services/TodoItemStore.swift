//
//  TodoItemStore.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 26.08.2024.
//

import UIKit
import CoreData

protocol TodoItemStoreProtocol {
    func addItem(_ todoItem:  TodoItem)
    func update(todoItemID: Int64, with title: String, description: String?, isCompleted: Bool)
    func delete(_ todoItem:  TodoItem)
    func fetchItem(with itemId: Int64) -> TodoItem?
    func fetchItems() -> [TodoItem]
}

final class TodoItemStore: NSObject, TodoItemStoreProtocol {
    
    private let context: NSManagedObjectContext
    
    convenience override init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addItem(_ todoItem: TodoItem) {
        let newTodoItemCD = TodoItemCD(context: context)
        newTodoItemCD.id = Int64(todoItem.id)
        newTodoItemCD.title = todoItem.title
        newTodoItemCD.itemDescription = todoItem.description
        newTodoItemCD.createdAt = todoItem.createdAt
        newTodoItemCD.completed = todoItem.completed
        newTodoItemCD.userId = Int64(todoItem.userId)
        saveContext(with: context)
    }
    
    func update(todoItemID: Int64, with title: String, description: String?, isCompleted: Bool) {
        guard let todoItemCD =  fetchItemCD(with: todoItemID) else { return }
        todoItemCD.title = title
        todoItemCD.itemDescription = description
        todoItemCD.completed = isCompleted
        saveContext(with: context)
    }
    
    func delete(_ todoItem: TodoItem) {
        guard let todoItemCD = fetchItemCD(with: todoItem.id) else { return }
        context.delete(todoItemCD)
        saveContext(with: context)
    }
    
    func fetchItem(with itemId: Int64) -> TodoItem? {
        guard let todoItemCD = fetchItemCD(with: itemId) else { return nil }
        return convertToObject(from: todoItemCD)
    }
    
    func fetchItems() -> [TodoItem] {
        let request = TodoItemCD.fetchRequest()
        let todoItemsCD = (try? context.fetch(request)) ?? []
        var todoItems: [TodoItem] = []
        for item in todoItemsCD {
            let todo = convertToObject(from: item)
            todoItems.append(todo)
        }
        return todoItems
    }
    
    private func fetchItemCD(with itemId: Int64) -> TodoItemCD? {
        let request = TodoItemCD.fetchRequest()
        guard let todoItemCD = (try? context.fetch(request).first(where: {$0.id == itemId })) else { return nil }
        return todoItemCD
    }
    
    private func convertToObject(from itemCD: TodoItemCD) -> TodoItem {
        return TodoItem(
            id: itemCD.id,
            title: itemCD.title ?? "",
            description: itemCD.itemDescription,
            createdAt: itemCD.createdAt,
            completed: itemCD.completed,
            userId: itemCD.userId
        )
    }
    
    // MARK: - Core Data Saving support
    private func saveContext (with context: NSManagedObjectContext) {
        context.performAndWait {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    context.rollback()
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
            context.rollback()
        }
    }
    
}
