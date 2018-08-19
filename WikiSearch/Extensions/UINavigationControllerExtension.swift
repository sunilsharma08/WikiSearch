//
//  UINavigationControllerExtension.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func pushWireFrame(_ wireframe:BaseWireframe, animated:Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }
    
    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
    
}

extension UINavigationBar {
    
    func shouldRemoveShadow(_ value: Bool) -> Void {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
}
