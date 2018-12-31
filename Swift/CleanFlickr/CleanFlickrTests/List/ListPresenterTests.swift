//
//  ListPresenterTests.swift
//  CleanFlickr
//
//  Created by Bhabani on 28/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

@testable import CleanFlickr
import XCTest

class ListPresenterTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: ListPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupListPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListPresenter() {
        sut = ListPresenter()
    }
    
    // MARK: Tests
    
    func testSomething() {
        // Given
        
        // When
        
        // Then
    }
}
