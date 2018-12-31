//
//  ImageDownloader.swift
//  CleanFlickr
//
//  Created by Bhabani on 31/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import UIKit

public protocol ImageFetcher {
    func fetch(with urlString : String, completion: ((String, UIImage?) -> Void)?)
    func cancel(for urlString: String)
}


open class ImageDownloader: ImageFetcher {
    public func fetch(with urlString: String, completion: ((String, UIImage?) -> Void)?) {
        cancel(for: urlString)
        guard let task = requestTask(with: urlString, completion: completion) else { return }
        synchronizationQueue.sync {
            requestTaskDictionary[urlString] = task
            task.resume()
        }
    }
    
    public func cancel(for urlString: String) {
        synchronizationQueue.sync {
            requestTaskDictionary[urlString]?.cancel()
            requestTaskDictionary[urlString] = nil
        }
    }
    
    private func requestTask(with urlString : String, completion: ((String, UIImage?) -> Void)?) ->  (Cancelable & Resumeable)? {
        
        //if url is invalid
        guard let url = URL(string: urlString) else {
            completion?(urlString, nil)
            return nil
        }
        
        // check cached image
        if let cachedImage = imageCache.object(for: urlString) {
            completion?(urlString, cachedImage)
            return nil
        }
        
        return session.fetchTask(with: url, completionHandler: { (data, response, error)  in
            DispatchQueue.main.async { [weak self] in
                guard let data = data, let image = UIImage(data: data) else {
                    completion?(urlString, nil)
                    return
                }
                self?.imageCache.add(image, for: urlString)
                self?.synchronizationQueue.sync {
                    self?.requestTaskDictionary[urlString] = nil
                }
                completion?(urlString, image)
            }
        })
    }
    
    private var requestTaskDictionary = [String : Cancelable]()
    private let imageCache: ImageCache
    private let session: SessionRequestable
    
    
    public static let `default` = ImageDownloader()
    
    private init(imageCache: ImageCache = AutoPurgingImageCache(), session: SessionRequestable = URLSession.shared) {
        self.imageCache = imageCache
        self.session = session
    }
    
    private let synchronizationQueue: DispatchQueue = {
        return DispatchQueue(label: "org.bhabani.imagedownloader.synchronizationqueue")
    }()
    
}
