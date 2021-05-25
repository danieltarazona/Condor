//
//  Core+URLSession.swift
//  Core
//
//  Created by Daniel Tarazona on 5/22/21.
//

import Foundation

extension URLSession {
    func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void)  -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func codableTask<T: Codable>(with request: URLRequest, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
}

extension URLSession: URLSessionProtocol {
    func dataTask<T: Codable>(
        with url: URL,
        type: T.Type,
        completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
    
    func dataTask<T: Codable>(
        with request: URLRequest,
        type: T.Type,
        completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return self.codableTask(with: request, completionHandler: completionHandler)
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
