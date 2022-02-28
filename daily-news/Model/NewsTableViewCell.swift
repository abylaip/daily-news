//
//  NewsTableViewCell.swift
//  daily-news
//
//  Created by gumball on 2/25/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.newsImage.layer.cornerRadius = 10
        self.newsImage.layer.shadowOffset = CGSize(width: 5,
                                          height: 5)
        self.newsImage.layer.shadowRadius = 5
        self.newsImage.layer.shadowOpacity = 1
        
        self.newsImage.image = UIImage(named: "placeholder")
        self.newsTitle.text = "Loading..."
        self.newsDate.text = "Loading..."
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
