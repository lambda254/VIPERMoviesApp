//
//  MainCellNode.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import TextureSwiftSupport

class MainCellNode: ASCellNode {
    
    var title: String
    
    var poster: UIImage
    
    var movieId: Int
    
    let paragraph = NSMutableParagraphStyle()
    
    let titleNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    let posterNode: ASImageNode = {
        let node = ASImageNode()
        node.style.height = ASDimensionMake(.fraction, 0.86)
        node.contentMode = .scaleAspectFit
        node.cornerRadius = 30
        return node
    }()
    
    init(movieId: Int, title: String, poster: UIImage) {
        self.title = title
        self.poster = poster
        self.movieId = movieId
        super.init()
        automaticallyManagesSubnodes = true
        style.width = ASDimensionMake(160)
        style.height = ASDimensionMake(300)
        paragraph.alignment = NSTextAlignment.center

        let attrs = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold),
            NSAttributedString.Key.paragraphStyle: paragraph
        ]
        
        titleNode.attributedText = NSAttributedString(string: title, attributes: attrs)
        posterNode.image = poster
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return LayoutSpec {
            CenterLayout(centeringOptions: .X) {
                InsetLayout(insets: UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)) {
                    VStackLayout {
                        posterNode
                        titleNode
                    }
                }
                
            }
        }
    }
}

