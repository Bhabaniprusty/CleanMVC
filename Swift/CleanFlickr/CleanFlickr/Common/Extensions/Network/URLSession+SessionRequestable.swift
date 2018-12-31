//
//  URLSession+SessionRequestable.swift
//  CleanFlickr
//
//  Created by Bhabani on 31/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

protocol SessionRequestable {
    func fetchTask(with url: URL,
                   completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
        -> (Cancelable & Resumeable)
}

extension URLSession: SessionRequestable {
    func fetchTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> (Cancelable & Resumeable) {
        return dataTask(with: url, completionHandler: completionHandler)
    }
}
