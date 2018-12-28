//
//  Service.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

protocol ServicesProtocol {
    var photoService: FlickrPhotoServiceProtocol { get }
}


final class Services: ServicesProtocol {
    lazy var photoService: FlickrPhotoServiceProtocol = FlickrPhotoService()
}
