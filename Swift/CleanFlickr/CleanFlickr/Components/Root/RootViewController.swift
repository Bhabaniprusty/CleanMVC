//
//  RootViewController.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

import UIKit

protocol RootDisplayLogic: class {
    
}

final class RootViewController: UIViewController, RootDisplayLogic {
    
    var interactor: RootBusinessLogic?
    
    // MARK: Configuration
    private func configure() {
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // if seg compare
        interactor?.showPhotoListScreen(for: segue)
    }
    
}
