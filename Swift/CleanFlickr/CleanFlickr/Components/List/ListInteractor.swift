//
//  ListInteractor.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

import UIKit

protocol ListBusinessLogic {
    func fetchPhotos(request: List.Search.Request)
    func showPhotoDetailScreen(for segue: UIStoryboardSegue, viewmodel: List.Search.ViewModel.FlickrPhotoItem, withAnchor rect: CGRect)
}

protocol ListListener: class {
    
}


final class ListInteractor: ListBusinessLogic {
    
    var presenter: ListPresentationLogic?
    var router: ListRoutingLogic?
    
    var service: FlickrPhotoServiceProtocol?

    fileprivate lazy var worker = ListWorker()
    
    // MARK: Business logic
    
    func fetchPhotos(request: List.Search.Request) {
        service?.fetchPhotos(request: request, callback: { [weak self] result in
            self?.presenter?.presentList(response: result)
        })
    }
    
    
    func showPhotoDetailScreen(for segue: UIStoryboardSegue, viewmodel: List.Search.ViewModel.FlickrPhotoItem, withAnchor rect: CGRect) {
        router?.routeToPhotoDetailScreen(for: segue,
                                         viewmodel: viewmodel,
                                         withAnchor: rect)
    }

}
