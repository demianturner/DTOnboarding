//
//  NSViewController+Helpers.swift
//  SampleProject
//
//  Created by Demian Turner on 16/06/2020.
//  Copyright © 2021 Demian Turner. All rights reserved.
//

import AppKit

extension NSViewController {    
    public func makeButton() -> NSButton {
        let button = NSButton(frame: .zero)
        button.bezelStyle = .rounded
        button.focusRingType = .none
        return button
    }
}
