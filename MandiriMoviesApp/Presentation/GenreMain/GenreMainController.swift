//
//  GenreMainController.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import TextureSwiftSupport
import YouTubeiOSPlayerHelper

class GenreMainController: ASDKViewController<ASScrollNode> {
    
    var presenter: GenreMainPresenter?
    
    var genreCollectionNode = GenreCollectionNode()
    
    private let rootNode: ASScrollNode = {
        let node = ASScrollNode()
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        node.backgroundColor = .white
        return node
    }()
    
    override init() {
        super.init(node: rootNode)
        self.title = "Genres"
        setupDelegate()
        rootNode.layoutSpecBlock = {[self] _,_ -> ASLayoutSpec in
            return LayoutSpec {
                InsetLayout(insets: UIEdgeInsets(top: 90, left: 30, bottom: 0, right: 30)) {
                    genreCollectionNode
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        node.view.contentInsetAdjustmentBehavior = .never
    }
    
    func setupDelegate() {
        genreCollectionNode.collectionDelegate = self
    }

}

extension GenreMainController: GenreMainViewProtocol {
    
    func update(result: Result<[GenreMain], Error>) {
        switch result {
        case .success(let data):
            genreCollectionNode.data = data
            genreCollectionNode.reloadData()
        case .failure(let error):
            print(error)
        }
    }
    
}

extension GenreMainController: GenreCollectionDelegate {
    
    func didCellTap(id: Int, title: String) {
        presenter?.navigateToMovieMain(genreId: id, title: title)
    }
    
}
