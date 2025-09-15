//
//  LastStepController.swift
//  CryptoCalculator
//
//  Created by Demian Turner on 14/05/2020.
//  Copyright © 2020 Demian Turner. All rights reserved.
//

import Cocoa
import DTOnboarding

class LastStepController: DTPageController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = makeButton(title: "Close Onboarding")
        view.addSubview(button)
        
        // layout
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonSize = button.fittingSize
        let viewSize = NSSize(width: 350, height: 430)
        let widthPadding = (viewSize.width - buttonSize.width) / 2
        let heightPaddingBottom = CGFloat(65.0)
        let heightPaddingTop = viewSize.height - buttonSize.height - heightPaddingBottom
        
        let metrics = [
            "heightPaddingTop": heightPaddingTop,
            "heightPaddingBottom": heightPaddingBottom,
            "widthPadding": widthPadding,
            "buttonWidth": buttonSize.width,
        ]
                        
        let views: [String: Any] = [
            "button": button,
        ]
        var allConstraints: [NSLayoutConstraint] = []
        
        let verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-heightPaddingTop-[button]-heightPaddingBottom-|",
            metrics: metrics,
            views: views)
        allConstraints += verticalConstraints
        
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-widthPadding-[button(buttonWidth)]-widthPadding-|",
            metrics: metrics,
            views: views)
        allConstraints += horizontalConstraints
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    @objc private func closeOnboarding() {
        view.window?.close()
        print("button clicked")
    }
}

extension LastStepController {
    func makeButton(title: String) -> NSButton {
        let button = NSButton(frame: .zero)
        button.title = title
        button.bezelStyle = .rounded
        button.isBordered = true
        button.isTransparent = false
        button.setButtonType(.momentaryChange)
        button.keyEquivalent = "\r";
        button.target = self
        button.action = #selector(closeOnboarding)
        return button
    }
}
