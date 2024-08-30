//
//  AddItemRouter.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 30.08.2024.
//

import UIKit

final class AddItemRouter: AddItemRouterProtocol {
    
    func navigateBackToMainView(from view: AddItemViewProtocol) {
        guard let view = view as? UIViewController else {
            fatalError("invalid view type")
        }
        view.navigationController?.popViewController(animated: true)
    }
    
}
