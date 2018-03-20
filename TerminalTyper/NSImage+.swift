//
//  NSImage+.swift
//  Terminal Typer
//
//  Created by Daniel Bonates on 16/03/2018.
//  Copyright © 2018 Daniel Bonates. All rights reserved.
//

import Cocoa

extension NSImage {
    func tint(with color: NSColor) -> NSImage {
        guard let cgImage = self.cgImage(forProposedRect: nil, context: nil, hints: nil) else { return self }

        return NSImage(size: size, flipped: false) { bounds in
            guard let context = NSGraphicsContext.current?.cgContext else { return false }
            color.set()
            context.clip(to: bounds, mask: cgImage)
            context.fill(bounds)
            return true
        }
    }
}
