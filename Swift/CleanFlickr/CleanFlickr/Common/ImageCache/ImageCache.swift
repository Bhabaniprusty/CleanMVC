//
//  ImageCache.swift
//  CleanFlickr
//
//  Created by Bhabani on 31/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import UIKit

protocol ImageCache {
    func add(_ object: UIImage, for identifier: String)
    func object(for identifier: String) -> UIImage?
}

final class AutoPurgingImageCache: AutoPurgingObjectCache<UIImage>, ImageCache {
    
}


extension UIImage: Sizable{
    var bytes: UInt64 {
        let bytesPerPixel: CGFloat = 4.0
        let bytesPerRow = size.width * scale * bytesPerPixel
        return UInt64(bytesPerRow) * UInt64(size.height * scale)
    }
}
