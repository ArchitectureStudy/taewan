//
//  IssueDetailPresenter.swift
//  TaewanArchitectureStudy
//
//  Created by taewan on 2017. 1. 21..
//  Copyright © 2017년 taewankim. All rights reserved.
//

import Foundation


protocol IssueDetailPresenterDelegate: class {
    func issueDidLoaded()
    func createdComment()
}


class IssueDetailPresenter: NSObject {
    weak var delegate: IssueDetailPresenterDelegate?
    let service: IssueService
    
    init?(config: Router.IssueConfig?) {
        guard let issue = config else { return nil }
        self.service = IssueService(config: issue)
        super.init()
    }
    
    func refresh(withComment: Bool = true) {
        service.refresh().response { [weak self] _ in
            self?.delegate?.issueDidLoaded()
            if withComment {
                self?.refreshComments()
            }
        }
    }
    
    func create(comment: String) {
        service.commentService.create(body: comment).response { [weak self] _ in
            self?.delegate?.createdComment()
            self?.refresh(withComment: false)
        }
    }
    
    private func refreshComments() {
        service.commentService.refresh().response { [weak self] _ in
            self?.delegate?.issueDidLoaded()
        }
    }    
    
}
