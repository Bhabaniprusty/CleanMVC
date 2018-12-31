//
//  ObjectCache.swift
//  CleanFlickr
//
//  Created by Bhabani on 31/12/2018.
//  Copyright © 2018 Bhabani. All rights reserved.
//

import UIKit

protocol ObjectCache {
    associatedtype T: Sizable
    func add(_ object: T, for identifier: String)
    func object(for identifier: String) -> T?
}

class AutoPurgingObjectCache<T: Sizable>: ObjectCache {
    
    func add(_ object: T, for identifier: String) {
        synchronizationQueue.async(flags: [.barrier]) {
            let cacheObject = CachedObject(object, identifier: identifier)
            
            if let previousCachedObject = self.cachedObjects[identifier] {
                self.currentMemoryUsage -= previousCachedObject.objectSize
            }
            
            self.cachedObjects[identifier] = cacheObject
            self.currentMemoryUsage += cacheObject.objectSize
        }
        
        synchronizationQueue.async(flags: [.barrier]) {
            if self.currentMemoryUsage > self.memoryCapacity {
                let bytesToPurge = self.currentMemoryUsage - self.preferredMemoryUsageAfterPurge
                var sortedObjects = self.cachedObjects.map { $1 }
                sortedObjects.sort { $0.lastAccessDate < $1.lastAccessDate }
                var bytesPurged = UInt64(0)
                
                for cachedObject in sortedObjects {
                    self.cachedObjects.removeValue(forKey: cachedObject.identifier)
                    bytesPurged += cachedObject.objectSize
                    
                    if bytesPurged >= bytesToPurge {
                        break
                    }
                }
                
                self.currentMemoryUsage -= bytesPurged
            }
        }
    }
    
    func object(for identifier: String) -> T? {
        var object: T?
        
        synchronizationQueue.sync {
            object = self.cachedObjects[identifier]?.accessObject()
        }
        
        return object
    }
    
    private func removeImage(withIdentifier identifier: String) {
        synchronizationQueue.sync {
            if let cachedImage = cachedObjects.removeValue(forKey: identifier) {
                self.currentMemoryUsage -= cachedImage.objectSize
            }
        }
    }
    
    @objc private func removeAllObjects() {
        synchronizationQueue.sync {
            if !self.cachedObjects.isEmpty {
                self.cachedObjects.removeAll()
                self.currentMemoryUsage = 0
            }
        }
    }
    
    public let memoryCapacity: UInt64
    public let preferredMemoryUsageAfterPurge: UInt64
    private var currentMemoryUsage: UInt64 = 0
    private var cachedObjects: [String: CachedObject<T>]
    private let synchronizationQueue = DispatchQueue(label: "com.bhabani.objectCache",
                                                     attributes: .concurrent)
    
    public init(memoryCapacity: UInt64 = 100_000_000,
                preferredMemoryUsageAfterPurge: UInt64 = 60_000_000) {
        self.memoryCapacity = memoryCapacity
        self.preferredMemoryUsageAfterPurge = preferredMemoryUsageAfterPurge
        cachedObjects = [String: CachedObject<T>]()
        
        let notification = UIApplication.didReceiveMemoryWarningNotification
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(AutoPurgingObjectCache.removeAllObjects),
            name: notification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension AutoPurgingObjectCache {
    class CachedObject<T: Sizable> {
        let object: T
        let identifier: String
        let objectSize: UInt64
        var lastAccessDate: Date
        
        init(_ object: T, identifier: String) {
            self.object = object
            self.identifier = identifier
            lastAccessDate = Date()
            objectSize = object.bytes
        }
        
        func accessObject() -> T {
            lastAccessDate = Date()
            return object
        }
    }
}

protocol Sizable {
    var bytes: UInt64 { get }
}
