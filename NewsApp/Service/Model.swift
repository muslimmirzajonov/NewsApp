//
//  Model.swift
//  NewsApp
//
//  Created by muslim mirzajonov on 01/06/22.
//

import Foundation
import UIKit

struct ArticleList: Decodable {
    let articles: [Article]?
}

struct Article: Decodable {
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
}

struct Payload: Decodable {
    let status: String
    let totalResults: Int?
}


class CategoryData {
    let title : String
    let image: UIImage
    
    init(title: String, image: UIImage){
        self.title = title
        self.image = image
    }
    
    
    
}
