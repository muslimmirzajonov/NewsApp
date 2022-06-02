//
//  ViewModel.swift
//  NewsApp
//
//  Created by muslim mirzajonov on 01/06/22.
//

import Foundation

class ArticleListViewModel {
    private var articles: [Article] = []
    private var totalArticles: Int = 0
    
}
extension ArticleListViewModel {
    convenience init(_ newArticles: [Article], totalArticles: Int) {
        self.init()
        articles.append(contentsOf: newArticles)
        self.totalArticles = totalArticles
    }
    
    var noOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
    
    func add(newArticles: [Article]) {
        articles.append(contentsOf: newArticles)
    }
    
    func totalNoOfArticles() -> Int {
        return self.totalArticles
    }
    
}
struct ArticleViewModel {
    private let article: Article
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
}
extension ArticleViewModel {
    var title: String {
        return article.title ?? ""
    }
    var description: String? {
        return article.description
    }
    var articleURL: String {
        return article.url ?? ""
    }
    var urlToImage: String {
        return article.urlToImage ?? ""
    }
}
