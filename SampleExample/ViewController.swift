//
//  ViewController.swift
//  SampleExample
//
//  Created by imgadmin on 26/07/19.
//  Copyright © 2019 Wipro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    var tableData = ["Beach", "Clubs", "Chill", "Dance"]
    let data = [["0,0", "0,1", "0,2"], ["1,0", "1,1", "1,2"]]
    let headerTitles = ["Some Data 1", "Some Data 2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "my")
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView.contentInset.top = 20
        tableView.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)
        let contentSize = self.tableView.contentSize
        let footer = UIView(frame: CGRect(x: self.tableView.frame.origin.x,
                                          y: self.tableView.frame.origin.y + contentSize.height,
                                          width: self.tableView.frame.size.width,
                                          height: self.tableView.frame.height - self.tableView.contentSize.height))
        
        self.tableView.tableFooterView = footer
        
        
        view.addSubview(tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "my", for: indexPath)
        //cell.textLabel?.text = "This is row \(tableData[indexPath.row])"
        cell.textLabel?.text = "This is row \(data[indexPath.section][indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return tableData.count
        return data[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        showDialog(text: (currentCell.textLabel?.text)!)
    }
    
    func showDialog(text : String)
    {
        let alert = UIAlertController(title: "Alert", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeight: CGFloat = 80
        if scrollView.contentOffset.y <= sectionHeight {
            scrollView.contentInset = UIEdgeInsets( top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
        }
        else if scrollView.contentOffset.y >= sectionHeight {
            scrollView.contentInset = UIEdgeInsets(top: -sectionHeight, left: 0, bottom: 0, right: 0)
        }
        
    }
    
}
