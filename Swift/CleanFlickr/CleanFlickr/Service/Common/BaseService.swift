//
//  BaseService.swift
//  CleanFlickr
//
//  Created by Bhabani on 27/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

protocol BaseService {
    
    @discardableResult func request<T: Decodable>(with target: URLRequest, callback: @escaping (Result<T>)-> Void) -> Cancelable
}


extension BaseService {
    @discardableResult public func request<T: Decodable>(with target: URLRequest, callback: @escaping (Result<T>)-> Void) -> Cancelable {
        func mainQueue(_ callBack: @escaping () -> Void) {
            OperationQueue.main.addOperation{ callBack() }
        }
        let task = URLSession.shared.dataTask(with: target) { (data, response, error) in
            if let error = error {
                guard !error.isCancelled else { return }
                return mainQueue { callback(.failure(error)) }
            }

            guard let _ = response as? HTTPURLResponse,
                let data = data else { return mainQueue { callback(.failure(ServiceError.unknownResponse)) } }
            
            mainQueue { callback(Result { try JSONDecoder().decode(T.self, from: data) }) }
        }
        task.resume()
        
        return task
    }
}
