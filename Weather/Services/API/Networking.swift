//
//  Networking.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/28/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

extension String: Error {
    
    static var badUrl: String { return "Bad url format" }
    
}

class Networking: NSObject {
    
    static let shared = Networking()
    
    var urlSession: URLSession
    var cacheImage = NSCache<NSString, UIImage>()
    
    override init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let queue = OperationQueue()
        queue.name = "com.Weather.Networking.Queue"
        
        self.urlSession = URLSession(configuration: config, delegate: nil, delegateQueue:queue)
        
        super.init()
    }
    
    func execute<T: Codable>(_ request: APIRequest, codable: T.Type, competion: @escaping (T?, Error?)->()) {
        
        var url: URL?
        
        if request.parametrs.count > 0 {
            var components = URLComponents(string: request.url)
            components?.queryItems = request.parametrs.map({ URLQueryItem(name: $0.key, value: "\($0.value)".urlQueryValue()) })
            url = components?.url
        } else {
            url = URL(string: request.url)
        }
        
        guard let URL = url else {
            competion(nil, String.badUrl)
            return
        }
        
        let urlRequest = URLRequest(url: URL)
        
        let task = self.urlSession.dataTask(with: urlRequest) { (data, respone, error) in
            
            var result: T? = nil
            var error = error
            if let data = data {
                do {
                    result = try JSONDecoder().decode(codable, from: data)
                }
                catch (let parce) {
                    error = parce
                }
            }
            
            DispatchQueue.main.async {
                competion(result, error)
            }
        }
        
        task.resume()
    }
    
    // Donload images
    
    static func image(with url: String, competion: @escaping (UIImage?)->()) {
        self.shared.image(with: url, competion: competion)
    }
    
    func image(with url: String, competion: @escaping (UIImage?)->()) {
        guard let url = URL(string: url) else {
            competion(nil)
            return
        }
        
        if let image = self.cacheImage.object(forKey: url.absoluteString as NSString) {
            competion(image)
            return
        }
        
        let task = self.urlSession.dataTask(with: url) { (data, respone, error) in
            
            var image: UIImage?
            if let data = data {
                image = UIImage(data: data)
            }
            
            if let image = image {
                self.cacheImage.setObject(image, forKey: url.absoluteString as NSString)
            }
            
            competion(image)
        }
        
        task.resume()
    }
}

// MARK: - String extension

private extension String {
    
    func urlQueryValue() -> String {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~,")
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? ""
    }
}


