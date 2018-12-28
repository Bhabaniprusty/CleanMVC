//
//  ListBuilder.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

protocol ListDependency: Dependency {
    var service: ServicesProtocol { get }
    var flickrPhotoService: FlickrPhotoServiceProtocol { get }
}

final class ListComponent: Component<ListDependency>, DetailDependency {
    
    fileprivate var flickrPhotoService: FlickrPhotoServiceProtocol {
        return dependency.service.photoService
    }
    
    var service: ServicesProtocol {
        return dependency.service
    }
    
    override init(dependency: ListDependency) {
        super.init(dependency: dependency)
    }
}

// MARK: - Builder
protocol ListBuildable: Buildable {
    @discardableResult func build(withViewController: ListViewController, listener: ListListener?) -> ListRoutingLogic
}

final class ListBuilder: Builder<ListDependency>, ListBuildable {
    
    override init(dependency: ListDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withViewController viewController: ListViewController, listener: ListListener?) -> ListRoutingLogic {
        let interactor = ListInteractor()
        interactor.service = dependency.flickrPhotoService
        let presenter = ListPresenter()
        let component = ListComponent(dependency: dependency)
        let detailBuilder = DetailBuilder(dependency: component)
        let router = ListRouter(viewController: viewController, detailBuilder: detailBuilder)
        viewController.interactor = interactor
        interactor.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return router
    }
}
