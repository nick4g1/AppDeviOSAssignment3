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


enum SignInErrors: Error {
    case fieldsNotComplete(String)
    case passwordTooShort(String)
    case passwordsDontMatch(String)
}
