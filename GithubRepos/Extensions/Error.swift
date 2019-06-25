//
//  Error.swift
//  GithubRepos
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/25/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import Foundation

enum LoginError: Error {
    case invalidUserOrPassword
}

enum DataError: Error {
    case jsonError
}

extension LoginError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUserOrPassword:
            return NSLocalizedString("Invalid username or password", comment: "")
        }
    }
}

extension DataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .jsonError:
            return NSLocalizedString("JSON error", comment: "")
        }
    }
}
