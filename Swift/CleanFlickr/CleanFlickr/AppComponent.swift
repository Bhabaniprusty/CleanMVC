//
//  AppComponent.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

final class AppComponent: Component<Dependency>, RootDependency {
    
    lazy private(set) var service: ServicesProtocol = Services()
    
    init() {
        
        super.init(dependency: EmptyComponent())
    }
}
