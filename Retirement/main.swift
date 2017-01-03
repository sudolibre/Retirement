//
//  main.swift
//  Retirement
//
//  Created by Jonathon Day on 12/27/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation


func runLoop() {
    let users = Users()
    var userUsingApp = true
    
    while userUsingApp {
        let name = getStringAnswer(toQuestion: "What is your name?")
        
        if let existingUser = checkExistingUser(withName: name, in: users) {
            print(existingUser)
        } else {
            let age = getIntAnswer(toQuestion: "Hello \(name), what is your current age?")
            let retirementAge = getIntAnswer(toQuestion: "At what age would you like to retire?")
            let newUser = MortalBeing(name: name, age: age, retirementAge: retirementAge)
            users.addUser(newUser)
            print(newUser)
        }
        
        userUsingApp = getYesOrNoAnswer(toQuestion: "Would you like to start over?")
    }
}

func checkExistingUser(withName name: String, in users: Users) -> MortalBeing? {
    if let indexForExistingUser = users.people.index(where: { $0.name == name }) {
        let potentiallyTheUser = users.people[indexForExistingUser]
        if getYesOrNoAnswer(toQuestion: "Hello \(name)! Are you \(potentiallyTheUser.currentAge) and plan to retire at \(potentiallyTheUser.retirementAge)?") {
            return potentiallyTheUser
        }
    }
    return nil
}

func getStringAnswer(toQuestion question: String) -> String {
    var stringAnswer: String?
    
    print(question)
    
    while stringAnswer == nil {
        if let answer = readLine(strippingNewline: true) {
            stringAnswer = answer
        } else {
            print("We didn't get that please try again")
        }
    }
    
    return stringAnswer!
}

func getIntAnswer(toQuestion question: String) -> Int {
    var intAnswer: Int?
    
    print(question)
    
    while intAnswer == nil {
        if let stringAnswer = readLine(strippingNewline: true), let answer = Int(stringAnswer) {
            intAnswer = answer
        } else {
            print("We didn't get that please try again")
        }
    }
    
    return intAnswer!
}

func getYesOrNoAnswer(toQuestion question: String) -> Bool {
    var boolAnswer: Bool?
    
    print(question + " (y/n)")
    
    while boolAnswer == nil {
        if let stringAnswer = readLine(strippingNewline: true) {
            switch stringAnswer {
                case "y", "Y", "YES", "yes", "Yes":
                boolAnswer = true
            case "n", "N", "NO", "no", "No":
                boolAnswer = false
            default:
                continue
            }
        } else {
            print("We didn't get that please try again")
        }
    }
    
    return boolAnswer!
}

runLoop()

//Test saving to and reloading from JSON.
//Create a program that determines how many years you have left until retirement and the year you can retire. It should prompt for your current age and the age you want to retire and display the output as shown in the example that follows.
//
//be sure to convert the input to a number and work with that within the program.
//Don’t hard code the current year into the program. Get it from the system time via Date & DateComponents
//Save the name, age, and retirement ages entered and use them to streamline future runs of the program


//EXAMPLE:
//What is your name? Alonzo
//Hello Alonzo, what is your current age? 25
//At what age would you like to retire? 65
//
//You have 40 years left until you can retire.
//Alonzo, it is 2016, so you can retire in 2056.
//
//-----------------------
//
//What is your name? Alonzo
//Hello Alonzo! Are you 25 and plan to retire at 65? (y/n) y
//
//You have 40 years left until you can retire.
//Alonzo, it is 2016, so you can retire in 2056.
//
//-----------------------
//
//What is your name? Alonzo
//Hello Alonzo! Are you 25 and plan to retire at 65? (y/n) n
//Hello Alonzo, what is your current age? 25
//At what age would you like to retire? 65
//
//You have 40 years left until you can retire.
//Alonzo, it is 2016, so you can retire in 2056.
//


