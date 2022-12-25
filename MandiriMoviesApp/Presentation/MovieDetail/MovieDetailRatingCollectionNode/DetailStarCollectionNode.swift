//
//  ReviewStarCollectionNode.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 25/12/22.
//

import Foundation
import TextureSwiftSupport

class DetailStarCollectionNode: ASCollectionNode {
        
    var data = 2.0

            
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: flowLayout, layoutFacilitator: nil)
        automaticallyManagesSubnodes = true
        delegate = self
        dataSource = self
        style.width = ASDimensionMake(140)
        style.height = ASDimensionMake(20)
        showsHorizontalScrollIndicator = false
    }
}

extension DetailStarCollectionNode: ASCollectionDelegate, ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let acceptableStar = 5 - (10 / Int(data))
        let cellNodeBlock = {[self] () -> ASCellNode in
            let cellNode = DetailStarCellNode()
            if indexPath.row >= acceptableStar {
                cellNode.unfilledStar()
            }
            return cellNode
        }
        return cellNodeBlock
    }
    
}
