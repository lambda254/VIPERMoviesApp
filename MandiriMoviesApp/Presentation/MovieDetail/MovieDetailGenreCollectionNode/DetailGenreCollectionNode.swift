//
//  DetailGenreCollectionNode.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 25/12/22.
//

import Foundation
import TextureSwiftSupport 

class DetailGenreCollectionNode: ASCollectionNode {
        
    var data = [String]()
            
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
        style.width = ASDimensionMake(.fraction, 1)
        style.height = ASDimensionMake(50)
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
    }
}

extension DetailGenreCollectionNode: ASCollectionDelegate, ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = {[self] () -> ASCellNode in
            let cellNode = DetailGenreCellNode(genre: data[indexPath.row])
            return cellNode
        }
        return cellNodeBlock
    }
}
