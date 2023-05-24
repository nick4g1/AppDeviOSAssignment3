//
//  Profile.swift
//  Split Mate
//
//  Created by Jake Isaacs on 22/5/2023.
//

import Foundation

struct Profile {
    
    var name: String
    var email: String
    var phoneNumber: String
    var friends: [Friend] = []
	
	var transactions: [Transaction]
}

struct Transaction {
	let friend: Friend
	let amount: Double
	let type: TransactionType
	let date: Date
}

enum TransactionType: Int {
	case send = -1
	case recieve = 1
}
