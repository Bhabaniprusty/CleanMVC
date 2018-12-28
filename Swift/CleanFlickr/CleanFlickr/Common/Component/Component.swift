//
//  Component.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

open class Component<DependencyType>: Dependency {
    public let dependency: DependencyType

    public init(dependency: DependencyType) {
        self.dependency = dependency
    }
}

open class EmptyComponent: Dependency {
    
    /// Initializer.
    public init() {}
}
