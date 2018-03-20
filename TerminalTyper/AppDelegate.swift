//
//  AppDelegate.swift
//  TerminalTyper
//
//  Created by Daniel Bonates on 16/03/2018.
//  Copyright © 2018 Daniel Bonates. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    @IBAction func toogleTheme(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("toogleTheme"), object: nil)
    }

    @IBAction func runCommands(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("runCommands"), object: nil)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

