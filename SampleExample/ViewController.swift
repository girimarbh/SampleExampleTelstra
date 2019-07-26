//
//  ViewController.swift
//  Sample_TableView
//
//  Created by imgadmin on 25/07/19.
//  Copyright © 2019 Wipro. All rights reserved.
//

import UIKit



class ViewController: UITableViewController,NotificationProtocal {
    
    internal let refreshdata : UIRefreshControl = {
        let rc = UIRefreshControl()
        let title = NSLocalizedString("PullToRefresh", comment: "Pull to refresh")
        rc.attributedTitle = NSAttributedString(string: title)
        rc.addTarget(self, action: #selector(refreshOptions(sender:)), for: UIControl.Event.valueChanged)
        return rc
    }()
    
    var sampleviewmodel = SampleViewModel()
    
    let baseURL: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    let cellId = "cellId"
    var products : [Product]  = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshdata
        } else {
            tableView.addSubview(refreshdata)
        }
        
       
        
        //
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        //
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)
        
        //For
        retrieveAPIData()
        
    }
    
    @objc private func refreshOptions(sender: UIRefreshControl) {
        // Perform actions to refresh the content
        self.retrieveAPIData()
        // and then dismiss the control
        sender.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func retrieveAPIData() {
        sampleviewmodel.delegate = self
        sampleviewmodel.fetchData();
    }
    
}

extension ViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductCell
        let currentLastItem = products[indexPath.row]
        cell.product = currentLastItem
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func updateContentOnView(){
        DispatchQueue.main.async{
            self.products = self.sampleviewmodel.datalist
            self.tableView.reloadData()
        }
    }
}
