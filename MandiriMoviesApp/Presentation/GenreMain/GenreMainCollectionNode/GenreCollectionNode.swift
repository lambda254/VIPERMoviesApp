//
//  GenreCollectionNode.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 23/12/22.
//

import Foundation
import TextureSwiftSupport

protocol GenreCollectionDelegate: AnyObject {
    func didCellTap(id: Int, title: String, poster: UIImage)
}

class GenreCollectionNode: ASCollectionNode {
    
    weak var collectionDelegate: MainCollectionDelegate?
    
    var data = [MovieMain]()
    
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
        return 10
    }
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = {[self] () -> ASCellNode in
            let cellNode = GenreCellNode(title: "asfafafaf")
            return cellNode
        }
        return cellNodeBlock
    }
    func collectionView(_ collectionView: ASCollectionView, willDisplay node: ASCellNode, forItemAt indexPath: IndexPath) {
        if (indexPath.row == data.count - 1) && doneReloading {
            collectionDelegate?.fetchNewData()
            doneReloading = false
        }
    }
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionNode.nodeForItem(at: indexPath) as? MainCellNode
        let movieId = cell?.movieId
        let title = cell?.title
        let posterImage = cell?.poster
        collectionDelegate?.didCellTap(id: movieId ?? 0, title: title ?? "", poster: posterImage ?? UIImage())
    }
    
}
