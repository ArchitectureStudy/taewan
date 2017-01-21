//
//  IssueModel.swift
//  TaewanArchitectureStudy
//
//  Created by kimtaewan on 2017. 1. 16..
//  Copyright © 2017년 taewankim. All rights reserved.
//

import Foundation
import Alamofire

extension Model {
    public class IssuesModel {
        private var user: String
        private var repo: String
        private var page: Int = 1
        
        public private(set) var list: [DataObject.Issue] = []
        
        init(user: String, repo: String) {
            self.user = user
            self.repo = repo
        }
        
        func refresh() -> DataRequest {
            self.page = 1
       
            
            return Router.issues(user: user, repo: repo, page: nil)
                .responseCollection { (response: DataResponse<[DataObject.Issue]>) in
                    switch response.result {
                    case .success(let value):
                        self.list = value
                        self.page += 1
                    case .failure(let error):
                        debugPrint(error)
                    }
            }
        }
        
        func loadMore() -> DataRequest {
            return Router.issues(user: user, repo: repo, page: self.page)
                .responseCollection { (response: DataResponse<[DataObject.Issue]>) in
                    switch response.result {
                    case .success(let value):
                        self.list += value
                        self.page += 1
                    case .failure(let error):
                        debugPrint(error)
                    }
            }
        }//load
        
    }
    
}
