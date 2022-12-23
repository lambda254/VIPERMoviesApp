//
//  ReviewTableNode.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 23/12/22.
//

import Foundation
import TextureSwiftSupport

class ReviewTableNode: ASTableNode {
        
    var data = [MovieReview]()
    
    init() {
        super.init(style: .plain)
        delegate = self
        dataSource = self
        view.separatorStyle = .none
        allowsSelection = false
        style.width = ASDimensionMake(.fraction, 1)
        style.height = ASDimensionMake(500)
    }
    
}

extension ReviewTableNode: ASTableDelegate, ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 10 
        
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cell = ReviewCellNode(username: "aaa", review: "afafafaf")
        
        let cellNodeBlock = { () -> ASCellNode in
            return cell
        }
        
        return cellNodeBlock
    }
    
    func tableView(_ tableView: ASTableView, willDisplay node: ASCellNode, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
//            reviewDelegate?.fetchNewData()
        }
    }
}
