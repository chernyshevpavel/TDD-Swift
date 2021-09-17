//
//  APIClient.swift
//  ToDoApp
//
//  Created by Павел Чернышев on 14.09.2021.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class APIClient {
    lazy var urlSession: URLSessionProtocol = URLSession.shared
    
    func login(withName name: String, password: String, completionHandler: @escaping (String?, Error?) -> Void) {
        
        let allowedCharacters = CharacterSet.urlQueryAllowed
        
        guard
            let name = name.addingPercentEncoding(withAllowedCharacters: allowedCharacters),
            let password = password.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
                fatalError()
        }
        
        let query = "name=\(name)&password=\(password)"
        guard let url = URL(string: "https://todoapp.com/login?\(query)") else {
            fatalError()
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : String]
            else { fatalError() }
            let token = dictionary["token"]
            completionHandler(token, nil)
        }.resume()
    }
}
