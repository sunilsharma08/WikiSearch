//
//  UIViewControllerExtension.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentWireframe(_ wireframe:BaseWireframe, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
    
}
