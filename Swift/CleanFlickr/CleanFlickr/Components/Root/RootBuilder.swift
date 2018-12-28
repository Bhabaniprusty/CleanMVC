//
//  RootBuilder.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation
import UIKit

protocol RootDependency: Dependency {
    var service: ServicesProtocol { get }
}

final class RootComponent: Component<RootDependency>, ListDependency {
    
    var flickrPhotoService: FlickrPhotoServiceProtocol {
        return dependency.service.photoService
    }
    
    var service: ServicesProtocol {
        return dependency.service
    }
    
    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }
}

// MARK: - Builder
protocol RootBuildable: Buildable {
    func build() -> (launchRouter: LaunchRouting, urlHandler: UrlHandler)
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
    
    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }
    
    func build() -> (launchRouter: LaunchRouting, urlHandler: UrlHandler) {
        let sb = UIStoryboard(name: "Root", bundle: nil)
        guard let viewController = sb.instantiateViewController(withIdentifier: "rootScreen") as? RootViewController else { fatalError("failed to init from Storyboard") }
        let interactor = RootInteractor()
        
        let component = RootComponent(dependency: dependency)
        let listBuilder = ListBuilder(dependency: component)
        let router = RootRouter(viewController: viewController, listBuilder: listBuilder)
        viewController.interactor = interactor
        interactor.router = router
        router.viewController = viewController
        
        return (router, interactor)
    }
}
