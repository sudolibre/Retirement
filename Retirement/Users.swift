//
//  Users.swift
//  Retirement
//
//  Created by Jonathon Day on 12/27/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

class Users {
    var people = [MortalBeing]()
    
    var jsonRepresentation: [[String: Any]] {
        return people.map { $0.jsonRepresentation }
    }
    
    
    func addUser(_ user: MortalBeing) {
        people.append(user)
        self.save()
    }
    
    func save() {
        let json = try! JSONSerialization.data(withJSONObject: jsonRepresentation, options: [])
        let filePath = URL.init(fileURLWithPath: "/Users/noj/Code/TIY/Retirement/JSONTesting.txt")
        try! json.write(to: filePath, options: [.atomic])
    }
    
    init() {
        let filePath = URL.init(fileURLWithPath: "/Users/noj/Code/TIY/Retirement/JSONTesting.txt")
        let existingsUsers = try? Data(contentsOf: filePath)
        if existingsUsers != nil {
        print("Existings save found. Attempting to load.")
        let jsonUsers = try? JSONSerialization.jsonObject(with: existingsUsers!, options: [])
            if jsonUsers != nil {
            people = (jsonUsers as! [[String: Any]]).map { MortalBeing(jsonData: $0) }
            } else {
                print("No users found in save file")
            }
        } else {
            print("No existing users found. Starting an empty instance")
        }
    }

}
