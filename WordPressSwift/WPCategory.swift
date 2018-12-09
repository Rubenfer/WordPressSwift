//
//  WPCategory.swift
//  WordPressSwift
//
//  Created by Ruben Fernandez on 09/12/2018.
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Foundation

public struct WPCategory: Codable {
    public let id: Int
    public let count: Int
    public let description: String
    public let link: String
    public let name: String
    public let slug: String
    public let taxonomy: String
    public let parent: Int
}
