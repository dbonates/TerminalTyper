//
//  SettingsViewController.swift
//  Terminal Typer
//
//  Created by Daniel Bonates on 19/03/2018.
//  Copyright © 2018 Daniel Bonates. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController, NSComboBoxDelegate {

    weak var delegate: ViewController?

    var terminalTool: TerminalTool = .terminal
    var speed: Double = 0.3

    var demoChars = [String]()
    var timer = Timer()

    let demoString = "I ❤️ Terminal Typer Robot!"

    lazy var speedSliderLabel: NSTextField = {
        let lbl: NSTextField = NSTextField.baby()
        lbl.stringValue = "Type speed:"
        lbl.sizeToFit()
        lbl.isBordered = false
        lbl.isEditable = false
        lbl.backgroundColor = .clear
        return lbl
    }()

    lazy var speedSlider: NSSlider = {
        let slider: NSSlider = NSSlider.baby()
        slider.doubleValue = 1
        slider.minValue = 1
        slider.maxValue = 5
        slider.target = self
        slider.sliderType = .linear
        slider.tickMarkPosition = .below
        slider.numberOfTickMarks = 5
        slider.allowsTickMarkValuesOnly = true
        slider.wantsLayer = true
        slider.layer?.isOpaque = false
        slider.layer?.backgroundColor = NSColor.clear.cgColor
        slider.backgroundFilters = []

        slider.action = #selector(changeSpeed(_:))
        return slider
    }()

    lazy var demoLabelCaption: NSTextField = {
        let lbl: NSTextField = NSTextField.baby()
        lbl.stringValue = "Speed demo:"
        lbl.sizeToFit()
        lbl.isBordered = false
        lbl.isEditable = false
        lbl.backgroundColor = .clear
        return lbl
    }()

    lazy var demoLabel: NSTextField = {
        let lbl: NSTextField = NSTextField.baby()
        lbl.stringValue = demoString
        lbl.sizeToFit()
        lbl.isBordered = false
        lbl.isEditable = false
        lbl.backgroundColor = .clear
        return lbl
    }()


    lazy var toolComboCaption: NSTextField = {
        let lbl: NSTextField = NSTextField.baby()
        lbl.stringValue = "Terminal tool:"
        lbl.sizeToFit()
        lbl.isBordered = false
        lbl.isEditable = false
        lbl.backgroundColor = .clear
        return lbl
    }()

    
    lazy var toolCombo: NSPopUpButton = {
        let combo: NSPopUpButton = NSPopUpButton.baby()

        
        combo.action = #selector(toolChanged)
        combo.target = self
        combo.addItems(withTitles: ["Terminal", "iTerm", "Code"])
        combo.menu?.autoenablesItems = false
        
//        combo.menu?.addItem(withTitle: "Terminal", action: #selector(toolChanged), keyEquivalent: "")
//        combo.menu?.addItem(withTitle: "iTerm", action: #selector(toolChanged), keyEquivalent: "")
//        combo.menu?.addItem(withTitle: "Code", action: #selector(toolChanged), keyEquivalent: "")
//
        combo.itemArray.forEach {
            $0.isEnabled = true
        }
        
        return combo
    }()

    override func loadView() {
        let vibranceView = VibrancyView(frame: CGRect(x: 0, y: 0, width: 320, height: 200))
//        vibranceView.configure()

        self.view = vibranceView
        buildUI()
    }

    func buildUI() {

        view.addSubview(speedSliderLabel)
        speedSliderLabel.anchorOnTop()

        view.addSubview(speedSlider)
        speedSlider.anchorBelow(speedSliderLabel, topConstant: 0, margin: 20, fixedHeight: 24)



        view.addSubview(demoLabelCaption)
        demoLabelCaption.anchorBelow(speedSlider)

        view.addSubview(demoLabel)
        demoLabel.anchorBelow(demoLabelCaption, topConstant: 0, margin: 20)



        view.addSubview(toolComboCaption)
        toolComboCaption.anchorBelow(demoLabel)

        view.addSubview(toolCombo)
        toolCombo.anchorBelow(toolComboCaption, topConstant: 0, margin: 20, fixedHeight: 20)
        toolCombo.selectItem(at: 0)
//        toolCombo.delegate = self

        
        var frame = view.bounds
        let finalHeight = (20 * 4) + 20 + 24 + demoLabel.bounds.height + speedSlider.bounds.height + speedSliderLabel.bounds.height + demoLabelCaption.bounds.size.height + toolComboCaption.bounds.height

        frame.size.height = finalHeight
        view.frame = frame
    }


    convenience init(speed: Double, terminalTool: TerminalTool) {
        self.init(nibName: nil, bundle: nil)

        self.speed = speed
        self.terminalTool = terminalTool
    }


    override func viewWillAppear() {
        super.viewWillAppear()

        initializeValues()

    }
    override func viewDidAppear() {
        super.viewDidAppear()
        fireSimulation()
    }

    func initializeValues() {

        guard let delegate = self.delegate else { return }

        self.terminalTool = delegate.terminalTool
        self.speed = delegate.speed

        speedSlider.doubleValue = delegate.defaultSpeed / delegate.speed

        switch delegate.terminalTool {

        case .terminal:
            toolCombo.selectItem(at: 0)
        case .iTerm:
            toolCombo.selectItem(at: 1)
        case .code:
            toolCombo.selectItem(at: 2)
        }
    }

    @objc func changeSpeed(_ sender: Any) {
        guard let delegate = self.delegate else { return }
        delegate.speed = delegate.defaultSpeed / speedSlider.doubleValue
        self.speed = delegate.speed
        fireSimulation()
    }

    func comboBoxSelectionDidChange(_ notification: Notification) {
        toolChanged()
    }

    @objc func popUpSelectionDidChange(_ sender: NSPopUpButton) {
        if sender.indexOfSelectedItem == 0 {
            print("User has re-selected the initially selected item.")
        } else {
            print("User has selected some item other than the initially selected item.")
        }
    }
    
    @objc func toolChanged() {

        var tt: TerminalTool

        switch toolCombo.indexOfSelectedItem {

        case 1:
            tt = .iTerm
        case 2:
            tt = .code
        default:
            tt = .terminal
        }

        delegate?.terminalTool =   tt

    }


    // MARK: - Simulation

    func fireSimulation() {

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
            fireSimulation()
            return
        }

        let char = demoChars.removeFirst()
        let currentText = demoLabel.stringValue

        demoLabel.stringValue = currentText + char
    }
}
