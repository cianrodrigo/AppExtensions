//
//  UIViewController+Extensions.swift
//  
//
//  Created by Rodrigo Cian Berrios on 19/11/2020.
//

import UIKit


// MARK: - Storyboard

public extension UIViewController {
    
    static func viewController(name: String, storyboardName: String = "Main") -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        
        return viewController as! Self
    }
    
    static func fromStoryboard(name storyboardName: String = "Main") -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        
        return self.viewController(name: className, storyboardName: storyboardName)
    }
}


// MARK: - Load from NIB

public extension UIViewController {
    
    static func fromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}


// MARK: - Embed & Descale View Controllers

public extension UIViewController {
        
    func embedViewController(_ targetViewController: UIViewController?) {
        if let viewController = targetViewController, viewController.parent != self {
            viewController.view.frame = self.view.bounds
            self.view.addSubview(viewController.view)
            viewController.didMove(toParent: self)
            viewController.view.layoutSubviews()
            viewController.viewWillAppear(false)
            viewController.viewDidAppear(false)
            
            self.addChild(viewController)
        }
    }
    
    func descaleViewController(_ targetViewController: UIViewController?) {
        if let viewController = targetViewController, viewController.parent != nil {
            viewController.view.layer.removeAllAnimations()
            viewController.willMove(toParent: nil)
            viewController.viewWillDisappear(false)
            viewController.view.removeFromSuperview()
            viewController.didMove(toParent: nil)
            viewController.viewDidDisappear(false)
            
            viewController.removeFromParent()
        }
    }
}


// MARK: - Navigation Bar

public extension UIViewController {
    
    func setNavBarBackgroundColor(color: UIColor, transitionTime: TimeInterval? = nil) {
        if transitionTime == nil {
            self.navigationController?.navigationBar.barTintColor = color
        } else {
            UIView.animate(withDuration: transitionTime!, animations: {
                self.navigationController?.navigationBar.barTintColor = color
            })
        }
    }
    
    func setNavBarTitle(_ title: String, color: UIColor = UIColor.black, font: UIFont = UIFont.systemFont(ofSize: 15)) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        titleLabel.font = font
        titleLabel.textColor = color
        titleLabel.text = title.localized
        titleLabel.sizeToFit()
        titleLabel.numberOfLines = 2
        titleLabel.minimumScaleFactor = 0.6
        
        self.navigationItem.titleView = titleLabel
    }

    func showNavBar(animated: Bool = true) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func hideNavBar(animated: Bool = true) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}


// MARK: - Tab Bar

public extension UIViewController {
    
    func hideTabBar() {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.layer.zPosition = -1
        self.tabBarController?.tabBar.frame.size.height = 0
    }
    
    func showTabBar() {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.layer.zPosition = 0
        self.tabBarController?.tabBar.frame.size.height = 50
    }
    
    func becomeTabBarDelegate() {
        if self is UITabBarControllerDelegate {
            self.tabBarController?.delegate = self as? UITabBarControllerDelegate
        }
    }
    
    func resignTabBarDelegate() {
        self.tabBarController?.delegate = nil
    }
}
