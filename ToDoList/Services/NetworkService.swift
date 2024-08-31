//
//  NetworkService.swift
//  ToDoList
//
//  Created by Bogdan Fartdinov on 23.08.2024.
//

import Foundation

struct NetworkService {
    
    enum NetworkServiceError: Error {
        case badURL
        case dataError
    }
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchTasks(completion: @escaping (Result<Todos, Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            completion(.failure(NetworkServiceError.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkServiceError.dataError))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Todos.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
