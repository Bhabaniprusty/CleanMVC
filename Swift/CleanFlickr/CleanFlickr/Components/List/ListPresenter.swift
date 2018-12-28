//
//  ListPresenter.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

import UIKit

protocol ListPresentationLogic {
    func presentList(response: Result<List.Search.Response.FlickrPhoto>)
}

final class ListPresenter: ListPresentationLogic {
    

    weak var viewController: ListDisplayLogic?
    
    // MARK: Presentation logic
    
    func presentList(response: Result<List.Search.Response.FlickrPhoto>) {
        switch response {
        case .success(let flickrPhoto):
            viewController?.displayList(viewModel: prepareViewModel(model: flickrPhoto))
        case .failure(let error):
            viewController?.display(error: error)
        }
    }

    func prepareViewModel(model: List.Search.Response.FlickrPhoto) ->  List.Search.ViewModel.FlickrPhoto {

        let viewModelPhotoItem = model.photo?.map{ return List.Search.ViewModel.FlickrPhotoItem(model: $0) }
        return List.Search.ViewModel.FlickrPhoto(page: model.page,
                                                 pages: model.pages,
                                                 photo: viewModelPhotoItem)
    }
}
