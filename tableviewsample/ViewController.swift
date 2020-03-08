//
//  ViewController.swift
//  tableviewsample
//
//  Created by hiwatt on 2020/03/08.
//  Copyright © 2020 hiwatt. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var TableViewMain: UITableView!
    
    var newsData : Array<Dictionary<String,Any>>?
    
    
    func getNews(){
        let urlstr = "https://newsapi.org/v2/top-headlines?country=kr&apiKey=d1bdf41741da4f9b92fc2316cbb90bd3"
        let task = URLSession.shared.dataTask(with:URL(string:urlstr)!) { (data, response, error) in
            if let datajson = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: datajson, options: []) as! Dictionary<String, Any>
                    print(json["articles"])
                    
                    let articles = json["articles"] as! Array<Dictionary<String,Any>>
                    
                    self.newsData = articles
                    
                    for (idx,value) in articles.enumerated(){
                        if let v = value as? Dictionary<String,Any>{
                            print("\(v["title"])")
                        }
                    }
                    DispatchQueue.main.async {
                        self.TableViewMain.reloadData()
                    }
                    
                }catch{}
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let news = newsData {
            return news.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell.init(style: .default, reuseIdentifier: "TableCellType1")
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        
        

        let idx = indexPath.row
        if let news = newsData {
            
            let row = news[idx]
            if let r = row as? Dictionary<String,Any>{
                
                if let title = r["title"] as? String{
                    //cell.textLabel?.text = title
                    cell.LabelText.text = title
                }
            }
            
        }else{
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICK \(indexPath.row)")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TableViewMain.delegate=self
        TableViewMain.dataSource=self
        getNews()
        
    }


}

