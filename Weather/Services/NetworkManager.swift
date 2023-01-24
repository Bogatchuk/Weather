//
//  NetworkManager.swift
//  Weather
//
//  Created by Roma Bogatchuk on 17.12.2022.
//

import Foundation
protocol Networking {
    func request(url: URL, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkManager: Networking{
    static let shared = NetworkManager()
    private init(){}
    
    // building data request by URL
    func request(url: URL, completion: @escaping (Data?, Error?) -> () ){
        
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> ()) -> URLSessionDataTask{
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
                
            }
        }
    }
    
    
}
