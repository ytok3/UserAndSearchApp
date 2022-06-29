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
    
    // MARK: View
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = Constant.Properties.SEARCH
        searchBar.sizeToFit()
        return searchBar
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
        view.addSubview(searchBar)
        view.addSubview(collectionView)

        setUpConstraint()
    }
    
    private func setUpConstraint() {
        
        let padding: CGFloat = 4
        
        NSLayoutConstraint.activate([
        
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
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
        collectionView.reloadData()
    }
}
