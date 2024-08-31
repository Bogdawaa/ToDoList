//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 30.08.2024.
//

import UIKit

final class AddItemViewController: UIViewController, AddItemViewProtocol {
    
    var presenter: AddItemPresenterProtocol?
    
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
        view.delegate = self
        view.borderStyle = .roundedRect
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyConstraints()
        view.backgroundColor = .systemBackground
    }
    
    private func applyConstraints() {
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(titleTextField)
        containerStackView.addArrangedSubview(descriptionLabel)
        containerStackView.addArrangedSubview(descriptionTextView)
        
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
            description: descriptionTextView.text
        )
    }
}

extension AddItemViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString
        let newText = text.replacingCharacters(in: range, with: string)
        let textLength = newText.count
        return textLength < 50
    }
}

extension AddItemViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let textLength = newText.count
        return textLength < 150
    }
}
