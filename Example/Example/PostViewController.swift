//
//  PostViewController.swift
//  Example
//
//  Created by Ruben Fernandez on 5/3/18.
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit
import WordPressSwift

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let wordpress = WordpressSwift()
        
        wordpress.getPosts(blogURL: "https://iosmac.es", page: 1, postPerPage: 4, categoryID: [0]) { (posts) in
            
            for post in posts {
                
                print(post.title.text+"\n\n")
                
            }
            
        }
        
        
    }

}
