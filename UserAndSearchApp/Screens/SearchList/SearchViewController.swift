//
//  ViewController.swift
//  UserAndSearchApp
//
//  Created by Yasemin TOK on 26.06.2022.
//

import UIKit


class SearchViewController: UIViewController {
    
    // MARK: Properties
    
    private var searchViewModel: SearchViewModel = SearchViewModel(service: Services())
    private var searchCollectionViewFeatures: SearchCollectionViewFeatures = SearchCollectionViewFeatures()
    private var detailVC: SearchDetailViewController = SearchDetailViewController()
    private var cvTransfer: [Search] = []
    
    // MARK: View
    
    private let horizontalStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillProportionally
        sv.axis = .horizontal
        return sv
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = Constant.SearchProperties.SEARCH
        searchBar.sizeToFit()
        return searchBar
    }()
    
    private var collectionViewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setImage(UIImage(named: "cv"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(cvPressed), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()
    
    private var tableViewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setImage(UIImage(named: "tv"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tvPressed), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: Constant.Cell.CELL)
        return collectionView
    }()

    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        setUpDelegate()
    }
    
    // MARK: Func
    
    func setUpDelegate() {
        
        collectionView.delegate = searchCollectionViewFeatures
        collectionView.dataSource = searchCollectionViewFeatures
        
        searchCollectionViewFeatures.delegate = self
        searchBar.delegate = self
        
        setUpView()
    }

    func setUpView() {
        
        view.backgroundColor = .white
        view.addSubview(horizontalStack)
        view.addSubview(collectionView)
        horizontalStack.addArrangedSubview(searchBar)
        horizontalStack.addArrangedSubview(collectionViewButton)
        horizontalStack.addArrangedSubview(tableViewButton)
        
        setUpConstraint()
    }
    
    private func setUpConstraint() {
        
        let padding: CGFloat = 4
        
        NSLayoutConstraint.activate([
            
            horizontalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            horizontalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            horizontalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            horizontalStack.widthAnchor.constraint(equalToConstant: view.frame.width - padding / 2),
        
            searchBar.topAnchor.constraint(equalTo: horizontalStack.topAnchor, constant: padding),
            searchBar.widthAnchor.constraint(equalToConstant: view.frame.width / 1.50),
            
            collectionViewButton.topAnchor.constraint(equalTo: horizontalStack.topAnchor),
            collectionViewButton.leftAnchor.constraint(equalTo: searchBar.rightAnchor),
            collectionViewButton.widthAnchor.constraint(equalToConstant: view.frame.width / 8),
            
            tableViewButton.topAnchor.constraint(equalTo: horizontalStack.topAnchor),
            tableViewButton.leftAnchor.constraint(equalTo: collectionViewButton.rightAnchor),
            tableViewButton.widthAnchor.constraint(equalToConstant: view.frame.width / 8),
    
            collectionView.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
    
    @objc func cvPressed() {
        
        self.searchCollectionViewFeatures.search = cvTransfer
        collectionView.reloadData()

    }
    
    @objc func tvPressed() {
        
        self.searchCollectionViewFeatures.search.removeAll()
        collectionView.reloadData()
        
    }
}

// MARK: Extensions

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let trimmedText = searchText.replacingOccurrences(of: " ", with: "")
        let text = trimmedText.lowercased()
        
        searchViewModel.setDelegateSearchAll(output: self)
        searchViewModel.searchAllResults(inputSearch: text)
        print(text)
    }
}

extension SearchViewController: SearchBarOutput {
    
    func getHeight() -> CGFloat {
        return view.bounds.height
    }
    
    func onSelected(ID: Int) {
        searchViewModel.searchDetailResult(trackId: ID)
        searchViewModel.setDelegateSearchDetail(output: detailVC)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func listSearchResults(values: [Search]) {
        searchCollectionViewFeatures.search = values
        cvTransfer = values
        collectionView.reloadData()
    }
}
