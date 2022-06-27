//
//  ViewController.swift
//  UserAndSearchApp
//
//  Created by Yasemin TOK on 26.06.2022.
//

import UIKit

protocol SearchBarOutput: AnyObject {
    func listSearchResults(values: [Search])
}

final class SearchViewController: UIViewController {
    
    // MARK: Properties
    
    private var searchViewModel: SearchViewModel = SearchViewModel(service: Services())
    
    // MARK: View
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = Constant.Properties.SEARCH
        searchBar.sizeToFit()
        return searchBar
    }()

    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDelegate()
    }
    
    // MARK: Func
    
    func setUpDelegate() {
        
        searchBar.delegate = self
        
        setUpView()
    }

    func setUpView() {
        
        view.backgroundColor = .white
        view.addSubview(searchBar)

        setUpConstraint()
    }
    
    private func setUpConstraint() {
        
        let padding: CGFloat = 4
        
        NSLayoutConstraint.activate([
        
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    
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
    func listSearchResults(values: [Search]) {
        print(values)
    }
}
