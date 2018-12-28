//
//  RootInteractor.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

import UIKit

protocol RootBusinessLogic {
    func showPhotoListScreen(for segue: UIStoryboardSegue)
}

final class RootInteractor: RootBusinessLogic {
    
    var router: RootRoutingLogic?
    
    func showPhotoListScreen(for segue: UIStoryboardSegue) {
        router?.routeToPhotoListScreen(for: segue)
    }
}

// deeplink
extension RootInteractor: UrlHandler {
    
    func handle(_ url: URL) {
        
    }
    
}
