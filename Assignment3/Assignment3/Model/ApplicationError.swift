//
//  CustomError.swift
//  Split Mate
//
//  Created by Cooper Jacob on 28/5/2023.
//

import Foundation



enum ApplicationError: Error {
    case UserNotRetrieved
}


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
