//
//  NetworkDataFetcher.swift
//  Weather
//
//  Created by Roma Bogatchuk on 17.12.2022.
//

import Foundation

protocol DataFetcher {
    func fetchGenericJSONData<T: Decodable>(url: URL, completion: @escaping (T?) -> ())
}

class NetworkDataFetcher: DataFetcher{
    static let shared = NetworkDataFetcher()
    private init(){}
    
    
    func fetchGenericJSONData<T: Decodable>(url: URL, completion: @escaping (T?) -> ()){
        NetworkManager.shared.request(url: url) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: T.self, from: data)
            completion(decode)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T?{
        let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data else {return nil}
        do{
            let object = try decoder.decode(type.self, from: data)
            return object
        }catch let jsonError{
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
