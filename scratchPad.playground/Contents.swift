//: Playground - noun: a place where people can play

import UIKit
import Foundation

let calendar = Calendar(identifier: .gregorian)

class MortalBeing: CustomStringConvertible {
    //     We will being by asking for the users current age and the age at which they would like to retire. As age is avalue relative to a birthday we will store the birth year. There will be some level of inaccuracy.
    var name: String
    //this is an approximation of the users birth date
    var birthDate: Date
    //this is an approximation of the users retirement date
    var retirementDate: Date
    
    
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
        return "You have \(yearsUntilRetirement) years left until you can retire. \n \(name), it is \(currentYear), so you can retire in \(yearOfRetirement)."
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
    
}

let alanzo = MortalBeing(name: "alanzo", age: 25, retirementAge: 65)
let martin = MortalBeing(name: "martin", age: 12, retirementAge: 77)

struct Users {
    var people: [MortalBeing]
}

let users = Users(people: [alanzo, martin])


var asdf = ["number": 90970970970]

let json = try? JSONSerialization.data(withJSONObject: asdf, options: [])

let url = URL.init(fileURLWithPath: "/Users/noj/Code/TIY/Retirement/JSONTesting.txt")

print(url)

try! json!.write(to: url, options: [.atomic])

