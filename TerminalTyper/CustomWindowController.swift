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
        
        
        
        if let window = window {
            let gearButton = NSButton()
            gearButton.image = #imageLiteral(resourceName: "gear").tint(with: #colorLiteral(red: 0.6502072811, green: 0.6640738845, blue: 0.7550183535, alpha: 1))
            gearButton.imageScaling = .scaleProportionallyDown
            gearButton.appearance = NSAppearance(named: NSAppearance.Name.aqua)
            gearButton.bezelStyle = .rounded
            gearButton.isBordered = false
            let titleBarView = window.standardWindowButton(.closeButton)!.superview!
            titleBarView.addSubview(gearButton)
            gearButton.translatesAutoresizingMaskIntoConstraints = false
            titleBarView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[gearButton]-2-|", options: [], metrics: nil, views: ["gearButton": gearButton]))
            titleBarView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[gearButton]-2-|", options: [], metrics: nil, views: ["gearButton": gearButton]))
            
            
            gearButton.target = self
            gearButton.action = #selector(openSettings(_:))
            
            
            let playButton = NSButton()
            playButton.image = #imageLiteral(resourceName: "playBtn").tint(with: #colorLiteral(red: 0.6502072811, green: 0.6640738845, blue: 0.7550183535, alpha: 1))
            playButton.imageScaling = .scaleProportionallyDown
            playButton.appearance = NSAppearance(named: NSAppearance.Name.aqua)
            playButton.bezelStyle = .rounded
            playButton.isBordered = false

            titleBarView.addSubview(playButton)
            playButton.translatesAutoresizingMaskIntoConstraints = false
            titleBarView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[playButton]-25-|", options: [], metrics: nil, views: ["playButton": playButton, "gearButton": gearButton]))
            titleBarView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[playButton]-2-|", options: [], metrics: nil, views: ["playButton": playButton]))
        
            playButton.target = self
            playButton.action = #selector(runCommands(_:))
            
            
            let themeButton = NSButton()
            themeButton.image = #imageLiteral(resourceName: "themeBtn").tint(with: #colorLiteral(red: 0.6502072811, green: 0.6640738845, blue: 0.7550183535, alpha: 1))
            themeButton.imageScaling = .scaleProportionallyDown
            themeButton.appearance = NSAppearance(named: NSAppearance.Name.aqua)
            themeButton.bezelStyle = .rounded
            themeButton.isBordered = false
            titleBarView.addSubview(themeButton)
            themeButton.translatesAutoresizingMaskIntoConstraints = false
            titleBarView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[themeButton]-(-5)-[playButton]", options: [], metrics: nil, views: ["themeButton": themeButton, "playButton": playButton]))
            titleBarView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[themeButton]-2-|", options: [], metrics: nil, views: ["themeButton": themeButton]))
            
            themeButton.target = self
            themeButton.action = #selector(toogleTheme(_:))
            
        }
        
    }
    
    @objc func toogleTheme(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("toogleTheme"), object: nil)
    }
    
    @objc func runCommands(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("runCommands"), object: nil)
    }
    
    @objc func openSettings(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("openSettings"), object: nil)
    }
}
