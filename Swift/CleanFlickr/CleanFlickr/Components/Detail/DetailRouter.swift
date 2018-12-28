//
//  DetailRouter.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

import UIKit

protocol DetailRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

final class DetailRouter: NSObject, DetailRoutingLogic {
    weak var viewController: DetailViewController?
}
