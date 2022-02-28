//
//  ArticleViewController.swift
//  daily-news
//
//  Created by gumball on 2/28/22.
//

import UIKit

class ArticleViewController: UIViewController {
    
    var articleImage: String!
    var articleTitle: String!
    var author: String!
    var content: String!
    var date: String!

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mainAuthor: UILabel!
    @IBOutlet weak var mainContent: UITextView!
    @IBOutlet weak var mainDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: articleImage)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.mainImage.image = UIImage(data: data!)
            }
        }
        self.mainTitle.text = articleTitle
        self.mainAuthor.text = author
        self.mainContent.text = content
        
        var dateOfNews: String!
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let date = dateFormatterGet.date(from: date) {
            dateOfNews = dateFormatterPrint.string(from: date)
        } else {
           print("There was an error decoding the string")
        }
        self.mainDate.text = dateOfNews
        

    }

}
