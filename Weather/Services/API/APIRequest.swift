//
//  APIRequest.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/28/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import Foundation

class APIRequest {
    
    var url: String
    var parametrs = [String: Any]()
    
    init(url: String) {
        self.url = url
    }
    
    @discardableResult
    func path(_ path: String) -> Self {
        self.url = "\(self.url)/\(path)"
        return self
    }
    
    func query(_ query: [String: Any]) -> Self {
        for (key, value) in query {
            parametrs[key] = value
        }
        return self
    }
    
    func get<T: Codable>(_ codable: T.Type, completion: @escaping (T?, Error?) -> ()) {
        Networking.shared.execute(self, codable: codable, competion: completion)
    }
}
