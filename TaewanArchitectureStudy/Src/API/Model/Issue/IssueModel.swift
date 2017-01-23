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
    public class IssueModel: ModelLoadable {
        public private(set) var config: Router.IssueConfig
        
        public private(set) var data: DataObject.Issue?
        
        lazy var comments: CommentsModel = { [unowned self] in
            return CommentsModel(issueModel: self)
        }()
        
        init(config: Router.IssueConfig) {
            self.config = config
        }
        
        public func refresh() -> DataRequest {
            
            return Router.issue(config: config)
                .responseObject { [unowned self] (response: DataResponse<DataObject.Issue>) in
                    switch response.result {
                    case .success(let value):
                        self.data = value
                    case .failure(let error):
                        debugPrint(error)
                    }
                }
        }
        
    }
    
}
