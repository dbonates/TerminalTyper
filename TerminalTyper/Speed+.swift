//
//  Speed+.swift
//  Terminal Typer
//
//  Created by Daniel Bonates on 16/03/2018.
//  Copyright © 2018 Daniel Bonates. All rights reserved.
//

import Foundation

enum Speed {
    case fast
    case superFast
    case realistic

    var value: Double {
        switch self {
        case .fast:
            return 2
        case .superFast:
            return 4
        case .realistic:
            return 1
        }
    }
}
