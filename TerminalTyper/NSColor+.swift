//
//  NSColor+.swift
//  Terminal Typer
//
//  Created by Daniel Bonates on 16/03/2018.
//  Copyright © 2018 Daniel Bonates. All rights reserved.
//

import Cocoa

extension NSColor {
    static var lightText: NSColor { return #colorLiteral(red: 0.8352941176, green: 0.9764705882, blue: 0.9764705882, alpha: 1) }
    static var darkText: NSColor { return #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1) }

    static var lightBackground: NSColor { return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) }
    static var darkBackground: NSColor { return #colorLiteral(red: 0.1601257622, green: 0.1645516157, blue: 0.1861833036, alpha: 1) }
}
