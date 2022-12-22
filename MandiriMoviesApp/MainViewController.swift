//
//  ViewController.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import UIKit
import TextureSwiftSupport

class MainViewController: ASDKViewController<ASScrollNode> {
    
    private let rootNode: ASScrollNode = {
        let node = ASScrollNode()
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        node.backgroundColor = .white
        return node
    }()

    override init() {
        super.init(node: rootNode)
        rootNode.layoutSpecBlock = { _,_ -> ASLayoutSpec in
            return LayoutSpec {
                
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

