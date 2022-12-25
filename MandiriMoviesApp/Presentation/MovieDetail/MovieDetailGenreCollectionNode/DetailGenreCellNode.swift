//
//  DetailGenreCellNode.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 25/12/22.
//

import Foundation
import TextureSwiftSupport

class DetailGenreCellNode: ASCellNode {
    
    private lazy var genreContainer: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = .appYellow
        node.layoutSpecBlock = {[unowned self] _,_ -> ASLayoutSpec in
            return LayoutSpec {
                CenterLayout {
                    genreNode
                }
            }
        }
        return node
    }()
    
    private let genreNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    init(genre: String) {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .appYellow
        style.height = ASDimensionMake(30)
        cornerRadius = 5
        genreNode.attributedText = NSAttributedString(string: genre)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return LayoutSpec {
            CenterLayout {
                InsetLayout(insets: UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 10)) {
                    genreNode
                }
            }
        }
    }
}
