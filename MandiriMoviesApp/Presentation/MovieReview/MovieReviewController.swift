//
//  MovieReviewController.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import TextureSwiftSupport
import YouTubeiOSPlayerHelper

class MovieReviewController: ASDKViewController<ASScrollNode> {
    
    var presenter: MovieReviewPresenter?
    
    private let reviewTableNode = ReviewTableNode()
    
    private var isLoading = true
    
    private let rootNode: ASScrollNode = {
        let node = ASScrollNode()
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        node.backgroundColor = .white
        return node
    }()
    
    private let warningNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "No reviews for this movie", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
        return node
    }()
    
    private let loadingNode: ASDisplayNode = {
        let node = ASDisplayNode()
        let loadingSpinner: UIActivityIndicatorView = {
            let loadingSpinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
            loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
            loadingSpinner.hidesWhenStopped = true
            return loadingSpinner
        }()
        loadingSpinner.startAnimating()
        node.view.addSubview(loadingSpinner)
        return node
    }()
    
    override init() {
        super.init(node: rootNode)
        self.title = "Review"
        setupDelegate()
        rootNode.layoutSpecBlock = {[self] _,_ -> ASLayoutSpec in
            return LayoutSpec {
                CenterLayout(centeringOptions: .X) {
                    InsetLayout(insets: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)) {
                        reviewTableNode
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        node.view.contentInsetAdjustmentBehavior = .never
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.tintColor = .black
    }
    
    func setupDelegate() {
        reviewTableNode.tableDelegate = self
    }

}

extension MovieReviewController: MovieReviewViewProtocol {
    
    func update(with review: [MovieReview]) {
        reviewTableNode.data += review
        reviewTableNode.reloadData()
        rootNode.setNeedsLayout()
        isLoading.toggle()
    }
    
}

extension MovieReviewController: ReviewTableDelegate {
    func fetchNewReviews() {
        presenter?.fetchNewReviews()
    }
}
