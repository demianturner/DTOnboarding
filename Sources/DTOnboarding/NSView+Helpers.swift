//
//  NSView+Helpers.swift
//  
//
//  Created by Demian Turner on 25/02/2021.
//

import AppKit

extension NSView {
    var backgroundColor: NSColor? {
        get {
            if let colorRef = layer?.backgroundColor {
                return NSColor(cgColor: colorRef)
            } else {
                return nil
            }
        }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }
}
