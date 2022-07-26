//
//  SearchTableViewFeatures.swift
//  UserAndSearchApp
//
//  Created by Yasemin TOK on 24.07.2022.
//

import UIKit

class SearchTableViewFeatures: UIViewController {

    // MARK: Properties
    
    var searchTV : [Search] = []
    weak var delegate: SearchBarOutput?
}

// MARK: Exensions

extension SearchTableViewFeatures : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTV.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell.TV_CELL, for: indexPath)
                as? SearchTableViewCell else {return UITableViewCell()}
        cell.showCharacters(model: searchTV[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelected(ID: searchTV[indexPath.row].trackID ?? 0)
    }
}
