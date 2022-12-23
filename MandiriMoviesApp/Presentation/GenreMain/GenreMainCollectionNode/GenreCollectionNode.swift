//
//  GenreCollectionNode.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 23/12/22.
//

import Foundation
import TextureSwiftSupport

protocol GenreCollectionDelegate: AnyObject {
    func didCellTap(id: Int, title: String)
}

class GenreCollectionNode: ASCollectionNode {
    
    weak var collectionDelegate: GenreCollectionDelegate?
    
    var data = [GenreMain]()
    
    var posterCounter = 0
    
    var doneReloading = false
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: flowLayout, layoutFacilitator: nil)
        automaticallyManagesSubnodes = true
        delegate = self
        dataSource = self
        style.width = ASDimensionMake(.fraction, 1)
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
    }
}

extension GenreCollectionNode: ASCollectionDelegate, ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = {[self] () -> ASCellNode in
            let cellNode = GenreCellNode(title: data[indexPath.row].title, id: data[indexPath.row].id)
            return cellNode
        }
        return cellNodeBlock
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionNode.nodeForItem(at: indexPath) as? GenreCellNode
        guard let title = cell?.titleNode.attributedText?.string else { return }
        guard let id = cell?.id else { return }
        collectionDelegate?.didCellTap(id: id, title: title)
    }
}

