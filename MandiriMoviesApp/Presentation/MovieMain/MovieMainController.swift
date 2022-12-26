//
//  ViewController.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import UIKit
import TextureSwiftSupport

class MovieMainController: ASDKViewController<ASScrollNode> {
    
    var presenter: MovieMainPresenter?
    
    private let movieCollectionNode = MainCollectionNode()
    
    private let rootNode: ASScrollNode = {
        let node = ASScrollNode()
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        node.backgroundColor = .white
        return node
    }()
    
    private let loadingNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.width = ASDimensionMake(25)
        node.style.height = ASDimensionMake(25)
        node.isHidden = false
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
        setupDelegate()
        rootNode.layoutSpecBlock = {[unowned self] _,_ -> ASLayoutSpec in
            return LayoutSpec {
                InsetLayout(insets: UIEdgeInsets(top: 90, left: 16, bottom: 0, right: 16)) {
                    CenterLayout(centeringOptions: .X) {
                        movieCollectionNode
                    }
                }
                InsetLayout(insets: UIEdgeInsets(top: 90, left: 16, bottom: 0, right: 16)) {
                    ZStackLayout {
                        CenterLayout {
                            loadingNode
                        }
                    }
                }
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        node.view.contentInsetAdjustmentBehavior = .never
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.router = nil
    }
    
    deinit {
        print("controller deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDelegate() {
        movieCollectionNode.collectionDelegate = self
    }
    
}

extension MovieMainController: MovieMainViewProtocol {
    
    func update(result: Result<[MovieMain], Error>) {
        switch result {
        case .success(let data):
            movieCollectionNode.data += data
            UIView.performWithoutAnimation {
                movieCollectionNode.reloadData()
            }
            rootNode.setNeedsLayout()
            loadingNode.isHidden = true
        case .failure(let error):
            let error = error as NSError
            
            print(error)
                
        }
    }
    
    func update(title: String) {
        self.title = title
    }
    
}

extension MovieMainController: MainCollectionDelegate {
    
    func fetchNewMovies() {
        loadingNode.isHidden = false
        presenter?.fetchNewMovies()
    }
    
    func didCellTap(id: Int, title: String, poster: UIImage) {
        presenter?.navigateToDetail(id: id, title: title, poster: poster)
    }
    
}
