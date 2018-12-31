//
//  DetailPresenterTests.swift
//  CleanFlickr
//
//  Created by Bhabani on 28/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

@testable import CleanFlickr
import XCTest

class DetailPresenterTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: DetailPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupDetailPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupDetailPresenter() {
        sut = DetailPresenter()
    }
    
    // MARK: Tests
    
    func testSomething() {
        // Given
        
        // When
        
        // Then
    }
}
