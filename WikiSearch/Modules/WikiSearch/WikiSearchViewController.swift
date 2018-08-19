//
//  WikiSearchViewController.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import UIKit

class WikiSearchViewController: UIViewController {

    @IBOutlet weak var wikiSearchBar: UISearchBar!
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var emptyDataMsgLabel: UILabel!
    @IBOutlet weak var searchBottomView: UIView!
    
    var presenter: WSPresenterInterface!
    var searchAdapter: SearchAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchAdapter = SearchAdapter(presenter: presenter)
        configureViews()
        presenter.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    func configureViews() {
        customiseNavigationController()
        self.searchResultTableView.register(ofType: WikiSearchTableViewCell.self)
        
        self.searchResultTableView.dataSource = searchAdapter
        self.searchResultTableView.delegate = searchAdapter
        self.searchResultTableView.tableFooterView = UIView()
        
        self.wikiSearchBar.delegate = self
        
    }
    
    func customiseNavigationController() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.barTintColor = AppColors.navBackground
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: AppColors.navText]
    }

}

extension WikiSearchViewController: WSViewInterface {
    
    func reloadTableViewData() {
        searchResultTableView.reloadData()
    }
    
    func updateViewTitle(string: String) {
        self.navigationItem.title = string
    }
    
    func updateNavWith(title: String, backgroundColor: UIColor) {
        self.navigationItem.title = title
        navigationController?.navigationBar.barTintColor = backgroundColor
    }
    
    func setEmptyDataMsgVisible(_ visible: Bool) {
        emptyDataMsgLabel.isHidden = !visible
    }
    
    func setLoadingVisible(_ visible: Bool) {
        if visible {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
    
}

extension WikiSearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchWiki(for: searchBar.text ?? "")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        navigationController?.setNavigationBarHidden(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchWiki(for: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
    
}
