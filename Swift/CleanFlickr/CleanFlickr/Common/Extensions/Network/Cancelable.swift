//
//  Cancelable.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

public protocol Cancelable {
    
    func cancel()
    
}

extension URLSessionDataTask: Cancelable {
    
}
