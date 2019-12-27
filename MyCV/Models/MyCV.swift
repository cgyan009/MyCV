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
    
    func toString() -> String {
          return """
          Address: \(address)
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
}

struct Education: Decodable, CVSectionProtocol {
  
    let institution: String
    let area: String
    let studyType: String
    let startDate: String
    let endDate: String
    let gpa: String
    let courses: [String]
    
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
}

struct Skill: Decodable, CVSectionProtocol {
  
    let name: String
    let level: String
    let keywords: [String]
    
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
}
struct Language: Decodable, CVSectionProtocol {
   
    let language: String
    let fluency: String
    
    func toString() -> String {
           return "\(language), Fluency: \(fluency)"
       }
}
