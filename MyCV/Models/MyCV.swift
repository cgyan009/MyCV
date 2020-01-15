//
//  MyCV.swift
//  MyCV
//
//  Created by Chenguo Yan on 2019-12-24.
//  Copyright © 2019 Chenguo Yan. All rights reserved.
//

import Foundation

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
    
    let name: String
    let label: String
    let picture: String
    let email: String
    let website: String
    let location: Location
}

struct Location: Decodable, CVSectionProtocol {
    
    let address: String
    let postalCode: String
    let city: String
    let countryCode: String
    let region: String
    private let addressString = "Address"
    
    func toString() -> String {
        return """
        \(addressString): \(address)
        \(postalCode), \(city)
        \(region), \(countryCode)
        """
    }
}
struct Work: Decodable, CVSectionProtocol {
    
    let company: String
    let position: String
    let website: String
    let startDate: String
    let endDate: String
    let summary: String
    let highlights: [String]
    private let hightlightsString = "Highlights"
    private let fromString = "From"
    private let toStr = "To"
    private let positionString = "position"
    
    func toString() -> String {
        var highlightStr = ""
        highlights.forEach { (str) in
            highlightStr += str
        }
        return """
        \(position)
        \(company) \(fromString): \(startDate) \(toStr):  \(endDate)
        \(hightlightsString): \(highlightStr)
        \(website)
        """
    }
}

struct Education: Decodable, CVSectionProtocol {
    
    let institution: String
    let area: String
    let studyType: String
    let startDate: String
    let endDate: String
    let gpa: String
    let courses: [String]
    private let areaString = "Area"
    private let gpaString = "GPA"
    private let coursesString = "Courses"
    private let fromString = "From"
    private let toStr = "To"
    
    func toString() -> String {
        var courseStr = ""
        courses.forEach { (str) in
            courseStr += "\(str), "
        }
        courseStr = String(courseStr.dropLast(2))
        return """
        \(institution) \(fromString): \(startDate) \(toStr): \(endDate)
        \(areaString): \(area)
        \(gpaString): \(gpa)
        \(coursesString): \(courseStr)
        """
    }
}

struct Skill: Decodable, CVSectionProtocol {
    
    let name: String
    let level: String
    let keywords: [String]
    private let keywordsString = "Keywords"
    
    func toString() -> String {
        var keywordStr = ""
        keywords.forEach { (str) in
            keywordStr += "\(str), "
        }
        keywordStr = String(keywordStr.dropLast(2))
        return """
        \(name), \(level),
        \(keywordsString): \(keywordStr)
        """
    }
}
struct Language: Decodable, CVSectionProtocol {
    
    let language: String
    let fluency: String
    private let fluencyString = "Fluency"
    
    func toString() -> String {
        return "\(language), \(fluencyString): \(fluency)"
    }
}
