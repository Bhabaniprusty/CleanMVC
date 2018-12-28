//
//  Environment.swift
//  CleanFlickr
//
//  Created by Bhabani on 27/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

enum Environment: String {
    case dev = "Development"
    case stage = "Stage"
    case production = "Production"
    
    fileprivate static let allValues = [dev, stage, production]
    
    
    var environmentVariables: EnvironmentVariables.Type {
        switch self {
        case .dev:
            return DevEnvironmentVariables.self
        case .stage:
            return StageEnvironmentVariables.self
        case .production:
            return ProductionEnvironmentVariables.self
        }
    }
    
    
    
    fileprivate init() {
        self = .dev
    }
    
    static fileprivate(set) var current = Environment()
    
}
