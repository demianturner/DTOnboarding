//
//  DTOnboardingConfig.swift
//  OnboardingExample
//
//  Created by Demian Turner on 04/05/2020.
//  Copyright © 2020 Demian Turner. All rights reserved.
//

import AppKit

public protocol DTOnboardingConfig {
    var windowWidth: Int { get }
    var windowHeight: Int { get }
    var windowTitle: String { get }
    var pageCount: Int { get }
    var pageControlWidth: Int { get }
    var pageControlHeight: Int { get }
    var pageControlVerticalDistanceFromBottom: Int { get }
    var pageTransitionStyle: NSPageController.TransitionStyle { get }
}

public struct OnboardingConfig: DTOnboardingConfig {
    public let windowWidth: Int
    public let windowHeight: Int
    public let windowTitle: String
    public let pageCount: Int
    public let pageControlWidth: Int
    public let pageControlHeight: Int
    public let pageControlVerticalDistanceFromBottom: Int
    public let pageTransitionStyle: NSPageController.TransitionStyle
    
    public init(windowWidth: Int, windowHeight: Int, windowTitle: String, pageCount: Int, pageControlWidth: Int, pageControlHeight: Int, pageControlVerticalDistanceFromBottom: Int, pageTransitionStyle: NSPageController.TransitionStyle) {
        self.windowWidth = windowWidth
        self.windowHeight = windowHeight
        self.windowTitle = windowTitle
        self.pageCount = pageCount
        self.pageControlWidth = pageControlWidth
        self.pageControlHeight = pageControlHeight
        self.pageControlVerticalDistanceFromBottom = pageControlVerticalDistanceFromBottom
        self.pageTransitionStyle = pageTransitionStyle
    }
}

