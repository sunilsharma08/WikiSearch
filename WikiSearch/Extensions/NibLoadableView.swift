//
//  NibLoadableView.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
