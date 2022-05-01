//
//  ErrorHelper.swift
//  xkcd
//
//  Created by Andrii Momot on 01.05.2022.
//

import Foundation

enum AppError: String, Error {
    case defaultError = "Oooops. Something went wrong! Please try again later."
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        return rawValue
    }
}
