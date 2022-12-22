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
    
    private let rootNode: ASScrollNode = {
        let node = ASScrollNode()
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        node.backgroundColor = .blue
        return node
    }()

    override init() {
        super.init(node: rootNode)
        rootNode.layoutSpecBlock = { _,_ -> ASLayoutSpec in
            return LayoutSpec {
                
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
    
}

extension MainViewController: MainViewProtocol {
    
    func update(with movies: [MovieMain]) {
        
    }
    
    func update(with errors: String) {
        
    }
    
}

