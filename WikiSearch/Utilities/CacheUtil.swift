//
//  CacheUtil.swift
//  WikiSearch
//
//  Created by Sunil on 19/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import Foundation
import Cache

class CacheUtil {
    
    static let shared = CacheUtil()
    var historyStorage: Storage?
    var pageContentStorage: Storage?
    let historyKey = "history"
    
    private init() {
        setupSearchCache()
    }
    
    func setupSearchCache() {
        let diskConfig = DiskConfig(name: historyKey,
                                    expiry: .date(Date().addingTimeInterval(24*3600)),
                                    maxSize: 100000,
                                    directory: nil,
                                    protectionType: .none)
        do {
            historyStorage = try Storage(diskConfig: diskConfig)
        } catch {
            print(error)
        }
    }
    
    func saveSearchData(_ data: Data) {
        if let storage = historyStorage {
            storage.async.setObject(data, forKey: historyKey) { (result) in
            }
        }
    }
    
    func getSearchHistory(onCompletion: @escaping ( _ data: Data?, _ error: ErrorData?) -> Void ) {
        
        if let storage = historyStorage {
            storage.async.object(ofType: Data.self, forKey: historyKey) { (result) in
                switch result {
                case .value(let historyData):
                    onCompletion(historyData,nil)
                case .error(let error):
                    print(error)
                    onCompletion(nil, ErrorData(message: error.localizedDescription))
                }
            }
        }
    }
    
}
