//
//  CustomWindowController.swift
//  TinyUDP
//
//  Created by Daniel Bonates on 16/03/17.
//  Copyright © 2017 Daniel Bonates. All rights reserved.
//

import Cocoa

class CustomWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.titleVisibility = .visible
        window?.titlebarAppearsTransparent = true
        window?.backgroundColor = .darkBackground
        window?.appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)
        window?.isMovableByWindowBackground = true
        if let infoDictionary = Bundle.main.infoDictionary, let appName = infoDictionary[String(kCFBundleNameKey)] as? String {
            window?.title = appName
        }
    }
}
