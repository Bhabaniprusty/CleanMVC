//
//  JsonMocks.swift
//  CleanFlickr
//
//  Created by Bhabani on 28/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import Foundation

enum JsonMocks: String {
    case FlickrPhotos
}

extension JsonMocks {
    private var data: Data {
        @objc class TestClass: NSObject { }
        let bundle = Bundle(for: TestClass.self)
        guard let url = bundle.url(forResource: self.rawValue, withExtension: "json") else {
            fatalError("mock file \(self.rawValue) not found")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("mock file \(self.rawValue) not found")
        }
        return data
    }
    
    func model<T: Decodable>() -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try! decoder.decode(T.self, from: data)
    }
}
