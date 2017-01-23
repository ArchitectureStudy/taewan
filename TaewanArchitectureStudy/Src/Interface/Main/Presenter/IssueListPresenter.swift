//
//  IssueListPresenter.swift
//  TaewanArchitectureStudy
//
//  Created by taewan on 2017. 1. 21..
//  Copyright © 2017년 taewankim. All rights reserved.
//

import Foundation


protocol IssueListPresenterDelegate {
    func issueListDidLoaded()
}


class IssueListPresenter: NSObject {
    var delegate: IssueListPresenterDelegate?
    let model: Model.IssuesModel
    
    
    
    init?(config: Model.RepositoryConfig?) {
        guard let repository = config else { return nil }
        self.model = Model.IssuesModel(config: repository)
        super.init()
    }
    

    func refresh() {
        model.refresh().response { [weak self] _ in
            self?.delegate?.issueListDidLoaded()
        }
    }
    
    func loadMore() {
        model.loadMore().response { [weak self] _ in
            self?.delegate?.issueListDidLoaded()
        }
    }
    
}