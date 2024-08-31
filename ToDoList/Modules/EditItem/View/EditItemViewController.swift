//
//  EditItemViewController.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 29.08.2024.
//

import UIKit

class EditItemViewController: UIViewController {
    
    var presenter: EditItemPresenterProtocol?
    
    private lazy var containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Название"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.delegate = self
        view.placeholder = "Введите название задачи"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.text = "Описание задачи"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let view = UITextView()
        view.delegate = self
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.systemGreen
        view.layer.cornerRadius = 8
        view.setTitle("Сохранить", for: .normal)
        view.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var containerFooterStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var isCompletedLabel: UILabel = {
        let view = UILabel()
        view.text = "Выполнено"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var isCompletedSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyConstraints()
        presenter?.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    private func applyConstraints() {
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(titleTextField)
        containerStackView.addArrangedSubview(descriptionLabel)
        containerStackView.addArrangedSubview(descriptionTextView)
        
        containerFooterStackView.addArrangedSubview(isCompletedLabel)
        containerFooterStackView.addArrangedSubview(isCompletedSwitch)
    
        containerStackView.addArrangedSubview(containerFooterStackView)
        view.addSubview(containerStackView)
        view.addSubview(saveButton)


        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150),
            
            saveButton.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc
    func saveButtonTapped() {
        presenter?.editAndSaveTodoItem(
            title: titleTextField.text ?? "Без названия",
            description: descriptionTextView.text,
            isCompleted: isCompletedSwitch.isOn
        )
    }
}

extension EditItemViewController: EditItemViewProtocol {
    func showTodoItem(_ todoItem: TodoItem) {
        self.titleTextField.text = todoItem.title
        self.descriptionTextView.text = todoItem.description
        self.isCompletedSwitch.isOn = todoItem.completed
    }
}

extension EditItemViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString
        let newText = text.replacingCharacters(in: range, with: string)
        let textLength = newText.count
        return textLength < 50
    }
}

extension EditItemViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let textLength = newText.count
        return textLength < 150
    }
}
