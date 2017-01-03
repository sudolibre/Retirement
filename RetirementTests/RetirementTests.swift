//
//  RetirementTests.swift
//  RetirementTests
//
//  Created by Jonathon Day on 12/27/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import XCTest
@testable import Retirement

class RetirementTests: XCTestCase {
    
    func testDescription() {
        let alanzo = MortalBeing(name: "Alonzo", age: 25, retirementAge: 65)
        let result = alanzo.description
        let expected = "You have 39 years left until you can retire.\n Alonzo, it is 2016, so you can retire in 2056."
        XCTAssertTrue(result == expected)
    }
    
    func testJSONInitialization() {
        let calendar = Calendar(identifier: .gregorian)
        let alanzo = MortalBeing(name: "Alonzo", age: 25, retirementAge: 65)
        let alanzoEncodedJSON = try! JSONSerialization.data(withJSONObject: alanzo.jsonRepresentation , options: [])
        let alanzoDecodedJSON = try! JSONSerialization.jsonObject(with: alanzoEncodedJSON, options: [])
        let alanzoResurrected = MortalBeing(jsonData: alanzoDecodedJSON as! [String: Any])
        XCTAssertEqual(calendar.compare(alanzo.birthDate, to: alanzoResurrected.birthDate, toGranularity: .second), ComparisonResult.orderedSame)
        XCTAssertEqual(calendar.compare(alanzo.retirementDate, to: alanzoResurrected.retirementDate, toGranularity: .second), ComparisonResult.orderedSame)
        XCTAssertEqual(alanzo.name, alanzoResurrected.name)

        
    }
    
    func testCurrentAge() {
        let alanzo = MortalBeing(name: "Alonzo", age: 25, retirementAge: 65)
        let result = alanzo.currentAge
        let expected = 25
        XCTAssertEqual(result, expected)
    }
    
    func testRetirementAge() {
        let alanzo = MortalBeing(name: "Alonzo", age: 25, retirementAge: 65)
        let result = alanzo.retirementAge
        let expected = 65
        XCTAssertEqual(result, expected)
    }
    
    func testSaveAndLoadUsers() {
        let users = Users()
        let alanzo = MortalBeing(name: "alonzo", age: 25, retirementAge: 65)
        let martin = MortalBeing(name: "martin", age: 12, retirementAge: 77)
        users.addUser(alanzo)
        users.addUser(martin)
        let users2 = Users()
        XCTAssertTrue(users2.people.count == users.people.count)
    }
    
}
