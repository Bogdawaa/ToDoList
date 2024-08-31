//
//  MainInteractor.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 23.08.2024.
//

import Foundation

final class MainInteractor: MainInteractorInputProtocol {
    
    weak var presenter: MainInteractorOutputProtocol?
    
    let todoItemStore: TodoItemStoreProtocol = TodoItemStore()
    
    private var networkClient = NetworkService.shared

    private var todoListCD: [TodoItem] = []
    
    private var isFirstAppLaunch: Bool {
        UserDefaults.standard.getIsFirstAppLaunchFlag()
    }
    
    func removeTodoItem(_ todoItem: TodoItem) {
        todoItemStore.delete(todoItem)
        presenter?.didRemoveTodoItem(todoItem)
    }
    
    func getTodoList() {
        if !isFirstAppLaunch {
            fetchFromNetworkAPI()
        } else {
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
                presenter?.onError(errorMessage: error.localizedDescription)
            }
        }
    }
}
