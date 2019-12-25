//
//  MockCVApi.swift
//  MyCVTests
//
//  Created by Chenguo Yan on 2019-12-24.
//  Copyright © 2019 Chenguo Yan. All rights reserved.
//

import Foundation
@testable import MyCV

class MockCVApi {
    
    var shouldReturnError = false
    let mockedCV: [String: Any] = [
        "basics": [
            "name": "Bill Smith",
            "label": "developer",
            "picture": "https://www.gstatic.com/webp/gallery/1.jpg",
            "email": "bill@gmail.com",
            "phone": "(780) 555-4321",
            "website": "http://bill.me",
            "summary": "A summary of Bill Smith...",
            "location": [
                "address": "2712 Broadway St",
                "postalCode": "CA 94115",
                "city": "San Francisco",
                "countryCode": "US",
                "region": "California"
            ]
        ],
        "work": [[
            "company": "Google",
            "position": "President",
            "website": "http://company.com",
            "startDate": "2014-01-01",
            "endDate": "2019-12-01",
            "summary": "Description...",
            "highlights": [
                "Started the company"
            ]
            ],
                 [
                    "company": "Apple",
                    "position": "Developer",
                    "website": "http://company.com",
                    "startDate": "2013-01-01",
                    "endDate": "2014-01-01",
                    "summary": "Description...",
                    "highlights": [
                        "Started the company"
                    ]
            ],
                 [
                    "company": "GM",
                    "position": "President",
                    "website": "http://company.com",
                    "startDate": "2012-01-01",
                    "endDate": "2013-01-01",
                    "summary": "Description...",
                    "highlights": [
                        "Started the company"
                    ]
            ]],
        "education": [[
            "institution": "University",
            "area": "Software Development",
            "studyType": "Bachelor",
            "startDate": "2011-01-01",
            "endDate": "2013-01-01",
            "gpa": "4.0",
            "courses": [
                "DB1101 - Basic SQL"
            ]
            ]],
        "skills": [[
            "name": "Web Development",
            "level": "Master",
            "keywords": [
                "HTML",
                "CSS",
                "Javascript"
            ]
            ]],
        "languages": [[
            "language": "English",
            "fluency": "Native speaker"
            ]]
    ]
    
    enum MockServiceError: Error {
        case fetchCV
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
}

extension MockCVApi: CVFetchable {
    func fetchCV(completion: @escaping (dictionary?, Error?) -> Void) {
        if shouldReturnError {
            completion(nil, MockServiceError.fetchCV)
        } else {
            completion(mockedCV,nil)
        }
    }
}

