//
//  UIImageView+Network.swift
//  CleanFlickr
//
//  Created by Bhabani on 27/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(withUrl urlString : String, placeholderImage: UIImage? = nil, completion: @escaping (Bool, UIImage?) -> Void) {
        cf_activeRequestURL = urlString
        ImageDownloader.default.cancel(for: urlString)
        image = placeholderImage
        
        ImageDownloader.default.fetch(with: urlString) { [weak self] (requestUrl, image) in
            guard requestUrl == self?.cf_activeRequestURL else { return }
            guard let image = image else { return completion(false, nil) }
            self?.image = image
            completion(true, image)
        }
    }
    
    
    private var cf_activeRequestURL: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.activeRequestUrl) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.activeRequestUrl, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private struct AssociatedKey {
        static var activeRequestUrl = "CFUIImageView.ActiveRequestURL"
    }
    
}
