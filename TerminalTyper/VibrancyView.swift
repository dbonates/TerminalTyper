//
//  VibrancyView.swift
//  Terminal Typer
//
//  Created by Daniel Bonates on 20/03/2018.
//  Copyright © 2018 Daniel Bonates. All rights reserved.
//

import Cocoa

class VibrancyView: NSVisualEffectView {
    func configure() {

        // Use blendingMode to specify what exactly is blurred

                blendingMode = .behindWindow // [DEFAULT] ignores in-window content and only blurs content behind the window
//        blendingMode = .withinWindow // ignores content behind the window and only blurs in-window content behind this view


        // Use material to specify how the blur draws (light/dark/etc.)

                material = .light           // The Vibrant Light look we see in countless Apple apps' sidebars, Sierra notification center, etc.
//                material = .dark            // The Vibrant Dark look we all know and love from HUDs, Launchpad, Yosemite & El Capitan notification center, etc.

//                material = .appearanceBased // [DEFAULT] Automatically uses .light or .dark, depending on the view's appearance field

        //        material = .titlebar        // The material the system uses in titlebars. Designed to be used with blendingMode = .withinWindow
        //        material = .selection       // A special material for selection. The material will vary depending on the effectiveAppearance, active state, and emphasized state.

        if #available(OSX 10.11, *) {

            // Materials introduced in 10.11 (El Capitan)

            //            material = .mediumLight // Not quite as light as .light
            //            material = .ultraDark   // Much darker than .dark

            //            material = .menu        // The material the system uses for menus
//            material = .popover     // The material the system uses for popovers
//                        material = .sidebar     // The material the system uses for sidebars
        }


        // Use state to specify when the visual effect appears

        state = .active                   // Always show the visual effect
        //        state = .inactive                 // Never show the visual effect (behaves like a normal view)
        state = .followsWindowActiveState // [DEFAULT] Active when window is active, not when window is not
    }
}
