//
//  MovieDetailController.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import TextureSwiftSupport
import YouTubeiOSPlayerHelper

class MovieDetailController: ASDKViewController<ASScrollNode> {
    
    var presenter: MovieDetailPresenter?
        
    private let paragraph = NSMutableParagraphStyle()
            
    var ytPlayer = YTPlayerView()
    
    private let rootNode: ASScrollNode = {
        let node = ASScrollNode()
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        node.backgroundColor = .white
        return node
    }()
    
    private let titleNode: ASTextNode = {
        let node = ASTextNode()
        node.style.width = ASDimensionMake(150)
        return node
    }()
    
    private let synopsisTitleNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Synopsis:", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21, weight: .bold)
        ])
        return node
    }()
    
    private let synopsisDescNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    private let genreNode: ASTextNode = {
        let node = ASTextNode()
        node.style.width = ASDimensionMake(150)
        //        node.style.height = ASDimensionMake(180)
        return node
    }()
    
    private let posterNode: ASImageNode = {
        let node = ASImageNode()
        node.style.width = ASDimensionMake(200)
        node.style.height = ASDimensionMake(300)
        node.backgroundColor = .red
        node.cornerRadius = 30
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    private let reviewButton: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = .black
        node.style.width = ASDimensionMake(.fraction, 1)
        node.style.height = ASDimensionMake(40)
        node.cornerRadius = 10
        node.setAttributedTitle(NSAttributedString(string: "See Reviews", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        node.addTarget(nil, action: #selector(reviewButtonTapped), forControlEvents: .touchUpInside)
        return node
    }()
    
    private let dismissButton: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = .clear
        node.style.width = ASDimensionMake(50)
        node.style.height = ASDimensionMake(50)
        node.setImage(UIImage(systemName: "xmark"), for: .normal)
        node.addTarget(nil, action: #selector(dismissButtonTapped), forControlEvents: .touchUpInside)
        return node
    }()
    
    private let trailerTitleNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Trailer:", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21, weight: .bold)
        ])
        return node
    }()
    
    private lazy var youtubeVideoNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.width = ASDimensionMake(.fraction, 1)
        node.style.height = ASDimensionMake(200)
        node.view.addSubview(ytPlayer)
        return node
    }()
    
    override init() {
        super.init(node: rootNode)
        
        rootNode.layoutSpecBlock = {[self] _,_ -> ASLayoutSpec in
            return LayoutSpec {
                InsetLayout(insets: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)) {
                    VStackLayout {
                        dismissButton
                        InsetLayout(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)) {
                            VStackLayout(spacing: 10) {
                                HStackLayout(spacing: 10) {
                                    posterNode
                                    VStackLayout(spacing: 5) {
                                        titleNode
                                        genreNode
                                        SpacerLayout()
                                        reviewButton
                                    }
                                }
                                VStackLayout(spacing: 10) {
                                    synopsisTitleNode
                                    synopsisDescNode
                                    VStackLayout(spacing: 5) {
                                        trailerTitleNode
                                        youtubeVideoNode
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ytPlayer.frame = CGRect(x: 0, y: 0, width: node.frame.width * 0.92, height: node.frame.height * 0.24)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        node.view.contentInsetAdjustmentBehavior = .never
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func reviewButtonTapped() {
        presenter?.navigateToReview()
    }
    
    @objc func dismissButtonTapped() {
        presenter?.dismissView()
    }
}

extension MovieDetailController: MovieDetailViewProtocol {
    
    func update(title: String, posterImage: UIImage) {
        let attrsTitle = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 27, weight: .bold),
            NSAttributedString.Key.paragraphStyle: paragraph
        ]
        posterNode.image = posterImage
        titleNode.attributedText = NSAttributedString(string: title, attributes: attrsTitle)
    }
    
    func update(with detail: MovieDetail) {
        genreNode.attributedText = NSAttributedString(string: detail.genres.joined(separator: ", "), attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
        ])
        synopsisDescNode.attributedText = NSAttributedString(string: detail.synopsis, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
        ])
    }
    
    func update(trailer: String) {
        //This is still causing purple warning
        DispatchQueue.main.async {[unowned self] in
            ytPlayer.load(withVideoId: trailer)
        }
    }
    
}
