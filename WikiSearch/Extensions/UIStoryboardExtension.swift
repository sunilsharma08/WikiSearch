//
//  UIStoryboardExtension.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func instantiateViewController<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        if let viewController = instantiateViewController(withIdentifier: identifier) as? T {
            return viewController
        } else {
            fatalError("Failed to load ViewController with identifier \(identifier) from storyboard")
        }
    }
    
}
