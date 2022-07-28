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
    private var searchTableViewFeatures: SearchTableViewFeatures = SearchTableViewFeatures()
    private var detailVC: SearchDetailViewController = SearchDetailViewController()
  
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
        button.setImage(UIImage(named: Constant.SearchProperties.CV), for: .normal)
        button.addTarget(self, action: #selector(cvPressed), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()
    
    private var tableViewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setImage(UIImage(named: Constant.SearchProperties.TV), for: .normal)
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
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: Constant.Cell.CV_CELL)
        return collectionView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.rowHeight = 200
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: Constant.Cell.TV_CELL)
        return tableView
    }()

    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.isHidden = true
   
        setUpNavigation()
        setUpDelegate()
    }
    
    // MARK: Func
    
    func setUpNavigation() {

        let logOut = UIBarButtonItem()
        logOut.title = Constant.SearchProperties.LOG_OUT
        navigationController?.navigationBar.backItem?.backBarButtonItem = logOut
   
    }
    
    func setUpDelegate() {
        
        collectionView.delegate = searchCollectionViewFeatures
        collectionView.dataSource = searchCollectionViewFeatures
        
        tableView.delegate = searchTableViewFeatures
        tableView.dataSource = searchTableViewFeatures
        
        searchCollectionViewFeatures.delegate = self
        searchTableViewFeatures.delegate = self
        
        searchBar.delegate = self
        
        setUpView()
    }

    func setUpView() {
        
        view.backgroundColor = .white
        view.addSubview(horizontalStack)
        view.addSubview(collectionView)
        view.addSubview(tableView)
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
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            
            tableView.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: padding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
        ])
    }
    
    @objc func cvPressed() {
        
        collectionView.isHidden  = false
        tableView.isHidden = true
    }
    
    @objc func tvPressed() {
        
        collectionView.isHidden = true
        tableView.isHidden = false
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
        searchTableViewFeatures.searchTV = values
        collectionView.reloadData()
        tableView.reloadData()
    }
}
