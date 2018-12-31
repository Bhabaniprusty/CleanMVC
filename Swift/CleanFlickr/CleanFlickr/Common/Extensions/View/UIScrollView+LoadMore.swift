//
//  UIScrollView+LoadMore.swift
//  CleanFlickr
//
//  Created by Bhabani on 27/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import UIKit

extension UIScrollView {
    private static let LOAD_MORE_THRESHOLD: CGFloat = 100
    
    var isScrolledToLoadMore: Bool {
        return contentSize.height > bounds.height &&
            contentOffset.y + bounds.height > contentSize.height - UIScrollView.LOAD_MORE_THRESHOLD
    }
}
