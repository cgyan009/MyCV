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
