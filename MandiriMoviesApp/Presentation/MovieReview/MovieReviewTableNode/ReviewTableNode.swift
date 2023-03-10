//
//  ReviewTableNode.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 23/12/22.
//

import Foundation
import TextureSwiftSupport

protocol ReviewTableDelegate: AnyObject {
    func fetchNewReviews()
}

class ReviewTableNode: ASTableNode {
    
    weak var tableDelegate: ReviewTableDelegate?
        
    var data = [MovieReview]()
    
    init() {
        super.init(style: .plain)
        delegate = self
        dataSource = self
        view.separatorStyle = .none
        allowsSelection = false
        style.width = ASDimensionMake(.fraction, 1)
        style.height = ASDimensionMake(640)
    }
    
}

extension ReviewTableNode: ASTableDelegate, ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cell = ReviewCellNode(username: data[indexPath.row].username, review: data[indexPath.row].review)
        
        let cellNodeBlock = { () -> ASCellNode in
            return cell
        }
        
        return cellNodeBlock
    }
    
    func tableView(_ tableView: ASTableView, willDisplay node: ASCellNode, forRowAt indexPath: IndexPath) {
        let cell = node as? ReviewCellNode
        if cell?.indexPath?.row == data.count - 1 {
            tableDelegate?.fetchNewReviews()
        }
    }
    
}
