//
//  SearchGroup.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

final class SearchGroup<SearchResult> {
    var searchResults = [SearchResult]()
    var page: UInt = 0
    var canLoadMore = false
}

extension SearchGroup {
    func reset() {
        searchResults = [SearchResult]()
        page = 0
        canLoadMore = false
    }
    
    func append(results: [SearchResult]?, page: UInt, canLoadMore: Bool) {
        if let results = results {
            searchResults.append(contentsOf: results)
        }
        self.page = page
        self.canLoadMore = canLoadMore
    }
}
