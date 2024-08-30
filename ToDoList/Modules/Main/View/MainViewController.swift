//
//  ViewController.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 23.08.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(TodoItemTableViewCell.self, forCellReuseIdentifier: TodoItemTableViewCell.reuseIdentifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    var presenter: MainPresenterProtocol?
    
    var todosList: [TodoItem] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("count: \(self.todosList.count)")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        applyConstraints()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func applyConstraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TodoItemTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? TodoItemTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configureCell(with: todosList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.removeTodoItem(todosList[indexPath.row])
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

extension MainViewController: MainViewProtocol {
    func showTodoList(_ todoList: [TodoItem]) {
        self.todosList = todoList
    }
    
    func showErrorAllert(_ errorMessage: String) {
        //
    }
}
