//
//  ServiceManager.swift
//  UserAndSearchApp
//
//  Created by Yasemin TOK on 26.06.2022.
//

import Foundation
import Alamofire

final class ServiceManager {
    
    public static let shared: ServiceManager = ServiceManager()
}

extension ServiceManager {
    
    func fetch<T>(
        path: String,
        data: Codable?,
        method: HTTPMethod,
        onSucccess: @escaping (T) -> Void,
        onError: @escaping (AFError) -> Void)
    where T: Decodable, T: Encodable {
            
        AF.request(
            path,
            method: method,
            encoding: JSONEncoding.default
        ).validate().responseDecodable(of: T.self) { response in
            print(T.self)
            
            guard let model = response.value else {
                onError(response.error!)
                return
            }
            onSucccess(model)
        }
    }
}
