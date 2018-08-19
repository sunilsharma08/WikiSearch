//
//  WikiSearchPresenter.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import Foundation

class WikiSearchPresenter {
    
    fileprivate weak var viewController: WSViewInterface?
    fileprivate var interactor: WSInteractorInterface
    fileprivate var wireframe: WSWireframeInterface
    // Keep track of the pending search item as a property
    private var pendingSearchRequest: DispatchWorkItem?
    
    fileprivate var isOffline = true
    fileprivate let reachability:Reachability? = Reachability()
    
    fileprivate var searchResultArray: [SearchData] = [] {
        didSet {
            viewController?.reloadTableViewData()
            viewController?.setEmptyDataMsgVisible(searchResultArray.count == 0)
        }
    }
    
    init(wireframe: WSWireframeInterface, view: WSViewInterface, interactor: WSInteractorInterface) {
        self.viewController = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func getSearchResultFromServer(for query: String) {
        self.viewController?.setLoadingVisible(true)
        self.interactor.searchWiki(for: query) {[weak self] (status, result, error) in
            self?.viewController?.setLoadingVisible(false)
            if status == .success && result != nil {
                self?.searchResultArray = result!
            } else {
                self?.wireframe.showAlert(with: error?.title, message: error?.description)
            }
        }
    }
    
    func getHistoryFromCache() {
        self.viewController?.setLoadingVisible(true)
        interactor.getSearchHistoryFromCache {[weak self] (status, result, error) in
            self?.viewController?.setLoadingVisible(false)
            if status == .success && result != nil {
                self?.searchResultArray = result!
            } else {
                self?.searchResultArray.removeAll()
            }
        }
    }
    
    func updateNavBasedOnNetworkStatus(_ isConnected: Bool) {
        if isConnected {
            viewController?.updateNavWith(title: NSLocalizedString("SEARCH_VIEW_TITLE", comment: ""), backgroundColor: AppColors.navBackground)
        } else {
            viewController?.updateNavWith(title: NSLocalizedString("OFFLINE", comment: ""), backgroundColor: AppColors.navOfflineBackground)
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as? Reachability
        
        if let connection = reachability?.connection {
            if connection == .wifi || connection == .cellular {
                isOffline = false
                updateNavBasedOnNetworkStatus(true)
                searchResultArray.removeAll()
            } else {
                isOffline = true
                updateNavBasedOnNetworkStatus(false)
                getHistoryFromCache()
            }
        }
    }
    
}

extension WikiSearchPresenter: WSPresenterInterface {
    
    func didSelectItem(at indexPath: IndexPath) {
        if isOffline {
            wireframe.showAlert(with: "OFFLINE".localized, message: "OFFLINE_MSG".localized)
        } else {
            wireframe.showWikiPageFor(searchData: searchResultArray[indexPath.row])
        }
    }
    
    func viewDidLoad() {
        viewController?.setEmptyDataMsgVisible(true)
        isOffline = !Reachability.isConnectedToNetwork()
        updateNavBasedOnNetworkStatus(!isOffline)
    }
    
    func viewWillAppear() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        updateNavBasedOnNetworkStatus(!isOffline)
    }
    
    func viewWillDisappear() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    func searchWiki(for query: String) {
        // Cancel the currently pending item
        pendingSearchRequest?.cancel()
        
        let searchRequestWorkItem = DispatchWorkItem { [weak self] in
            self?.getSearchResultFromServer(for: query)
        }
        // Save the new work item and execute it after 250 ms
        pendingSearchRequest = searchRequestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250),
                                      execute: searchRequestWorkItem)
    }
    
    func numberOfSectionsInTableView() -> Int {
        return 1
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return searchResultArray.count
    }
    
    func data(forIndexPath indexPath: IndexPath) -> SearchData {
        return searchResultArray[indexPath.row]
    }
    
    func shouldShowSectionHeader() -> Bool {
        return isOffline && searchResultArray.count > 0
    }
}
