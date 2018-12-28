//
//  ListInteractorTests.swift
//  CleanFlickr
//
//  Created by Nikita on 28/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

@testable import CleanFlickr
import XCTest

class ListInteractorTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: ListInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupListInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListInteractor() {
        sut = ListInteractor()
    }
    
    // MARK: Tests
    
    func testSomething() {
        // Given
        
        // When
        
        // Then
    }
}
