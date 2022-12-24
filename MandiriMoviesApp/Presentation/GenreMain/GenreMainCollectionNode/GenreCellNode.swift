//
//  GenreCellNode.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 23/12/22.
//

import Foundation
import TextureSwiftSupport

class GenreCellNode: ASCellNode {
        
    let paragraph = NSMutableParagraphStyle()
    
    var id: Int?
    
    let randomColor = UIColor(red: CGFloat(Int.random(in: 0 ... 255)) / 255, green: CGFloat(Int.random(in: 0 ... 255)) / 255, blue: CGFloat(Int.random(in: 0 ... 255)) / 255, alpha: 0.5)
    
    let titleNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    init(title: String, id: Int) {
        self.id = id
        super.init()
        
        automaticallyManagesSubnodes = true
        style.width = ASDimensionMake(150)
        style.height = ASDimensionMake(150)
        paragraph.alignment = NSTextAlignment.center
        backgroundColor = randomColor
        cornerRadius = 10

        let attrs = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold),
            NSAttributedString.Key.paragraphStyle: paragraph
        ]
        
        titleNode.attributedText = NSAttributedString(string: title, attributes: attrs)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return LayoutSpec {
            CenterLayout(centeringOptions: .X) {
                InsetLayout(insets: UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)) {
                    CenterLayout {
                        titleNode
                    }
                }
                
            }
        }
    }
}


