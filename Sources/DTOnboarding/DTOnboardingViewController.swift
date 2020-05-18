//
//  DTOnboardingViewController.swift
//  OnboardingExample
//
//  Created by Demian Turner on 04/05/2020.
//  Copyright © 2020 Demian Turner. All rights reserved.
//

import AppKit

open class DTOnboardingViewController: NSViewController {
    private let controllerId: String
    
    public init(controllerId: String) {
        self.controllerId = controllerId
        super.init(nibName: nil, bundle: nil)
        
        self.identifier = NSUserInterfaceItemIdentifier(rawValue: controllerId)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
       view = contentView
    }
    
    private lazy var contentView: NSView = {
        let v = NSView(frame: .zero)
        
        let image = NSImage(named: controllerId)!
        let iv = NSImageView(frame: NSRect(origin: .zero, size: image.size))
        iv.image = image
        v.addSubview(iv)
        setupAutoLayoutConstraining(child: iv, to: v)
        return v
    }()
    
    private func setupAutoLayoutConstraining(child: NSView, to parent: NSView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        child.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
        child.rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
        child.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        child.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
    }
}

