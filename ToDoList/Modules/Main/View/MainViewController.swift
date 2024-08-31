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
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyConstraints()
        
        view.backgroundColor = .systemBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupNav()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
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
    
    private func setupNav() {
        title = "Todos App"
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc
    private func addButtonTapped(_ sender: UIBarButtonItem) {
        presenter?.addTodoItemClicked()
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
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.editTodoItemClicked(todoItem: todosList[indexPath.row])
    }
}

extension MainViewController: MainViewProtocol {
    func showTodoList(_ todoList: [TodoItem]) {
        self.todosList = todoList
    }
    
    func showErrorAllert(_ errorMessage: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ошибка", message: errorMessage, preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
            let actionRetry = UIAlertAction(title: "Повторить", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.presenter?.viewWillAppear()
            })
            alert.addAction(actionOk)
            alert.addAction(actionRetry)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
