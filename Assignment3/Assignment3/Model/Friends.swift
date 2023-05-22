//
//  Friends.swift
//  Assignment3
//
//  Created by Cooper Jacob on 13/5/2023.
//

import Foundation
import Fakery

struct Friend {
    let name: String
    let email: String
    var totalMoneySent: Double = 0
}



class Friends {
    func generateFriends() -> [Friend] {
        let faker = Faker()
        
        var friends: [Friend] = []
        for _ in 1...10 {
            let randomName = faker.name.name()
            let randomEmail = faker.internet.email()
            friends.append(Friend(name: randomName, email: randomEmail))
        }
        return friends
    }
}
// Generate 10 fake Friends and append them to the array


