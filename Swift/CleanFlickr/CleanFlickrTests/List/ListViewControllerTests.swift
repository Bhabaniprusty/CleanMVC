//
//  ListViewControllerTests.swift
//  CleanFlickr
//
//  Created by Bhabani on 28/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

@testable import CleanFlickr
import XCTest

class ListViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: ListViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupListViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Tests
    
    func testSomething() {
        // Given
        
        // When
        
        // Then
    }
}
