//
//  Services.swift
//  UserAndSearchApp
//
//  Created by Yasemin TOK on 26.06.2022.
//

import Foundation
import Alamofire


protocol ServiceProtocol {
    
    func getSearch(input: String, onSuccess: @escaping ([Search]?) -> Void, onError: @escaping (AFError) -> Void)
}

final class Services: ServiceProtocol {
    
    // MARK: Func
    
    func getSearch(input: String, onSuccess: @escaping ([Search]?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.Network.BASE_URL + "\(input)", data: nil, method: HTTPMethod.get) { (response: SearchList) in
            onSuccess(response.results)
            print(response)
        } onError: { error in
            onError(error)
            print(error)
        }
    }
}
