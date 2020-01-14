//
//  MyCVTests.swift
//  MyCVTests
//
//  Created by Chenguo Yan on 2019-12-22.
//  Copyright © 2019 Chenguo Yan. All rights reserved.
//

import XCTest
@testable import MyCV

class MyCVTests: XCTestCase {
    
    func testFetchCVSuccessfully() {
        let mockCVApi = MockCVApi()
        mockCVApi.shouldReturnError = false
        let vm = CVViewModel(api: mockCVApi)
        let notificationExpectation = expectation(forNotification: .cvNotification, object: vm, handler: nil)

        vm.decodeCV()
        
        wait(for: [notificationExpectation], timeout: 1)
    }
    
    func testWorkToString() {
        let work = Work(company: "Google",
                        position: "Product Manager",
                        website: "www.google.com",
                        startDate: "2010-02-21",
                        endDate: "2018-07-15",
                        summary: "Release Android",
                        highlights: ["Lead Flutter Project"])
        print(work.toString())
    }
    
    func testFetchCVWithError() {
        mockFetchCV(shouldReturnError: true)
    }
    
    private func mockFetchCV(shouldReturnError: Bool) {
        let expectation = self.expectation(description: "Fetch CV Expectation")
        let mockCVApi = MockCVApi()
        mockCVApi.shouldReturnError = shouldReturnError
        mockCVApi.fetchCV { (json, error) in
            XCTAssertNil(error)
            guard let json = json else {
                XCTFail()
                return
            }
            do {
                let data = try JSONSerialization.data(withJSONObject: json, options: [])
                let cv = try JSONDecoder().decode(MyCV.self, from: data)
                XCTAssertNotNil(cv)
                expectation.fulfill()
                
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
}
