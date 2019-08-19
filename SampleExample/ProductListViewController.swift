//
//  ViewController.swift
//  Sample_TableView
//
//  Created by imgadmin on 25/07/19.
//  Copyright © 2019 Wipro. All rights reserved.
//

import UIKit

class ProductListViewController: UITableViewController,NotificationProtocal {
    
    internal let refreshcontrol : UIRefreshControl = {
        let rc = UIRefreshControl()
        let title = NSLocalizedString(pullToRefresh, comment: pullToRefresh)
        rc.attributedTitle = NSAttributedString(string: title)
        rc.addTarget(self, action: #selector(refreshOptions(sender:)), for: UIControl.Event.valueChanged)
        return rc
    }()
    
    var productviewmodel = ProductViewModel()
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshcontrol)
        }

        //
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        //
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)
        tableView.allowsSelection = false
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

    }
    override func viewWillAppear(_ animated: Bool) {
        //For
        retrieveAPIData()
    }
    
    @objc private func refreshOptions(sender: UIRefreshControl) {
        // Perform actions to refresh the content
        retrieveAPIData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Funtion to retrieveAPIData
    private func retrieveAPIData() {
        if ReachabilityTest.isConnectedToNetwork() {
            productviewmodel.delegate = self
            productviewmodel.fetchData();
            
            //Calling Viewmodel class to fetchdata
        }
        else{
           let alert = UIAlertController(title: internetConnection, message: noInternetAvailable , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: cancel , style: .cancel, handler: {[weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.refreshcontrol.endRefreshing()
            }))
            self.present(alert, animated: true, completion: nil)
            self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        }
     
    }
    
}

extension ProductListViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductCell
        let currentLastItem = productviewmodel.datalist[indexPath.row]
        cell.updateContentOnCell(product: currentLastItem)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productviewmodel.datalist.count
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return productviewmodel.headerTittle
//    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func updateContentOnView(){
        DispatchQueue.main.async{ [weak self] in
            guard let weakSelf = self else { return }
            // and then dismiss the control
            weakSelf.refreshControl?.endRefreshing()
            weakSelf.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            weakSelf.tableView.reloadData()
            self?.navigationItem.title = self?.productviewmodel.headerTittle
        }
    }
    func updateError()
    {
        let alert = UIAlertController(title: secureError, message: noData , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: {[weak self] _ in
            guard let weakSelf = self else { return }
            weakSelf.refreshcontrol.endRefreshing()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
