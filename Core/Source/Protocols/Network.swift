//
//  Network.swift
//  Core
//
//  Created by Administrator on 5/22/21.
//

import Foundation

protocol URLSessionDataTaskProtocol { func resume() }

protocol URLSessionProtocol {
    func dataTask<T: Codable>(
        with request: URLRequest,
        type: T.Type,
        completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
    
    func dataTask<T: Codable>(
        with url: URL,  type: T.Type, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
}
