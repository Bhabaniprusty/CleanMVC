//
//  DetailInteractorTests.swift
//  CleanFlickr
//
//  Created by Nikita on 28/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

@testable import CleanFlickr
import XCTest

class DetailInteractorTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: DetailInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupDetailInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupDetailInteractor() {
        sut = DetailInteractor()
    }
    
    // MARK: Tests
    
    func testSomething() {
        // Given
        
        // When
        
        // Then
    }
}
