//
//  TodoItemTableViewCell.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 25.08.2024.
//

import UIKit

final class TodoItemTableViewCell: UITableViewCell {

    static let reuseIdentifier = "TodoItemCellIdentifier"
    
    // контейнер для заголовка и описания
    private lazy var titleContainerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 6
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.textColor = .systemGray
        view.font = .systemFont(ofSize: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var createdAtLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGray
        view.font = .systemFont(ofSize: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // контейнер отобращающий статус задачи. содержит в себе лейбл со статусом.
    private lazy var completedContainerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // лейбл отображает текущее состояние задачи
    private lazy var completedLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with todoItem: TodoItem) {
        titleLabel.text = todoItem.title
    
        if let description = todoItem.description {
            descriptionLabel.text = description
        } else {
            descriptionLabel.text = "Описание отсутствует"
        }
        
        if let date = todoItem.createdAt {
            createdAtLabel.text = "Создано: \(CellDateFormatter.shared.dateString(date: date))"
        } else {
            createdAtLabel.text = "Создано: н/д"
        }
        
        if todoItem.completed {
            completedLabel.text = "Выполнено"
            completedContainerView.backgroundColor = .systemGreen
        } else {
            completedLabel.text = "В процессе"
            completedContainerView.backgroundColor = .systemYellow
        }
    }
    
    private func setupConstraints() {
        titleContainerView.addArrangedSubview(titleLabel)
        titleContainerView.addArrangedSubview(descriptionLabel)
        titleContainerView.addArrangedSubview(createdAtLabel)
        contentView.addSubview(titleContainerView)
        
        completedContainerView.addSubview(completedLabel)
        contentView.addSubview(completedContainerView)
        
        NSLayoutConstraint.activate([
            titleContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            titleContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleContainerView.trailingAnchor.constraint(equalTo: completedContainerView.leadingAnchor, constant: -16),
            
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor),
            
            createdAtLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor),
            
            completedContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            completedContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            completedContainerView.heightAnchor.constraint(equalToConstant: 50),
            completedContainerView.widthAnchor.constraint(equalToConstant: 100),
            
            completedLabel.centerXAnchor.constraint(equalTo: completedContainerView.centerXAnchor),
            completedLabel.centerYAnchor.constraint(equalTo: completedContainerView.centerYAnchor),
        ])
    }

}
