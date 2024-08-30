//
//  MainInteractor.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 23.08.2024.
//

import Foundation

final class MainInteractor: MainInteractorInputProtocol {
    
    weak var presenter: MainInteractorOutputProtocol?
    
    let todoItemStore: TodoItemStoreProtocol = TodoItemStore() // TODO: - delegate  + DI ??
    
    var networkClient = NetworkService() // DI

    private var isFirstAppLaunch: Bool {
        UserDefaults.standard.getIsFirstAppLaunchFlag()
    }
    
    private var todoListCD: [TodoItem] = []
    
    func addTodoItem(_ todoItem: TodoItem) {
        todoItemStore.addItem(todoItem)
        presenter?.didAddTodoItem(todoItem)
    }
    
    func removeTodoItem(_ todoItem: TodoItem) {
        todoItemStore.delete(todoItem)
        presenter?.didRemoveTodoItem(todoItem)
    }
    
    func getTodoList() {
        if !isFirstAppLaunch {
            fetchFromNetworkAPI()
        } else {
            print("fetch from core data")
            todoListCD = todoItemStore.fetchItems()
            presenter?.didGetTodoList(todoListCD)
        }
    }
    
    private func fetchFromNetworkAPI() {
        networkClient.fetchTasks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let todoList):
                for item in todoList.todos {
                    todoListCD.append(item)
                    todoItemStore.addItem(item)
                }
                UserDefaults.standard.setIsFirstAppLaunchFlag(value: true)
                presenter?.didGetTodoList(self.todoListCD)
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
