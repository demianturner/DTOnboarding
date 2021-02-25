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
            pageCount: 3,
            pageControlWidth: 200,
            pageControlHeight: 20,
            pageControlVerticalDistanceFromBottom: 20,
            pageTransitionStyle: .horizontalStrip
        )
        
        let pages = [
            DTPageController(controllerId: "1"),
            DTPageController(controllerId: "2"),
            DTPageController(controllerId: "3")
        ]

        let pageController = DTOnboardingController(config: config, pages: pages)
        let frame = pageController.view.bounds
        let myWindow = NSWindow(
            contentRect: .init(origin: .zero, size: frame.size),
            styleMask: [.closable, .miniaturizable, .resizable, .titled],
            backing: .buffered,
            defer: false
        )
        myWindow.title = config.windowTitle
        myWindow.center()
        
        mainWindowController = NSWindowController(window: myWindow)
        mainWindowController?.contentViewController = pageController
    }

    @IBAction func launch(_ sender: Any) {
        mainWindowController?.showWindow(self)
    }
}

