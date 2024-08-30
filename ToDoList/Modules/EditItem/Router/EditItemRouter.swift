//
//  EditItemRouter.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 29.08.2024.
//

import UIKit

final class EditItemRouter: EditItemRouterProtocol {
    
    func navigateBackToMainView(from view: EditItemViewProtocol) {
        guard let view = view as? UIViewController else {
            fatalError("invalid view type")
        }
        view.navigationController?.popViewController(animated: true)
    }
    
}
