//
//  ViewController.swift
//  TerminalTyper
//
//  Created by Daniel Bonates on 16/03/2018.
//  Copyright © 2018 Daniel Bonates. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var commandsInput: NSTextView!

    let popover = NSPopover()

    var accessoryController: AccessoryViewController?

    var commandsGapDelay: Double  {
        return 1 + speed
    }

    let scriptSource = """
    tell application \"SCRIPT_TOOL\"
        activate
    end tell
    delay 1
    tell application "System Events"
    SCRIPT_COMMANDS
    end tell
    """

    let screenGrabScript = """
        tell application "System Events"
            set fileName to do shell script "date \\"+Screen Shot  %Y-%m-%d at %H.%M.%S.png\\""
            set thePath to POSIX path of desktop folder
            do shell script "screencapture  -l$(osascript -e 'tell app \\"iTerm\\" to id of window 1') " & "\\"" & thePath & "/" & fileName & "\\""
        end tell
        delay 1
    """
    

    let shouldGrabScreen = true
    
    let defaultSpeed: Double = 0.3
    var speed: Double = 0.3 {
        didSet {
            persistSpeed()
        }
    }

    var theme: Theme = .light {
        didSet {
            persistThemePreferences()
            setUpAccessoryController()
        }
    }


    var terminalTool: TerminalTool = .terminal {
        didSet {
            persistTerminalToolPreferences()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()


        theme = loadThemePreference()
        terminalTool = loadTerminalToolPreference()
        speed = loadSpeedPreference()

        NotificationCenter.default.addObserver(self, selector: #selector(toogleTheme), name: NSNotification.Name("toogleTheme"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(runCommands(_:)), name: NSNotification.Name("runCommands"), object: nil)

    }

    override func viewWillAppear() {
        super.viewWillAppear()

        commandsInput.font = NSFont.init(name: "Droid Sans Mono Dotted for Powerline", size: 12)
        if theme == .dark {
            setDarkTheme()
        } else {
            setLightTheme()
        }
    }

    func showSettings() {

        if popover.isShown {
            popover.close()
            return
        }


        let svc = SettingsViewController(speed: speed, terminalTool: terminalTool)
        svc.delegate = self

        guard let ac = self.accessoryController else { return }

        popover.contentViewController = svc
        popover.show(relativeTo: ac.view.bounds, of: ac.view, preferredEdge: .minY)
        popover.behavior = .semitransient
    }

    func setUpAccessoryController() {

        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)

        if let accessoryController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "TitlebarController")) as? AccessoryViewController {

            accessoryController.delegate = self

            accessoryController.layoutAttribute = .right

            NSApplication.shared.keyWindow?.addTitlebarAccessoryViewController(accessoryController)

            if let window = NSApplication.shared.keyWindow {
                let accs = window.titlebarAccessoryViewControllers
                if accs.count > 1 {
                    NSApplication.shared.keyWindow?.removeTitlebarAccessoryViewController(at: 0)
                }
            }



            self.accessoryController = accessoryController

        }
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let vc = segue.destinationController as? SettingsViewController {
            vc.delegate = self
        }
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        if ProcessInfo.processInfo.arguments.contains("--testing") {
            commandsInput.string = "echo 'Nice Terminal Typer Robot!'"
        }

        setUpAccessoryController()


    }


    func randomDelay() -> Double {

        let max = speed

        var num = drand48()
        if num >= max {
            while num <= max || num <= 0{
                num = drand48()
            }

        }
        return num / 4
    }
    
    func typeWrite(_ commandsSource: String) -> String {
        var result = ""
        
        let commands = commandsSource.split(separator: "\n")

        commands.forEach {
            $0.forEach {

                result += "keystroke \"\($0)\"\n"
                result += "delay \(randomDelay())\n"

            }

            result += "delay \(commandsGapDelay)\n"
            result += "key code 36\n"
            
            // grab sreen?
            if shouldGrabScreen {
                result += (screenGrabScript + "\n")
            }

        }
        return result
    }

    @objc func runCommands(_ sender: Any) {

        let commands = commandsInput.string
        let scriptCommands = typeWrite(commands)

        let finalScript = scriptSource.replacingOccurrences(of: "SCRIPT_COMMANDS", with: "\n" + scriptCommands + "\n").replacingOccurrences(of: "SCRIPT_TOOL", with: terminalTool.rawValue)

        var error: NSDictionary?
        let script = NSAppleScript(source: finalScript)
        script?.executeAndReturnError(&error)
    }

    // MARK: Speed

    func persistSpeed() {
        UserDefaults.standard.set(speed, forKey: "speed")
        UserDefaults.standard.synchronize()
    }

    func loadSpeedPreference() -> Double {
        let savedSpeed = UserDefaults.standard.double(forKey: "speed")
        return savedSpeed > 0 ? savedSpeed : defaultSpeed
    }

    // MARK: - Theme stuff

    @objc func toogleTheme() {
        if theme == .dark {
            setLightTheme()
            theme = .light
        } else {
            setDarkTheme()
            theme = .dark
        }
    }

    func loadThemePreference() -> Theme {
        let usingDark = UserDefaults.standard.bool(forKey: "darkTheme")
        return usingDark ? .dark : .light
    }

    func persistThemePreferences() {
        let usingDarkTheme = theme == .dark
        UserDefaults.standard.set(usingDarkTheme, forKey: "darkTheme")
        UserDefaults.standard.synchronize()
    }


    func loadTerminalToolPreference() -> TerminalTool {
        let savedTerminalTool = UserDefaults.standard.string(forKey: "terminalTool") ?? ""
        return TerminalTool(rawValue: savedTerminalTool) ?? .terminal
    }

    func persistTerminalToolPreferences() {
        UserDefaults.standard.set(terminalTool.rawValue, forKey: "terminalTool")
        UserDefaults.standard.synchronize()
    }

    func setDarkTheme() {
        NSApplication.shared.keyWindow?.appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)
        NSApplication.shared.keyWindow?.backgroundColor = .darkBackground
        commandsInput.backgroundColor = .darkBackground
        commandsInput.textColor = .lightText
    }

    func setLightTheme() {
        NSApplication.shared.keyWindow?.appearance = NSAppearance(named: NSAppearance.Name.vibrantLight)
        NSApplication.shared.keyWindow?.backgroundColor = .lightBackground
        commandsInput.backgroundColor = .lightBackground
        commandsInput.textColor = .darkText
    }

}

