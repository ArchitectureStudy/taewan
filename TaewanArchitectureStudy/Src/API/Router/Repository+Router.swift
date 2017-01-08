//
// Created by kimtaewan on 2017. 1. 6..
// Copyright (c) 2017 taewankim. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire


/// 뭔가 이렇게 하기는 불편한거 같은데...
public protocol RequestRepository { }

extension Router {
    public enum Repository: RouterRequestConvertible, RequestRepository {
        case issues(user: String, repo: String, page: Int?)
        case issue(user: String, repo: String, number: Int)
    }
}


extension Router.Repository {
    var rawString: String {  return "repos" }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var result: (path: String, parameters: [String: Any]?)  {
        switch self {
        case .issues(let user, let repo, let page):
            var parameters: [String: Any] = [:]
            if let page = page {
                parameters["page"] = page
            }
            return (path: "\(user)/\(repo)/issues", parameters: parameters)
        case .issue(let user, let repo, let number):
            return (path: "\(user)/\(repo)/issues/\(number)", parameters: nil)
        }
    }
}