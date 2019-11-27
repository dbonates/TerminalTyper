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
        
//        var isRunning = false
//        
//        let apps = NSWorkspace.shared.runningApplications
//        
//        apps.forEach {
//            if $0.localizedName!.contains("iTerm") {
//                NSWorkspace.shared.launchApplication($0.localizedName!)
//                isRunning = true
//            }
//        }
//        
//        if isRunning {
//            NSWorkspace.shared.launchApplication("iTerm")
//        } else {
//            NSWorkspace.shared.launchApplication("iTerm")
//        }
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

