//
//  ViewController.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import UIKit
import TextureSwiftSupport

class MainViewController: ASDKViewController<ASScrollNode> {
    
    var presenter: MainPresenter?
    
    private let movieCollectionNode = MainCollectionNode()
    
    private let rootNode: ASScrollNode = {
        let node = ASScrollNode()
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        node.backgroundColor = .white
        return node
    }()

    override init() {
        super.init(node: rootNode)
        setupDelegate()
        rootNode.layoutSpecBlock = {[unowned self] _,_ -> ASLayoutSpec in
            return LayoutSpec {
                InsetLayout(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)) {
                    movieCollectionNode
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        node.view.contentInsetAdjustmentBehavior = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDelegate() {
        movieCollectionNode.collectionDelegate = self
    }
    
}

extension MainViewController: MainViewProtocol {
    
    func update(with movies: [MovieMain]) {
        movieCollectionNode.data = movies
        movieCollectionNode.reloadData()
    }
    
    func update(with errors: String) {
        
    }
    
}

extension MainViewController: MainCollectionDelegate {
    
    func fetchNewData() {
        
    }
    
    func didCellTap(id: Int, title: String, poster: UIImage) {
        print(title)
    }
    
    
}
