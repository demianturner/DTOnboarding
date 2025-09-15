//
//  MyPageController.swift
//  OnboardingExample
//
//  Created by Demian Turner on 01/05/2020.
//  Copyright © 2021 Demian Turner. All rights reserved.
//

import AppKit
import DTPageControl

// for the view debugger
class DTOnboardingView: NSView {}
class DTPageView: NSView {}
class NSPageView: NSView {}

public class DTOnboardingController: NSViewController {
    private var pageControl: DTPageControl!
    private var pageController: NSPageController!
    private let config: DTOnboardingConfig
    private let pages: [DTPageController]
    
    //
    // MARK: - Lifecyle -
    //
    
    public init(config: DTOnboardingConfig, pages: [DTPageController]) {
        self.config = config
        self.pages = pages
        super.init(nibName: nil, bundle: nil)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// `NSPageController` must be a child VC for paging to work correctly
    private func setUp() {
        let pageController = NSPageController()
        pageController.delegate = self

        addChild(pageController)
        self.pageController = pageController
    }

    
    private lazy var contentView: NSView = {
        let rect = NSRect(
            origin: .zero,
            size: NSSize(width: config.windowWidth, height: config.windowHeight)
        )
        let v = DTOnboardingView(frame: rect)
                
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
        
        let pageView = NSPageView(frame: .zero)
        view.addSubview(pageView)
        setupAutoLayoutConstraining(child: pageView, to: view)
        
        pageController.view = pageView
        
        // page identifiers
        pageController.arrangedObjects = pages.indices
            .map { $0 }
            .map { $0 + 1 }
            .map { String($0) }
        pageController.transitionStyle = config.pageTransitionStyle
        
        setupPageControl()
    }
    
    public override func viewDidLayout() {
        super.viewDidLayout()
        
        setupAutoLayout()
    }
    
    //
    // MARK: - DTPageControl -
    //
    
    private func setupPageControl() {
        pageControl = DTPageControl()
        pageControl.numberOfPages = config.pageCount

        view.addSubview(pageControl)
    }
    
    private func setupAutoLayout() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        let width = CGFloat(config.pageControlWidth)
        let height = CGFloat(config.pageControlHeight)
        let verticalDistanceFromBottom =  CGFloat(config.windowHeight - config.pageControlVerticalDistanceFromBottom)/2.0
        let widthAdjustment = CGFloat(config.windowWidth) / 2.0 - width / 2.0
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalToConstant: width),
            pageControl.heightAnchor.constraint(equalToConstant: height),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -widthAdjustment),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: verticalDistanceFromBottom)
        ])
    }
}

//
// MARK: - NSPageControllerDelegate -
//

extension DTOnboardingController: NSPageControllerDelegate {
    // move pages above page control
    public func pageController(_ pageController: NSPageController, frameFor object: Any?) -> NSRect {
        NSMakeRect(0, 10, CGFloat(config.windowWidth), CGFloat(config.windowHeight))
    }
    
    public func pageController(_ pageController: NSPageController, viewControllerForIdentifier identifier: String) -> NSViewController {
        
        guard let id = Int(identifier), pages.indices.contains(id - 1) else {
            fatalError("Unexpected view controller identifier, \(identifier)")
        }
        return pages[id - 1]
    }
    
    public func pageController(_ pageController: NSPageController, identifierFor object: Any) -> String {
        String(describing: object)
    }
    
    public func pageControllerDidEndLiveTransition(_ pageController: NSPageController) {
        pageControl.currentPage = pageController.selectedIndex
        pageController.completeTransition()
    }
}

