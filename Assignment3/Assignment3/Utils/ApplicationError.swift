//
//  CustomError.swift
//  Split Mate
//
//  Created by Cooper Jacob on 28/5/2023.
//

import Foundation


// Custom error if user cannot be retrieved from local storage
enum ApplicationError: Error {
    case UserNotRetrieved
}

// Custom errors for input validation
enum SignInErrors: LocalizedError {
    case fieldsNotComplete(String)
    case passwordsDontMatch(String)

    var errorDescription: String? {
        switch self {
        case .fieldsNotComplete(let message):
            return message
        case .passwordsDontMatch(let message):
            return message
        }
    }
}
