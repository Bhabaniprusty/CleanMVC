//
//  RootRouter.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

import UIKit

protocol RootRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    func routeToPhotoListScreen(for segue: UIStoryboardSegue)
}

final class RootRouter: NSObject, RootRoutingLogic, LaunchRouting {
    func routeToPhotoListScreen(for segue: UIStoryboardSegue) {
        guard let listViewController = segue.destination as? ListViewController else { fatalError("failed to init from Storyboard") }
        listBuilder.build(withViewController: listViewController, listener: nil)
    }
    
    weak var viewController: UIViewController?
    private let listBuilder: ListBuildable
    
    
    init(viewController: RootViewController, listBuilder: ListBuildable) {
        self.viewController = viewController
        self.listBuilder = listBuilder
    }
}
