//
//  TodoItem.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 24.08.2024.
//

import Foundation

struct TodoItem: Codable {
    let id: Int
    let title: String
    let description: String?
    let createdAt: Date?
    let completed: Bool
    let userId: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title = "todo"
        case description
        case createdAt
        case completed
        case userId
    }
}

struct Todos: Codable {
    let todos: [TodoItem]
}
