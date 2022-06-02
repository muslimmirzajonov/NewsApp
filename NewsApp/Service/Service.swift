//
//  Service.swift
//  NewsApp
//
//  Created by muslim mirzajonov on 01/06/22.
//

import Foundation

class WebService {
    let apiKey = "b18a5f797c9b415a8dffd864df0e8fe6"
    func getArticles(for urlString: String, with page: Int, completion: @escaping ([Article]?, Int) -> ()) {
        let newsURL = getNewsURL(for: urlString,with: page)
        if let url = URL(string: newsURL) {
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 100)
            URLSession.shared.dataTask(with: request)  { data, response, error in
                if let error = error {
                    print("Error in request: \(error.localizedDescription)")
                    completion(nil,0)
                } else if let data = data {
                    do {
                        let rainCheck = try JSONDecoder().decode(Payload.self, from: data)
                        let articleList = try JSONDecoder().decode(ArticleList.self, from: data)
                        completion(articleList.articles,rainCheck.totalResults ?? 0)
                    } catch {
                        print("Error in JSON decoding : \(String(describing: error))")
                        completion(nil,0)
                    }
                }
                print("Data task complete")
            }.resume()
        }
    }
}
// MARK: - Get URL for news items
extension WebService {
    func getNewsURL(for newsItem: String, with page: Int) -> String {
        var newsURL = String()
        let validatedNewsItem = newsItem.replacingOccurrences(of: " " , with: "-").lowercased()
        if validatedNewsItem.contains("q=") {
            newsURL = "https://newsapi.org/v2/everything?"+validatedNewsItem+"&sortBy=popularity&language=en&page="+String(page)+"&apiKey="+apiKey
        } else {
            newsURL = "https://newsapi.org/v2/top-headlines?"+validatedNewsItem+"&country=us&page="+String(page)+"&apiKey="+apiKey
        }
        print("News API URL : \(String(describing: newsURL))")
        return newsURL
    }
}
