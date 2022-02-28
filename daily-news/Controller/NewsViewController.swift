//
//  NewsViewController.swift
//  daily-news
//
//  Created by gumball on 2/25/22.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var newsManager = NewsManager()
    var news: News?
    var item: String!
    
    override func viewWillAppear(_ animated: Bool) {
        getNews(for: item!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        self.newsTableView.rowHeight = 300

    }
    
    let baseURL = "https://gnews.io/api/v4/search"
    let apiKey = "2f46c0093bc89ab397facb6e0c5049b0"
    
    
    func getNews(for item: String) {
        let urlString = "\(baseURL)?lang=en&q=\(item)&token=\(apiKey)"
        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("error")
                    return
                } else {
                    if let responseText = String.init(data: data!, encoding: .ascii) {
                        print("1")
                        let jsonData = responseText.data(using: .utf8)!
                        print("2")
                        self.news = try! JSONDecoder().decode(News.self, from: jsonData)
                        print("3")
                        DispatchQueue.main.async {
                            self.newsTableView.reloadData()
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NewsTableViewCell
        
        if(news != nil) {
            let url = URL(string: (news?.articles[indexPath.row].image)!)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    cell.newsImage.image = UIImage(data: data!)
                }
            }
            cell.newsTitle.text = (news?.articles[indexPath.row].title)!
            
            var dateOfNews: String!
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "yyyy-MM-dd HH:mm"

            if let date = dateFormatterGet.date(from: (news?.articles[indexPath.row].publishedAt)!) {
                dateOfNews = dateFormatterPrint.string(from: date)
            } else {
               print("There was an error decoding the string")
            }

            cell.newsDate.text = dateOfNews
        }
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ArticleViewController", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsVC = segue.destination as! ArticleViewController
        let selectedRow = newsTableView.indexPathForSelectedRow!.row
        detailsVC.articleImage = (news?.articles[selectedRow].image)!
        detailsVC.articleTitle = (news?.articles[selectedRow].title)!
        detailsVC.author = (news?.articles[selectedRow].source.name)!
        detailsVC.content = (news?.articles[selectedRow].content)!
        detailsVC.date = (news?.articles[selectedRow].publishedAt)!
    }
    @IBAction func backButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newsVC = storyboard.instantiateViewController(identifier: "ViewController")
                
        newsVC.modalPresentationStyle = .fullScreen
        newsVC.modalTransitionStyle = .crossDissolve
                
        present(newsVC, animated: true, completion: nil)
    }
}




