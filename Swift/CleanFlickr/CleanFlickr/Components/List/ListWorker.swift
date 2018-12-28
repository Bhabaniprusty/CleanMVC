//
//  ListWorker.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

import UIKit

// Not using this class. Initial I thought i would use for fetch on key stroke
final class ListWorker {
    
    fileprivate let interval: Double = 1.5
    
    fileprivate lazy var throttler: Throttler = {
        let requestThrottler = Throttler(seconds: interval)
        return requestThrottler
    }()

    func search(for query: String) {
        throttler.throttle { [unowned self] in
            self.loadSearchResults(with: query, clearResults: true)
        }
    }

    func loadSearchResults(with query: String, clearResults: Bool = false) {

    }
    
}
