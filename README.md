# WordPressSwift

[![Version](https://img.shields.io/cocoapods/v/WordPressSwift.svg?style=flat)](http://cocoapods.org/pods/WordPressSwift)
[![License](https://img.shields.io/cocoapods/l/WordPressSwift.svg?style=flat)](http://cocoapods.org/pods/WordPressSwift)
[![Platform](https://img.shields.io/cocoapods/p/WordPressSwift.svg?style=flat)](http://cocoapods.org/pods/WordPressSwift)



## Description
`WordPressSwift` allow you to integrate a WordPress blog on your own app.
You can retreive the categories of the blog, posts (you can filter by category), and the featured image of one post. In next versions we'll introduce more amazing features.

## Usage
Run the example project from the `Example` directory and check out `CategoryViewController.swift` and `PostViewController.swift`.

```swift
import WordPressSwift

let wordpress = WordPressSwift()

// Get categories

var myCategories: [WPCategory] = []
wordpress.getCategories(blogURL: "http://myBlog.es") { (categories) in

    self.myCategories = categoriesblogURL
    
    // Write here all that you want to execute after load categories.

}

// Get posts

var myPosts: [WPPost] = []

wordpress.getPosts(blogURL: "http://myBlog.es", page: 1, postPerPage: 5) { (posts) in

    /*
    If you have a blog with many posts, the best way to load it quickly on your app is loading posts by pages. You must enter the page to load (you can use a counter to increment it when you want to load more posts) and postPerPage, which is the number of posts that you want load per each page.
    
    Also you need to provide an integer array to categoryID. You can filter the posts by categories, so you can provide here the IDs of categories to filter (you can access to ID on WPCategory.id). If you want to load all posts, put categoryID to [0].
    */

    self.myPosts = postsblogURL
    
    // Write here all that you want to execute after load categories.

}

// Get featured image of a postafter

var myImage: WPFeaturedImage!

wordpress.featuredImage(blogURL: "http://myBlog.es", post: myPost) { (image) in

    /*
    On post parameter you must provide a post of type: WPPostblogURL
    */

    self.myImage = image
    
    // Write here all that you want to execute after load categories.
    
}

```

## Data types
`WordPressSwift` uses three data types: `WPCategory`, `WPPost` and `WPFeaturedImage`. The types of data includes multiple values that can be useful in development process.

```swift
public struct WPPost: Codable {

    public struct Title: Codable {
        public let text: String
    }

    public struct Content: Codable {
        public let text: String
        public let protected: Bool
    }

    public struct Excerpt: Codable {
        public let text: String
        public let protected: Bool
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

}
```

## Installation

`WordPressSwift` is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod 'WordPressSwift'
```

You can also copy into your project the file `WordPressSwift.framwork`


## Requirements
iOS 10.0 and Swift 4.0 are required.

## Author

I'm Ruben Fernandez
Email: [ruben.fdez@icloud.com](mailto:ruben.fdez@icloud.com)
Twitter: [@RubenApps](http://twitter.com/RubenApps).

## License

`WordPressSwift` is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
