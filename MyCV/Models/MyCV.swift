//
//  MyCV.swift
//  MyCV
//
//  Created by Chenguo Yan on 2019-12-24.
//  Copyright © 2019 Chenguo Yan. All rights reserved.
//

import Foundation

private let defaultString = ""

struct MyCV: Decodable {
    
    let basics: BasicInfo
    let work: [Work]
    let education: [Education]
    let skills: [Skill]
    let languages: [Language]
    
    var sections: [(String, [CVSectionProtocol])] {
        return [("Work", work),
                ("Education", education),
                ("Skills", skills),
                ("Langulages", languages)]
    }
}

struct BasicInfo: Decodable {
    var name: String = defaultString
    var label: String = defaultString
    var picture: String = defaultString
    var email: String = defaultString
    var website: String = defaultString
    var location: Location
    
}

struct Location: Decodable, CVSectionProtocol {
    func toString() -> String {
        return """
        Address: \(address)
        \(postalCode), \(city)
        \(region), \(countryCode)
        """
    }
    
    let address: String
    let postalCode: String
    let city: String
    let countryCode: String
    let region: String
}
struct Work: Decodable, CVSectionProtocol {
    func toString() -> String {
        var highlightString = ""
        highlights.forEach { (str) in
            highlightString += str
        }
        return """
        \(company) from: \(startDate) to:  \(endDate)
        Highlights: \(highlightString)
        \(website)
        """
    }
    let company: String
    let position: String
    let website: String
    let startDate: String
    let endDate: String
    let summary: String
    let highlights: [String]
}

struct Education: Decodable, CVSectionProtocol {
    func toString() -> String {
        var courseString = ""
        courses.forEach { (str) in
            courseString += "\(str), "
        }
        return """
        \(institution) from: \(startDate) to: \(endDate),
        Area: \(area),
        GPA: \(gpa),
        Courses: \(courseString)
        """
    }
    let institution: String
    let area: String
    let studyType: String
    let startDate: String
    let endDate: String
    let gpa: String
    let courses: [String]
}

struct Skill: Decodable, CVSectionProtocol {
    func toString() -> String {
        var keywordString = ""
        keywords.forEach { (str) in
            keywordString += "\(str), "
        }
        return """
        \(name), \(level),
        Keywords: \(keywordString)
        """
    }
    let name: String
    let level: String
    let keywords: [String]
}
struct Language: Decodable, CVSectionProtocol {
    func toString() -> String {
        return "\(language), Fluency: \(fluency)"
    }
    let language: String
    let fluency: String
}
