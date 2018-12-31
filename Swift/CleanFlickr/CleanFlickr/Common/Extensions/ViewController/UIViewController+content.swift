//
//  UIViewController+content.swift
//  CleanFlickr
//
//  Created by Bhabani on 28/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import UIKit

extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? navcon
        } else {
            return self
        }
    }
}
