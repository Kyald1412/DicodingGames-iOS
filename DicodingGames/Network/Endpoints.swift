//
//  Endpoints.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//


import Foundation

struct API {
    static let baseUrl = "https://api.rawg.io/api/"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum Games: Endpoint {
        case allgames
        case detail

        public var path: String {
            switch self {
            case .allgames: return "games"
            case .detail: return "games/"
            }
        }
        
        public var url: String {
            return "\(API.baseUrl)\(path)"
        }
    }
}
