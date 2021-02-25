//
//  MyPageController.swift
//  OnboardingExample
//
//  Created by Demian Turner on 01/05/2020.
//  Copyright © 2021 Demian Turner. All rights reserved.
//

import AppKit
import DTPageControl

class DTOnboardingViewControllerView: NSView {}
class DTPageControllerSubView: NSView {}
class DTPageControllerView: NSView {}
class NSPageControllerView: NSView {}

public class DTPageController: NSViewController {
    private var pageControl: DTPageControl!
    private var pageController: NSPageController!
    private let config: DTOnboardingConfig
    private let pages: [DTOnboardingViewController]
    
    //
    // MARK: - Lifecyle -
    //
    
    public init(config: DTOnboardingConfig, pages: [DTOnboardingViewController]) {
        self.config = config
        self.pages = pages
        super.init(nibName: nil, bundle: nil)
        setUp()
    }
    
    private func setUp() {
        let pageController = NSPageController()
        pageController.delegate = self

        addChild(pageController)
        self.pageController = pageController
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var contentView: NSView = {
        let rect = NSRect(
            origin: .zero,
            size: NSSize(width: self.config.windowWidth, height: self.config.windowHeight)
        )
        let v = DTPageControllerView(frame: rect)
                
        // back button
        let back = makeButton()
        back.target = pageController
        back.action = #selector(pageController.navigateBack(_:))
        back.image = NSImage(named: NSImage.Name("NSGoLeftTemplate"))
        v.addSubview(back)
        
        // layout
        back.translatesAutoresizingMaskIntoConstraints = false
        back.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        back.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 10).isActive = true
        
        // forward button
        let forward = makeButton()
        forward.target = pageController
        forward.action = #selector(pageController.navigateForward(_:))
        forward.image = NSImage(named: NSImage.Name("NSGoRightTemplate"))
        v.addSubview(forward)
        
        // layout
        forward.translatesAutoresizingMaskIntoConstraints = false
        forward.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        forward.rightAnchor.constraint(equalTo: v.rightAnchor, constant: -10).isActive = true

        return v
    }()

    public override func loadView() {
       view = contentView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let subview = NSPageControllerView(frame: .zero)
        view.addSubview(subview)
        setupAutoLayoutConstraining(child: subview, to: view)
        
        pageController.view = subview
        
        // page identifiers
        pageController.arrangedObjects = pages.indices
            .map { $0 }
            .map { $0 + 1 }
            .map { String($0) }
        pageController.transitionStyle = config.pageTransitionStyle
        
        setupPageControl()
    }
    
    //
    // MARK: - DTPageControl -
    //
    
    private func setupPageControl() {
        pageControl = DTPageControl()
        pageControl.numberOfPages = config.pageCount

        view.addSubview(pageControl)
        
        // layout
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.widthAnchor.constraint(equalToConstant: CGFloat(config.pageControlWidth)).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: CGFloat(config.pageControlHeight)).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -CGFloat(config.pageControlVerticalDistanceFromBottom)).isActive = true
    }
}

//
// MARK: - NSPageControllerDelegate -
//

extension DTPageController: NSPageControllerDelegate {
    // move pages above page control
    public func pageController(_ pageController: NSPageController, frameFor object: Any?) -> NSRect {
        return NSMakeRect(0, 10, CGFloat(config.windowWidth), CGFloat(config.windowHeight))
    }
    
    public func pageController(_ pageController: NSPageController, viewControllerForIdentifier identifier: String) -> NSViewController {
        
        guard let id = Int(identifier), pages.indices.contains(id - 1) else {
            fatalError("Unexpected view controller identifier, \(identifier)")
        }
        return pages[id - 1]
    }
    
    public func pageController(_ pageController: NSPageController, identifierFor object: Any) -> String {
        return String(describing: object)
    }
    
    public func pageControllerDidEndLiveTransition(_ pageController: NSPageController) {
        pageControl.currentPage = pageController.selectedIndex
        pageController.completeTransition()
    }
}

