# WordPressSwift

## Description
`WordPressSwift` is the easiest way to integrate the WordPress API into your app. You can retreive the blog's categories, posts (filtered by author, date, categories,...), and much more.

## Installation
If you're using Xcode 11, you can simply add the Swift Package dependency to your proyect. If you're using an older version of Xcode, you can still using WordPressSwift by copying the Source folder into your project directory.

## Usage

### Obtain posts
**Class: `WPPost`**  
Class methods:  
`getPosts(web:author:numberOfPosts:after:categories:completionHandler:)`  
`getPosts(web:page:postsPerPage:author:after:categories:completionHandler:)`  
`getPost(web:id:completionHandler:)`  
`getPostsMonth(_:month:year:) -> [WPPost]`  
`getPostsMonth(_:) -> [WPPost]`  
`getFirstPost(_:) -> WPPost?`  
Instance methods:  
`countWords() -> Int`  

**Class: `WPMedia`**  
Class methods:  
`getImage(web:id:completionHandler)`  

**Class: `WPCategory`**  
Class methods:  
`getCategories(web:completionHandler:)`  
`getCategory(web:id:completionHandler:)`  

**Class: `WPAuthor`**  
Class methods:  
`getAuthors(web:completionHandler:)`  
`getAuthor(web:id:completionHandler:)`  

For more information about the usage of available methods, please check the documentation of each one.

## Author
I'm Rubén Fernández, a Spanish developer. You can send me an [email](mailto:ruben.fdez@icloud.com) or follow me on [Twitter (@RubenApps)](https://twitter.com/RubenApps)

## License

`WordPressSwift` is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
