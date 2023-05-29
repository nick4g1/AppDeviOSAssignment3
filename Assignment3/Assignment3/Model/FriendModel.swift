//
//  Friends.swift
//  Assignment3
//
//  Created by Cooper Jacob on 13/5/2023.
//

import Foundation

// Basic struct to pull required details from UserProfiles

struct Friend {
    let name: String
    let email: String

    init(name: String, email: String) {
        if name == "" {
            self.name = email
        } else {
            self.name = name
        }
        self.email = email
    }
}


