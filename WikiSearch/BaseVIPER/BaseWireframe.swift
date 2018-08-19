//
//  BaseWireframe.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import Foundation
import UIKit

protocol WireframeInterface: class {
    //All basic operation that a Wireframes should support
    func popViewController(animated: Bool)
    func dismiss(animated: Bool)
    
    func showAlert(with title: String?, message: String?)
    func showAlert(with title: String?, message: String?, actions: [UIAlertAction])
}

class BaseWireframe {
    
    unowned var viewController:UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension BaseWireframe: WireframeInterface {
    
    func popViewController(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    func dismiss(animated: Bool) {
        navigationController?.dismiss(animated: animated)
    }
    
    func showAlert(with title: String?, message: String?) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        showAlert(with: title, message: message, actions: [okAction])
    }
    
    func showAlert(with title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        navigationController?.present(alert, animated: true, completion: nil)
    }
}

extension BaseWireframe {
    
    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
}

