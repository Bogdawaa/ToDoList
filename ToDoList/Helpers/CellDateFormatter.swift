//
//  DateFormatter.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 31.08.2024.
//

import Foundation

class CellDateFormatter {
    
    static let shared = CellDateFormatter()
    
    private init() {}
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    func dateString(date: Date) -> String {
        return formatter.string(from: date)
    }
}
