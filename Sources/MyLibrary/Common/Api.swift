//
//  API.swift
//  app
//
//  Created by MWSR21 on 31.03.2022.
//

import SwiftUI
import Alamofire

class Api {
    var host = ""
    
    init(host: String) {
        self.host = host
    }
    
    func performRequest<T: Codable>(
        url: String,
        method: HTTPMethod = .get,
        params: Dictionary<String, Any> = [:],
        headers: HTTPHeaders = [:],
        encoding: ParameterEncoding = URLEncoding.default,
        completion: @escaping(T?
        ) -> Void) -> Void {
        AF.request(
            "\(host)/\(url)",
            method: method,
            parameters: params,
            encoding: encoding,
            headers: headers
        ).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success:
                completion(response.value!)
            case .failure(let error):
                print("Debug", error.localizedDescription)
            }
        }
    }
}


