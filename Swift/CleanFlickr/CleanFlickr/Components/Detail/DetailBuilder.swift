//
//  DetailBuilder.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

protocol DetailDependency: Dependency {
}

final class DetailComponent: Component<ListDependency> {
    
    override init(dependency: ListDependency) {
        super.init(dependency: dependency)
    }
}

// MARK: - Builder
protocol DetailBuildable: Buildable {
    @discardableResult func build(withViewController: DetailViewController, listener: DetailListener?) -> DetailRoutingLogic
}

final class DetailBuilder: Builder<DetailDependency>, DetailBuildable {
    
    override init(dependency: DetailDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withViewController viewController: DetailViewController, listener: DetailListener?) -> DetailRoutingLogic {
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        viewController.interactor = interactor
        interactor.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        return router
    }
}

