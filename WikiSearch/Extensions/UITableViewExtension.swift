//
//  UITableViewExtension.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(ofType _: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}

