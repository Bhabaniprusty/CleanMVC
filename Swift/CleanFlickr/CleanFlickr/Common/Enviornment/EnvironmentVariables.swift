//
//  EnvironmentVariables.swift
//  CleanFlickr
//
//  Created by Bhabani on 27/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

protocol EnvironmentVariables {
    static var flikrsApiKey: String { get }
}



// MARK: DevEnviromentVariables
enum DevEnvironmentVariables: EnvironmentVariables {
    static let flikrsApiKey = "59c329dfa9ad33fce0f0291491c4c4da"
}


// MARK: StageEnviromentVariables
enum StageEnvironmentVariables: EnvironmentVariables {
    static let flikrsApiKey = "<To Be provided>"
}


// MARK: ProductionEnvironmentVariables
enum ProductionEnvironmentVariables: EnvironmentVariables {
    static let flikrsApiKey = "<To Be provided>"
}
