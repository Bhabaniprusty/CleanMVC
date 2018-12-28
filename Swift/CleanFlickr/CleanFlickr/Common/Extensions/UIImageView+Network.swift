//
//  UIImageView+Network.swift
//  CleanFlickr
//
//  Created by Bhabani on 27/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import UIKit

// This is the simple cache store, we can define the storage type, purge data with memry limitaion etc
let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImage(withUrl urlString : String, placeholderImage: UIImage? = nil, completion: @escaping (Bool, UIImage?) -> Void) {
        cf_activeRequestURL = urlString
        cf_activeRequestTask?.cancel()
        guard let url = URL(string: urlString) else { return completion(false, nil) }
        image = placeholderImage
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            image = cachedImage
            return completion(true, cachedImage)
        }
        
        // if not, download image from url, addtionally we can add limitation for number of concurrent download
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error)  in
            DispatchQueue.main.async { [weak self] in
                guard let data = data, let image = UIImage(data: data) else { return completion(false, nil) }
                imageCache.setObject(image, forKey: urlString as NSString)
                guard response?.url?.absoluteString == self?.cf_activeRequestURL else { return completion(false, nil) }
                self?.image = image
                completion(true, image)
            }
        })
        cf_activeRequestTask = task
        task.resume()
    }
    
    private var cf_activeRequestTask: Cancelable? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.activeRequestTask) as? Cancelable
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.activeRequestTask, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
        static var activeRequestTask = "CFUIImageView.ActiveRequestTask"
        static var activeRequestUrl = "CFUIImageView.ActiveRequestURL"
    }

}
