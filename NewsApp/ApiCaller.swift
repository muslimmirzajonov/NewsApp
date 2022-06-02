////
////  ApiCaller.swift
////  NewsApp
////
////  Created by muslim mirzajonov on 01/06/22.
////
//
//import Foundation
//
//final class APICaller{
//    static let shared = APICaller()
//    
//    struct Constants{
//        static let topHeadLinesURL = URL(string:
//            "https://newsapi.org/v2/top-headlines?country=US&apiKey=a5908882f02a4f85bc1721a1befb8416")
//        static let searchUrlString =
//            "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=a5908882f02a4f85bc1721a1befb8416&q="
//        
//    }
//    
//    private init(){}
//    
//    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void){
//        guard let url = Constants.topHeadLinesURL else{
//            return
//        }
//        let task = URLSession.shared.dataTask(with: url) {data, _, error in
//            if let error = error {
//                completion(.failure(error))
//            }
//            else if let data = data{
//                do{
//                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
//                    print("Articles: \(result.articles!.count)")
//                    completion(.success(result.articles!))
//                }
//                catch{
//                    completion(.failure(error))
//                }
//            }
//        }
//        task.resume() 
//    }
//    
//    public func search(with query: String, completion: @escaping (Result<[Article], Error>) -> Void){
//        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
//            return
//        }
//        
//        let urlString = Constants.searchUrlString + query
//        guard let url = URL(string: urlString) else {
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) {data, _, error in
//            if let error = error {
//                completion(.failure(error))
//            }
//            else if let data = data{
//                do{
//                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
//                    print("Articles: \(result.articles!.count)")
//                    completion(.success(result.articles!))
//                }
//                catch{
//                    completion(.failure(error))
//                }
//            }
//        }
//        task.resume()
//    }
//}
//
//
//
//struct APIResponse: Codable{
//    let articles: [Article]?
//    let totalResults: Int
//}
//
//struct Article: Codable{
//    let source: Source?
//    let title: String?
//    let description: String?
//    let url: String?
//    let urlToImage: String?
//    let publishedAt: String?
//}
//struct Source: Codable{
//    let name: String
//}
