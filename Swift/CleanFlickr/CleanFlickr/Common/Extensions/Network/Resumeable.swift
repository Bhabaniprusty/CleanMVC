//
//  Resumeable.swift
//  CleanFlickr
//
//  Created by Bhabani on 31/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

public protocol Resumeable {
    
    func resume()
    
}

extension URLSessionDataTask: Resumeable {
    
}
