//
//  MainCollectionNode.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import TextureSwiftSupport

protocol MainCollectionDelegate: AnyObject {
    func fetchNewMovies()
    func didCellTap(id: Int, title: String, poster: UIImage)
}

class MainCollectionNode: ASCollectionNode {
    
    weak var collectionDelegate: MainCollectionDelegate?
    
    var data = [MovieMain]()
    
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

extension MainCollectionNode: ASCollectionDelegate, ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = {[self] () -> ASCellNode in
            let cellNode = MainCellNode(movieId: data[indexPath.row].id, title: data[indexPath.row].title, poster: data[indexPath.row].posterImage)
            return cellNode
        }
        return cellNodeBlock
    }
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionNode.nodeForItem(at: indexPath) as? MainCellNode
        let movieId = cell?.movieId
        let title = cell?.title
        let posterImage = cell?.poster
        collectionDelegate?.didCellTap(id: movieId ?? 0, title: title ?? "", poster: posterImage ?? UIImage())
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, willDisplayItemWith node: ASCellNode) {
        let cell = node as? MainCellNode
        if cell?.movieId == data.last?.id {
//            collectionDelegate?.fetchNewMovies()
        }
    }
}

