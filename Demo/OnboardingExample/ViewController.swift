//
//  ViewController.swift
//  OnboardingExample
//
//  Created by Demian Turner on 01/05/2020.
//  Copyright © 2021 Demian Turner. All rights reserved.
//

import AppKit
import DTOnboarding

class ViewController: NSViewController {
    private var mainWindowController: NSWindowController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = OnboardingConfig(
            windowWidth: 350,
            windowHeight: 430,
            windowTitle: "my sample title",
            pageCount: 4,
            pageControlWidth: 200,
            pageControlHeight: 20,
            pageControlVerticalDistanceFromBottom: 20,
            pageTransitionStyle: .horizontalStrip
        )
        
        let pages = [
            DTPageController(controllerId: "1"),
            DTPageController(controllerId: "2"),
            DTPageController(controllerId: "3"),
            LastStepController(controllerId: "4")
        ]

        let onboardingController = DTOnboardingController(config: config, pages: pages)
        // Force view loading to ensure proper bounds
        _ = onboardingController.view
        let frame = NSRect(origin: .zero, size: NSSize(width: config.windowWidth, height: config.windowHeight))
        let myWindow = NSWindow(
            contentRect: frame,
            styleMask: [.closable, .miniaturizable, .resizable, .titled],
            backing: .buffered,
            defer: false
        )
        myWindow.title = config.windowTitle
        myWindow.center()
        
        mainWindowController = NSWindowController(window: myWindow)
        mainWindowController?.contentViewController = onboardingController
    }

    @IBAction func launch(_ sender: Any) {
        mainWindowController?.showWindow(self)
    }
}

