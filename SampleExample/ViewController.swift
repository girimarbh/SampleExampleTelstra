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
    let cellId = "cellId"

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
        let currentLastItem = sampleviewmodel.datalist[indexPath.row]
        cell.updateContentOnCell(product: currentLastItem)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleviewmodel.datalist.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sampleviewmodel.headerTittle
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func updateContentOnView(){
        DispatchQueue.main.async{
            // and then dismiss the control
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
}
