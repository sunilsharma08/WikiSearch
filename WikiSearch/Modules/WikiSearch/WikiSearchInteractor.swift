//
//  WikiSearchInteractor.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import Foundation
import Cache

class WikiSearchInteractor {
    
    func searchWiki(for query:String, onCompletion:@escaping (_ status: RequestStatus, _ result: [SearchData]?, _ error: ErrorData?) -> Void) {
        if Reachability.isConnectedToNetwork() {
            let session = URLSession.shared.dataTask(with: createSearchUrl(for: query)) { (data, response, error) in
                DispatchQueue.main.async {
                    if let responseData = data {
                        do {
                            let responseJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject]
                            if let searchResult = responseJSON?[JSONKeys.query]?[JSONKeys.pages] as? [[String: Any]] {
                                var resultArray: [SearchData] = []
                                if searchResult.count > 0 {
                                    CacheUtil.shared.saveSearchData(responseData)
                                }
                                for data in searchResult {
                                    let searchDataObj = SearchData(json: data)
                                    resultArray.append(searchDataObj)
                                }
                                onCompletion(.success, resultArray, nil)
                            }
                            else {
                                onCompletion(.success, [SearchData](), nil)
                            }
                        } catch {
                            onCompletion(.fail, nil, ErrorData(message: "JSON_PARSE_ERROR_MSG".localized))
                            return
                        }
                    }
                }
            }
            session.resume()
        } else {
            onCompletion(.noInternet, nil, ErrorData(message:"NO_INTERNET_MSG".localized))
        }
        
    }
    
    func getSearchHistoryFromCache(onCompletion: @escaping (_ status: RequestStatus, _ result: [SearchData]?, _ error: ErrorData?) -> Void) {
        CacheUtil.shared.getSearchHistory { (data, error) in
            DispatchQueue.main.async {
            if let cacheData = data {
                do {
                    let responseJSON = try JSONSerialization.jsonObject(with: cacheData, options: []) as? [String: AnyObject]
                    if let searchResult = responseJSON?[JSONKeys.query]?[JSONKeys.pages] as? [[String: Any]] {
                        var resultArray: [SearchData] = []
                        for data in searchResult {
                            let searchDataObj = SearchData(json: data)
                            resultArray.append(searchDataObj)
                        }
                        onCompletion(.success, resultArray, nil)
                    }
                    else {
                        onCompletion(.success, [SearchData](), nil)
                    }
                } catch {
                    onCompletion(.fail, nil, ErrorData(message: "JSON_PARSE_ERROR_MSG".localized))
                    return
                }
            } else {
                print(error?.description ?? "Empty")
                onCompletion(.fail, nil, nil)
            }
            }
        }
    }
    
    private func createSearchUrl(for queryString:String) -> URL {
        
        let urlString:String = "\(RESTApi.searchUrl)\(queryString)"
        
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: encodedString)!
    }
    
}

extension WikiSearchInteractor: WSInteractorInterface {
    
    
}
