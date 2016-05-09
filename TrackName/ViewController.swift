//
//  ViewController.swift
//  TrackName
//
//  Created by Vui Nguyen on 3/30/16.
//  Copyright © 2016 Sunfish Empire. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //var cellContent = ["Vui", "Eric", "Boulder", "Senna", "P-Dude"]
    var cellContent:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let url = NSURL(string:"https://itunes.apple.com/search?term=u2")!
        
        let session = NSURLSession.sharedSession()
        
        
        
        let task = session.dataTaskWithURL(url) { (data , response, error ) -> Void in
            if error != nil {
                print(error)
            }
            else {
                if let data = data {
                   // print(NSString(data: data, encoding: NSUTF8StringEncoding))
                    
                    
                    
                    do {
                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(data , options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        //print(jsonResult)
                        
                        if jsonResult.count > 0 {
                            
                            if let items = jsonResult["results"] as? NSArray {
                                
                                for result in items {
                                    let trackName: String = (result["trackName"] as? String)!
                                        print(trackName)
                                    self.cellContent.append(trackName)
                                    
                                    dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                                        self.tableView.reloadData()
                                    }
                                    
                              //self.tableView.reloadData()
                                }
                                
                            }
                        }

                    }
                    catch {
                        print("error reading JSON data")
                    }

                }
            }
        }
        task.resume()
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = cellContent[indexPath.row]
        
        return cell
    }
    
}

