//
//  MyCVUITests.swift
//  MyCVUITests
//
//  Created by Chenguo Yan on 2019-12-22.
//  Copyright © 2019 Chenguo Yan. All rights reserved.
//

import XCTest

class MyCVUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
        
    }
    
    func testFetchCVSuccessfullyUI() {
     
         let app = XCUIApplication()
         app.launch()
         
         XCTAssertTrue(app.staticTexts["Bill Smith"].exists)
         let tablesQuery = app.tables

         XCTAssertTrue(tablesQuery.staticTexts["Work"].exists)
         XCTAssertTrue(tablesQuery.staticTexts["Education"].exists)
         XCTAssertTrue(tablesQuery.staticTexts["Skills"].exists)
         XCTAssertTrue(tablesQuery.staticTexts["Langulages"].exists)
     }

}
