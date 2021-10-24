//
//  PKRepositoryServiceTests.swift
//  RepositoryTests
//
//  Created by pankaj.k.jha on 24/10/21.
//

import XCTest
@testable import Repository

class PKRepositoryServiceTests: XCTestCase {
    var sut: PKRepositoryService?
    override func setUp() {
        sut = PKRepositoryService()
    }
    
    override class func setUp() {
        
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func test_fetch_repository() {
        //Given Service
        let sut = self.sut!
        
        let expect = XCTestExpectation(description: "callback")
        
        sut.fetchRepositoryList(url: nil) { response, error in
            expect.fulfill()
            if let response = response {
                XCTAssertEqual( response.values?.count, 10)
                response.values?.forEach({ repo in
                    XCTAssertNotNil(repo.uuid)
                })
            }
        }
        
        wait(for: [expect], timeout: 3.0)
    }
}
