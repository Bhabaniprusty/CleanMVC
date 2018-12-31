//
//  UIViewController+Alerts.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(for error: Error?) {
        guard let error = error else { return }
        let errorTitle = NSLocalizedString("Oops.. Something went wrong. 😥", comment: "Error alert title")
        let alert = UIAlertController(title: errorTitle, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
