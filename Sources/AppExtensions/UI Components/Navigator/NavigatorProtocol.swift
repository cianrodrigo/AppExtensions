//
//  NavigatorProtocol.swift
//  
//
//  Created by Rodrigo Cian Berrios on 19/11/2020.
//

import UIKit


// MARK: - Navigable ViewControllers

public protocol Navigable where Self: UIViewController {
    
    var navigator: Navigator? { get set }
}


public extension Navigable {
    
    static func instantiateFromStoryboard(name storyboardName: String) -> Self {
        return Self.fromStoryboard(name: storyboardName)
    }
    
    static func instantiateFromNib() -> Self {
        return Self.fromNib()
    }
    
    func startNavigatorFromHere() {
        self.navigator?.startNavigator(from: self)
    }
}


// MARK: - Navigator

protocol NavigatorProtocol {
    
    var navigationController: UINavigationController { get set }

    func start(with viewController: UIViewController)
}


open class Navigator: NavigatorProtocol {
    
    internal var superNavigator: Navigator? = nil
    internal var childNavigators: [Navigator] = []
    internal var navigationController: UINavigationController
    

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: Main Methods
    
    // MARK: Start
    
    open func start(with viewController: UIViewController) {
        if let navigableViewController = viewController as? Navigable {
            self.setNavigator(navigator: self, for: navigableViewController)
        }
    }
    
    internal func startNavigator(from navigable: Navigable) {
        if let navigationController = navigable.navigationController {
            let newNavigator = Navigator(navigationController: navigationController)
            newNavigator.superNavigator = self.superNavigator ?? self
            self.childNavigators.append(newNavigator)
            self.setNavigator(navigator: newNavigator, for: navigable)
        }
    }
    
    
    // MARK: Push
    
    open func push(viewController: Navigable) {
        self.setNavigator(navigator: self, for: viewController)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    
    // MARK: Go Back
    
    open func goBackToRoot(animated: Bool = true) {
        (self.superNavigator ?? self).navigationController.popToRootViewController(animated: animated)
    }
    
    open func canGoBack(to navigable: Navigable) -> Bool {
        return self.navigationController.viewControllers.contains(navigable) || (self.superNavigator ?? self).navigationController.viewControllers.contains(navigable)
    }
    
    open func goBack(to navigable: Navigable, animated: Bool = true) {
        if self.navigationController.viewControllers.contains(navigable) {
            self.navigationController.popToViewController(navigable, animated: animated)
        } else if let superNavigator = self.superNavigator,  superNavigator.navigationController.viewControllers.contains(navigable) {
            superNavigator.navigationController.popToViewController(navigable, animated: animated)
        }
    }
    
    
    // MARK: - Set Navigator for navigation structures
    
    fileprivate func setNavigator(navigator: Navigator, for viewController: Navigable) {
        viewController.navigator = navigator
        
        // Set Navigator for TabBar
        if let tabBarViewController = viewController as? UITabBarController {
            self.setTabBarNavigator(navigator: navigator, controller: tabBarViewController)
        }
        
        // Set Navigator for NavigationController
        if let navigationViewController = viewController as? UINavigationController {
            self.setNavigationControllerNavigator(navigator: navigator, controller: navigationViewController)
        }
    }
    
    // Set Navigator for TabBar
    fileprivate func setTabBarNavigator(navigator: Navigator, controller: UITabBarController) {
        if let viewControllers = controller.viewControllers {
            for viewController in viewControllers {
                
                if let navigableViewController = viewController as? Navigable {
                    navigableViewController.navigator = navigator
                } else if let navigationViewController = viewController as? UINavigationController {
                    self.setNavigationControllerNavigator(navigator: navigator, controller: navigationViewController)
                }
            }
        }
    }
    
    // Set Navigator for NavigationController
    fileprivate func setNavigationControllerNavigator(navigator: Navigator, controller: UINavigationController) {
        if let viewController = controller.topViewController {
            if let navigableViewController = viewController as? Navigable {
                navigableViewController.navigator = navigator
            }
        }
    }
}

