//
//  ReviewStarCellNode.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 25/12/22.
//

import Foundation
import TextureSwiftSupport

class DetailStarCellNode: ASCellNode {
    private let ratingStarNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(systemName: "star.fill")
        node.imageModificationBlock = ASImageNodeTintColorModificationBlock(.appYellow)
        node.style.width = ASDimensionMake(20)
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return LayoutSpec {
            CenterLayout {
                ratingStarNode
            }
        }
    }
    
    func unfilledStar() {
        ratingStarNode.image = UIImage(systemName: "star")
        ratingStarNode.setNeedsLayout()
    }
}
