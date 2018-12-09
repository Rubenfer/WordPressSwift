//
//  WPFeaturedImage.swift
//  WordPressSwift
//
//  Created by Ruben Fernandez on 09/12/2018.
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Foundation

public struct WPFeaturedImage: Codable {
    
    public struct MediaDetails: Codable {
        public let width: Int
        public let height: Int
        public let file: String
    }
    
    public let id: Int
    public let image: String
    public let type: String
    public let media_type: String
    public let media_details: MediaDetails
    
    private enum CodingKeys: String, CodingKey {
        
        case id
        case image = "source_url"
        case type
        case media_type
        case media_details
        
    }
    
}
