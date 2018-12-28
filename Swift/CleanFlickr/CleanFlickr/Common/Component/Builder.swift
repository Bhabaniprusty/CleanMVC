//
//  Builder.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

public protocol Buildable: class {}

open class Builder<DependencyType>: Buildable {
    public let dependency: DependencyType
    public init(dependency: DependencyType) {
        self.dependency = dependency
    }
}
