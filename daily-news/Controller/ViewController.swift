//
//  ViewController.swift
//  daily-news
//
//  Created by gumball on 2/24/22.
//

import UIKit

class ViewController: UIViewController {
    
    var newsManager = NewsManager()
    
    @IBOutlet weak var searchValue: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.layer.cornerRadius = 10
    }

    @IBAction func doSearch(_ sender: UIButton) {
        if (searchValue.text == "") {
            searchButton.isEnabled = false
        } else {
            searchButton.isEnabled = true
            performSegue(withIdentifier: "NewsViewController", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsViewController" {
            let destinationVC = segue.destination as! NewsViewController
            destinationVC.item = searchValue.text!
        }
    }
   
}

