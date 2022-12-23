//
//  ReviewCellNode.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 23/12/22.
//

import Foundation
import TextureSwiftSupport

class ReviewCellNode: ASCellNode {
    
    private let usernameNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    private let reviewNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    private lazy var backgroundContainer: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = .gray
        node.automaticallyManagesSubnodes = true
        node.cornerRadius = 20
        
        node.layoutSpecBlock = {[self] _,_ -> ASLayoutSpec in
            return LayoutSpec {
                InsetLayout(insets: UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 10)) {
                    VStackLayout(spacing: 10) {
                        usernameNode
                        reviewNode
                    }
                }
            }
        }
        return node
    }()
    
    init(username: String, review: String) {
        super.init()
        automaticallyManagesSubnodes = true
        
        usernameNode.attributedText = NSAttributedString(string: username, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ])
        
        reviewNode.attributedText = NSAttributedString(string: review, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)
        ])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return LayoutSpec {
            InsetLayout(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) {
                backgroundContainer
            }
            
        }
    }
}
