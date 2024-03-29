//
//  SearchDetailViewController.swift
//  UserAndSearchApp
//
//  Created by Yasemin TOK on 27.06.2022.
//

import UIKit
import AlamofireImage

protocol SearchDetailOutput {
    func listSearchDetail(model: Detail?)
}

class SearchDetailViewController: UIViewController {
    
    // MARK: View
    
    private let detailImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        return iv
    }()
    
    private let verticalStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    private var trackNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var kindLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var collectionPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()

    }
    
    // MARK: Func
    
    func setUpView() {
        
        view.backgroundColor = .white
            
        view.addSubview(detailImage)
        view.addSubview(verticalStack)
        verticalStack.addArrangedSubview(trackNameLabel)
        verticalStack.addArrangedSubview(artistNameLabel)
        verticalStack.addArrangedSubview(kindLabel)
        verticalStack.addArrangedSubview(collectionPriceLabel)
        
        detailImage.layer.cornerRadius = 4
        
        setUpConstraint()
    }

    func setUpConstraint() {
        
        let padding: CGFloat = 4
        
        NSLayoutConstraint.activate([
            
            detailImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,  constant: padding),
            detailImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            detailImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            detailImage.heightAnchor.constraint(equalToConstant: view.frame.height / 1.50),
            
            verticalStack.topAnchor.constraint(equalTo: detailImage.bottomAnchor, constant: padding),
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            verticalStack.widthAnchor.constraint(equalToConstant: view.frame.width - padding * 2),
            verticalStack.heightAnchor.constraint(equalToConstant: view.frame.height / 10),
            
            trackNameLabel.topAnchor.constraint(equalTo: verticalStack.bottomAnchor),
            trackNameLabel.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor),
            trackNameLabel.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor),
            
            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor),
            artistNameLabel.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor),
            artistNameLabel.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor),
            
            kindLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor),
            kindLabel.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor),
            kindLabel.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor),
            
            collectionPriceLabel.topAnchor.constraint(equalTo: kindLabel.bottomAnchor),
            collectionPriceLabel.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor),
            collectionPriceLabel.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor),
            
        ])
    }
}

// MARK: Extension

extension SearchDetailViewController: SearchDetailOutput {
    
    func listSearchDetail(model: Detail?) {
        
        let kind = (model?.kind ?? "")
        
        kindLabel.text = Constant.DetailProperties.KIND + kind.capitalized
        trackNameLabel.text = model?.trackName
        artistNameLabel.text = Constant.DetailProperties.ARTIST_NAME + (model?.artistName ?? "")
        collectionPriceLabel.text = Constant.DetailProperties.COLLECTION_PRICE + "\(model?.collectionPrice ?? 0)"
        detailImage.af.setImage(withURL: URL(string: (model?.artworkUrl100)!)!)
    }
}
