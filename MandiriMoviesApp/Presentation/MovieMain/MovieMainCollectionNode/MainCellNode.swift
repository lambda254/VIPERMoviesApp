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
    
    let loadingNode: ASDisplayNode = {
        let node = ASDisplayNode()
        
        DispatchQueue.main.async {
            let loadingSpinner: UIActivityIndicatorView = {
                let loadingSpinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
                loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
                loadingSpinner.hidesWhenStopped = true
                return loadingSpinner
            }()
            loadingSpinner.startAnimating()
            node.view.addSubview(loadingSpinner)
        }
        
        return node
    }()
    
    let titleNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    
    lazy var posterNode: ASImageNode = {
        let node = ASImageNode()
        node.automaticallyManagesSubnodes = true
        node.style.height = ASDimensionMake(.fraction, 0.86)
        node.contentMode = .scaleAspectFit
        node.cornerRadius = 30
        node.backgroundColor = .gray
        
        node.layoutSpecBlock = {[unowned self] _,_ -> ASLayoutSpec in
            return LayoutSpec {
                InsetLayout(insets: UIEdgeInsets(top: 100, left: 70, bottom: 20, right: 0)) {
                    loadingNode
                }
            }
        }
        return node
    }()
    
    init(movieId: Int, title: String, poster: UIImage) {
        self.title = title
        self.poster = poster
        self.movieId = movieId
        super.init()
        loadingNode.isHidden = true
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

