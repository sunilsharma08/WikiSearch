//
//  SearchAdapter.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class SearchAdapter: NSObject {
    
    fileprivate var presenter: WSPresenterInterface
    
    init(presenter: WSPresenterInterface) {
        self.presenter = presenter
    }
    
}

extension SearchAdapter: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WikiSearchTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let searchData = presenter.data(forIndexPath: indexPath)
        cell.updateViewWith(data: searchData)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return presenter.shouldShowSectionHeader() ? 38 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if presenter.shouldShowSectionHeader() {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 38))
            view.backgroundColor = UIColor(hexCode: "f1f1f2")
            let label = UILabel(frame: CGRect(x: 16, y: 8, width: view.frame.width - 32, height: 20))
            label.text = "HISTORY_TITLE".localized
            label.textColor = UIColor.darkGray
            label.textAlignment = .left
            view.addSubview(label)
            return view
        }
        return nil
    }
    
}
