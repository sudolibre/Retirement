//
//  MortalBeing.swift
//  Retirement
//
//  Created by Jonathon Day on 12/27/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

class MortalBeing: CustomStringConvertible {
//     We will being by asking for the users current age and the age at which they would like to retire. As age is avalue relative to a birthday we will store the birth year. There will be some level of inaccuracy.
    let name: String
    //this is an approximation of the users birth date
    let birthDate: Date
    //this is an approximation of the users retirement date
    var retirementDate: Date
    let calendar = Calendar(identifier: .gregorian)
    
    var currentAge: Int {
        let componentYear: Set<Calendar.Component> = [Calendar.Component.year]
        let currentDate = Date()
        return calendar.dateComponents(componentYear, from: birthDate, to: currentDate).year!
    }
    
    var retirementAge: Int {
        let componentYear: Set<Calendar.Component> = [Calendar.Component.year]
        return calendar.dateComponents(componentYear, from: birthDate, to: retirementDate).year!
    }
    
    var currentYear: Int {
        let currentDate = Date()
        return calendar.component(.year, from: currentDate)
    }
    
    var yearsUntilRetirement: Int {
        let componentYear: Set<Calendar.Component> = [Calendar.Component.year]
        let currentDate = Date()
        guard let yearDifference = calendar.dateComponents(componentYear, from: currentDate, to: retirementDate).year else {
            fatalError()
        }
        return yearDifference
    }
    
    var yearOfRetirement: Int {
        return calendar.component(.year, from: retirementDate)
    }
    
    var description: String {
        return "You have \(yearsUntilRetirement) years left until you can retire.\n \(name), it is \(currentYear), so you can retire in \(yearOfRetirement)."
    }
    
    var jsonRepresentation: [String: Any] {
        return ["name": name, "birthdate": birthDate.timeIntervalSinceReferenceDate, "retirementDate": retirementDate.timeIntervalSinceReferenceDate]
    }
    
    init(name: String, age: Int, retirementAge: Int) {
        let currentDate = Date()
        let negativeAge = -age
        guard let birthDateFromAge = calendar.date(byAdding: .year, value: negativeAge, to: currentDate) else {
            fatalError()
        }
        birthDate = birthDateFromAge

        guard let retirementDateFromAge = calendar.date(byAdding: .year, value: retirementAge, to: birthDateFromAge) else {
            fatalError()
        }
        
        retirementDate = retirementDateFromAge
        
        self.name = name
    }
    
    init(jsonData: [String: Any]) {
        name = jsonData["name"] as! String
        birthDate = Date(timeIntervalSinceReferenceDate: jsonData["birthdate"] as! Double)
        retirementDate = Date(timeIntervalSinceReferenceDate: jsonData["retirementDate"] as! Double)
    }
    
}


