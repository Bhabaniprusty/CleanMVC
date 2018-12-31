//
//  Injectable.swift
//  CleanFlickr
//
//  Created by Bhabani on 28/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

protocol Injectable {
    associatedtype T
    
    func inject(_: T)
    func assertDependencies()
}
