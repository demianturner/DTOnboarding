//
//  NSViewController+Helpers.swift
//  SampleProject
//
//  Created by Demian Turner on 16/06/2020.
//  Copyright © 2021 Demian Turner. All rights reserved.
//

import AppKit

extension NSViewController {
    public func setupAutoLayoutConstraining(child: NSView, to parent: NSView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            child.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            child.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            child.topAnchor.constraint(equalTo: parent.topAnchor),
            child.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
        ])
    }
    
    public func makeButton() -> NSButton {
        let button = NSButton(frame: .zero)
        button.bezelStyle = .rounded
        button.focusRingType = .none
        return button
    }
}
