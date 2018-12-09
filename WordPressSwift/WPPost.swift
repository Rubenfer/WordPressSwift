//
//  WPPost.swift
//  WordPressSwift
//
//  Created by Ruben Fernandez on 09/12/2018.
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Foundation

public struct WPPost: Codable {
    
    public struct Title: Codable {
        public let text: String
        private enum CodingKeys: String, CodingKey {
            case text = "rendered"
        }
    }
    
    public struct Content: Codable {
        public let text: String
        public let protected: Bool
        private enum CodingKeys: String, CodingKey {
            case text = "rendered"
            case protected
        }
    }
    
    public struct Excerpt: Codable {
        public let text: String
        public let protected: Bool
        private enum CodingKeys: String, CodingKey {
            case text = "rendered"
            case protected
        }
    }
    
    public let id: Int
    public let date: String
    public let date_gmt: String
    public let modified: String
    public let modified_gmt: String
    public let slug: String
    public let status: String
    public let type: String
    public let link: String
    public let title: Title
    public let content: Content
    public let excerpt: Excerpt
    public let author: Int
    public let featured_media: Int
    public let comment_status: String
    public let ping_status: String
    public let sticky: Bool
    public let template: String
    public let format: String
    public let categories: [Int]
    public let tags: [Int]
    
}
