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
    func update(todoItemID: Int, with title: String, description: String?, isCompleted: Bool)
    func delete(_ todoItem:  TodoItem)
    func fetchItem(with itemId: Int) -> TodoItem?
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
    
    func update(todoItemID: Int, with title: String, description: String?, isCompleted: Bool) {
        let todoItem =  fetchItemCD(with: todoItemID)
        guard let todoItem = todoItem else { return }
        todoItem.title = title
        todoItem.itemDescription = description
        todoItem.completed = isCompleted
        saveContext(with: context)
    }
    
    func delete(_ todoItem: TodoItem) {
        guard let todoItemCD = fetchItemCD(with: todoItem.id) else { return }
        context.delete(todoItemCD)
        saveContext(with: context)
    }
    
    func fetchItem(with itemId: Int) -> TodoItem? {
        guard let todoItemCD = fetchItemCD(with: itemId) else { return nil }
        return convertToObject(from: todoItemCD)
    }
    
    func fetchItems() -> [TodoItem] {
        let request = TodoItemCD.fetchRequest()
        let todoItemsCD = (try? context.fetch(request)) ?? []
        var todoItems: [TodoItem] = []
        for item in todoItemsCD {
            #warning("should not be optional title")
            let todo = convertToObject(from: item)
            todoItems.append(todo)
        }
        return todoItems
    }
    
    private func fetchItemCD(with itemId: Int) -> TodoItemCD? {
        let request = TodoItemCD.fetchRequest()
        request.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "id = %d", itemId)
        request.predicate = predicate
        let todoItem = try? context.fetch(request).first
        return todoItem
    }
    
    private func convertToObject(from itemCD: TodoItemCD) -> TodoItem {
        return TodoItem(
            id: Int(itemCD.id),
            title: itemCD.title ?? "",
            description: itemCD.itemDescription,
            createdAt: itemCD.createdAt,
            completed: itemCD.completed,
            userId: Int(itemCD.userId)
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
