//
//  ListModels.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

import UIKit

enum List {
    // MARK: Use cases
    
    enum Search {
        struct Request {
            
            var searchTerm:String
            var page: UInt
            
            // Need to change targettype
            func asURLRequest() -> URLRequest? {
                
                guard let escapedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else { return nil }
                let apiKey = Environment.current.environmentVariables.flikrsApiKey
                let URLString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(escapedTerm)&per_page=20&format=json&nojsoncallback=1&page=\(page)"
                
                guard let url = URL(string:URLString) else {
                    return nil
                }
                
                return URLRequest(url: url)
            }

        }
        
        struct Response {
            struct FlickrPhotoItem: Codable {
                
                var id: String
                var farm: Int
                var server: String
                var secret: String
                var title: String
            }
            
            struct FlickrPhoto: Codable {
                var page: UInt
                var pages: UInt
                var photo: [FlickrPhotoItem]?

            }
            
            struct FlickrPhotoResponse: Codable {
                var photos: FlickrPhoto?
                var stat: String
                
                func filterBackendError() -> Error? {
                    guard stat == "ok" else { return ServiceError.backendError(stat) }
                    return nil
                }
            }

        }
        
        struct ViewModel {
            struct FlickrPhotoItem {
                var model: Response.FlickrPhotoItem
                
                var photoURL: String {
                    get {
                        return "https://farm\(model.farm).static.flickr.com/\(model.server)/\(model.id)_\(model.secret).jpg"
                    }
                }
                
                /**
                 * Thumbnail URL
                 */
                var photoURLSmall: String {
                    get {
                        return "https://farm\(model.farm).static.flickr.com/\(model.server)/\(model.id)_\(model.secret)_t.jpg"
                    }
                }
                
            }
            
            struct FlickrPhoto {
                var page: UInt = 0
                var pages: UInt = 0
                var photo: [FlickrPhotoItem]?
                
                var moreItemsAvailable: Bool {
                    return page < pages
                }
                
                var isInitalPage: Bool {
                    return page == 1
                }
            }
        }
        

    }
    
}
