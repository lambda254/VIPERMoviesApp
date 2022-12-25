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
        let randomColor = UIColor(red: CGFloat.random(in: 0 ... 255)/255, green: CGFloat.random(in: 0 ... 255)/255, blue: CGFloat.random(in: 0 ... 255)/255, alpha: 1).cgColor
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true
        node.cornerRadius = 20
        node.borderWidth = 1
        node.borderColor = randomColor
        node.shadowOffset = CGSize(width: 10, height: 10)
        node.shadowColor = UIColor.black.cgColor
        node.shadowRadius = 10
        node.shadowOpacity = 0.3
        
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
            InsetLayout(insets: UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10)) {
                backgroundContainer
            }
            
        }
    }
}
