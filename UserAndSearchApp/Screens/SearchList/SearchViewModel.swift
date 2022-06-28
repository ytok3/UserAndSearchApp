//
//  SearchViewModel.swift
//  UserAndSearchApp
//
//  Created by Yasemin TOK on 26.06.2022.
//

import Foundation

protocol SearchViewModelProtocol {
    
    func setDelegateSearchAll(output: SearchBarOutput)
    func searchAllResults(inputSearch: String)
    func setDelegateSearchDetail(output: SearchDetailOutput)
    func searchDetailResult(trackId: Int)
}

final class SearchViewModel: SearchViewModelProtocol {
    
    // MARK: Properties
    
    private var service: ServiceProtocol
    private var searchAll: [Search]?
    private var searchOutput: SearchBarOutput?
    private var detail: Detail?
    private var detailOutput: SearchDetailOutput?

    // MARK: Init
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    
    // MARK: Func
    
    func setDelegateSearchAll(output: SearchBarOutput) {
        searchOutput = output
    }
    
    func setDelegateSearchDetail(output: SearchDetailOutput) {
        detailOutput = output
    }
    
    func searchAllResults(inputSearch: String) {
        service.getSearch(input: inputSearch) { [weak self] (response) in
            self?.searchAll = response
            self?.searchOutput?.listSearchResults(values: self?.searchAll ?? [])
            print(self?.searchAll ?? [])
        } onError: { error in
            print(error)
        }
    }
    
    func searchDetailResult(trackId: Int) {
        service.getDetail(id: trackId) { [weak self] (response) in
            self?.detail = response
            self?.detailOutput?.listSearchDetail(model: self?.detail)
        } onError: { error in
            print(error)
        }
    }
}
