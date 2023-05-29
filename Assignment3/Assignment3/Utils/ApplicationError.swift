//
//  CustomError.swift
//  Split Mate
//
//  Created by Cooper Jacob on 28/5/2023.
//

import Foundation


// Custom application errors
enum ApplicationError: Error {
    case userNotRetrieved
    case cannotGetTopView
}

// Custom errors for sign in and sign up functions
enum SignInErrors: LocalizedError {
    case fieldsNotComplete(String)
    case passwordsDontMatch(String)
    case googleSignInError(String)

    var errorDescription: String? {
        switch self {
        case .fieldsNotComplete(let message):
            return message
        case .passwordsDontMatch(let message):
            return message
        case .googleSignInError(let message):
            return message
        }

    }
}
