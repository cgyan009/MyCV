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
    
    func testWorkToString() {
        let work = Work(company: "Google",
                        position: "Product Manager",
                        website: "www.google.com",
                        startDate: "2010-02-21",
                        endDate: "2018-07-15",
                        summary: "Release Android",
                        highlights: ["Lead Flutter Project"])
        let workString = """
                        Product Manager
                        Google From: 2010-02-21 To:  2018-07-15
                        Highlights: Lead Flutter Project
                        www.google.com
                        """
        XCTAssert(workString == work.toString())
    }
    
    func testLocationToString() {
        let location = Location(address: "1 Main St",
                                postalCode: "N3R 0C5",
                                city: "Toronto",
                                countryCode: "CA",
                                region: "Ontario")
        let locationString = """
                        Address: 1 Main St
                        N3R 0C5, Toronto
                        Ontario, CA
                        """
        XCTAssert(location.toString() == locationString)
    }
    
    func testEducationToString() {
        let education = Education(institution: "University Of Toronto",
                                  area: "Engineering",
                                  studyType: "Master",
                                  startDate: "2019-4-12",
                                  endDate: "2020-1-12",
                                  gpa: "4.0",
                                  courses: ["Java", "Swift", "Accounting"])
        
        let educationString = """
                            University Of Toronto From: 2019-4-12 To: 2020-1-12
                            Area: Engineering
                            GPA: 4.0
                            Courses: Java, Swift, Accounting
                            """
        
        print(educationString)
        XCTAssert(education.toString() == educationString)
    }
    
    func testSkillToString() {
        let skill = Skill(name: "Mobile Development", level: "Entry level", keywords: ["Coca Touch", "Java"])
        
        let skillString = """
                Mobile Development, Entry level,
                Keywords: Coca Touch, Java
                """
        XCTAssert(skill.toString() == skillString)
        
    }
    
    func testLanguageToString() {
        let language = Language(language: "Franch", fluency: "Entry level")
        let languageString = "Franch, Fluency: Entry level"
        XCTAssert(language.toString() == languageString)
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
