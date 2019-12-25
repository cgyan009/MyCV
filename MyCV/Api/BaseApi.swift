//
//  BaseApi.swift
//  MyCV
//
//  Created by Chenguo Yan on 2019-12-24.
//  Copyright © 2019 Chenguo Yan. All rights reserved.
//

import Foundation

class BaseApi {
    enum ApiError: Error {
        case serviceError
    }
    
    func execute(_ request: URLRequest, completion: @escaping (dictionary?, Error?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
                completion(nil, ApiError.serviceError)
                return
            }
            guard let data = data, error == nil else {
                completion(nil, ApiError.serviceError)
                return
            }
            do {
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? dictionary else {
                    completion(nil, ApiError.serviceError)
                    return }
                completion(jsonDictionary, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}

extension BaseApi: CVFetchable {
    
    func fetchCV(completion: @escaping (dictionary?, Error?) -> Void) {
        let urlString = "https://gist.githubusercontent.com/cgyan009/00e771465ccb69db5b6eb6b12a2ea77d/raw/9d2adfdef328394febacd9032eaffdbda172e1d7/coocv.json"
        
            guard let cvUrl = URL(string: urlString) else {
                completion(nil, ApiError.serviceError)
                return
            }
        var request = URLRequest(url: cvUrl)
        request.httpMethod = "GET"
        execute(request, completion: completion)
    }
}
