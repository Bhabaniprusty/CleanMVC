//
//  LaunchRouting.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import UIKit

public protocol LaunchRouting: ViewableRouting {
    
    func launchFromWindow(_ window: UIWindow)
}

extension LaunchRouting {
    func launchFromWindow(_ window: UIWindow) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
