//
//  AccessoryViewController.swift
//  Terminal Typer
//
//  Created by Daniel Bonates on 16/03/2018.
//  Copyright © 2018 Daniel Bonates. All rights reserved.
//

import Cocoa

class AccessoryViewController: NSTitlebarAccessoryViewController {

    @IBOutlet weak var settingsButton: NSButton!
    weak var delegate: ViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        settingsButton.image = #imageLiteral(resourceName: "gear").tint(with: delegate?.theme == .dark ? .lightText : .darkBackground)
    }

    @objc func showPrefs() {
        delegate?.showSettings()
    }

    @IBAction func acessoryAction(_ sender: NSButton) {
        delegate?.showSettings()
    }


}
