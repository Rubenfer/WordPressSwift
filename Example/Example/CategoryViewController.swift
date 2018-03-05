//
//  CategoryViewController.swift
//  Example
//
//  Created by Ruben Fernandez on 5/3/18.
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit
import WordPressSwift

class CategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let wordpress = WordpressSwift()
        
        wordpress.getCategories(blogURL: "https://iosmac.es") { (categories) in
            
            for category in categories{
                
                print("The category called: \(category.name) with ID: \(category.id) contains \(category.count) posts\n\n")
                
            }
            
        }
        
    }

}
