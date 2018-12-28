//
//  FlickrPhotoService.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

typealias PhotosCallback = ((Result<List.Search.Response.FlickrPhoto>) -> Void)

protocol FlickrPhotoServiceProtocol: class {
    func fetchPhotos(request searchRequest: List.Search.Request, callback: @escaping PhotosCallback)
}


final class FlickrPhotoService: FlickrPhotoServiceProtocol, BaseService {
    
    var fetchPhotoRequest: Cancelable?
    
    func fetchPhotos(request searchRequest: List.Search.Request, callback: @escaping PhotosCallback) {
        fetchPhotoRequest?.cancel()
        guard let urlRequest = searchRequest.asURLRequest() else { return callback(.failure(ServiceError.invalidArguments))}
        fetchPhotoRequest = request(with: urlRequest) { (result: Result<List.Search.Response.FlickrPhotoResponse>) in
            switch result{
            case .success(let value):
                if let error = value.filterBackendError() {
                    callback(.failure(error))
                }
                guard let photos = value.photos else { return callback(.failure(ServiceError.invalidResponse)) }
                callback(.success(photos))
                
            case .failure(let error):
                callback(.failure(error))
            }
        }
        
    }
    
}
