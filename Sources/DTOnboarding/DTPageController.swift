//
//  DTOnboardingViewController.swift
//  OnboardingExample
//
//  Created by Demian Turner on 04/05/2020.
//  Copyright © 2021 Demian Turner. All rights reserved.
//

import AppKit

open class DTPageController: NSViewController {
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
        let v = DTPageView(frame: .zero)
        
        let image = NSImage(named: controllerId)!
        let iv = NSImageView(frame: .zero)
        iv.image = image
        v.addSubview(iv)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        iv.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        return v
    }()
}

