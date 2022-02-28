//
//  SearchManager.swift
//  daily-news
//
//  Created by gumball on 2/24/22.
//

import Foundation

protocol NewsManagerDelegate {
    func didUpdateNews(news: Array<New>?)
    func didFailWithError(error: Error)
}

struct NewsManager {
    
    var delegate: NewsManagerDelegate?
    
    let baseURL = "https://newsapi.org/v2/everything"
    let apiKey = "3971e0dbe3504e7da17260bfbaef6e67"
    
    
    func getNews(for item: String) {
        let urlString = "\(baseURL)?q=\(item)&sort?By=publishedAt&apiKey=\(apiKey)"
        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    print("error")
                    return
                } else {
                    if let responseText = String.init(data: data!, encoding: .ascii) {
                        print("1")
                        let jsonData = responseText.data(using: .utf8)!
                        print("2")
                        let news = try? JSONDecoder().decode(News.self, from: jsonData)
                        print("3")
                        self.delegate?.didUpdateNews(news: news?.articles)
                        print("4")
                        
                    }
                }
            }
            task.resume()
        }
    }
}
