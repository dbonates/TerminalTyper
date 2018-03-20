//
//  SettingsViewController.swift
//  Terminal Typer
//
//  Created by Daniel Bonates on 16/03/2018.
//  Copyright © 2018 Daniel Bonates. All rights reserved.
//

import Cocoa

class SettingsViewControllerOLD: NSViewController {

    weak var delegate: ViewController?
    var terminalTool: TerminalTool = .terminal
    var speed: Double = 0.3

    var demoChars = [String]()
    var timer = Timer()

    let demoString = "I ❤️ Terminal Typer Robot!"

    @IBOutlet weak var speedSlider: NSSlider!

    @IBOutlet weak var demoLabel: NSTextField!

    @IBOutlet weak var toolCombo: NSComboBox!



    @IBAction func toolChanged(_ sender: Any) {

        var tt: TerminalTool

        switch toolCombo.indexOfSelectedItem {

        case 1:
            tt = .iTerm
        case 2:
            tt = .sublime
        case 3:
            tt = .code
        default:
            tt = .terminal
        }

        delegate?.terminalTool =   tt

    }

    func restartSimulation() {

        let commands = demoString

        var result = [String]()

        commands.forEach {
            result.append("\($0)")
        }


        demoChars = result

        demoLabel.stringValue = ""

        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true, block: { _ in
            self.typeOnDemoField()
        })
    }


    func typeOnDemoField() {

        if demoChars.isEmpty {
            restartSimulation()
            return
        }

        let char = demoChars.removeFirst()
        let currentText = demoLabel.stringValue

        demoLabel.stringValue = currentText + char
    }


    func configureWith(speed: Double, terminalTool: TerminalTool) {
        self.speed = speed
        self.terminalTool = terminalTool
    }


    @IBAction func changeSpeed(_ sender: Any) {
        
        
        guard let delegate = self.delegate else { return }
        delegate.speed = delegate.defaultSpeed / speedSlider.doubleValue
        self.speed = delegate.speed
        restartSimulation()
    }

    override func viewDidLayout() {
        super.viewDidLayout()

        guard let delegate = self.delegate else { return }

        self.terminalTool = delegate.terminalTool
        self.speed = delegate.speed

        speedSlider.doubleValue = delegate.defaultSpeed / delegate.speed

        switch delegate.terminalTool {

        case .terminal:
            toolCombo.selectItem(at: 0)
        case .iTerm:
            toolCombo.selectItem(at: 1)
        case .sublime:
            toolCombo.selectItem(at: 2)
        case .code:
            toolCombo.selectItem(at: 3)
        }

        restartSimulation()
    }

}
