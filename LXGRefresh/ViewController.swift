//
//  ViewController.swift
//  LXGRefresh
//
//  Created by 黎曦光 on 2018/4/16.
//  Copyright © 2018年 dawn_lxg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: -
    // MARK: Vars
    
    fileprivate var tableView: UITableView!
    
    // MARK: -
    
    var dataSource : [Int]!{
        didSet {
            
            tableView?.reloadData()
        }
        
    }
    
    
    override func loadView() {
        super.loadView()
        
        let initialData = [1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9]
        
        dataSource = initialData
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.blue
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.separatorColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 231/255.0, alpha: 1.0)
        tableView.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 251/255.0, alpha: 1.0)
        view.addSubview(tableView)
        //Mark  change loadingViewType
//      tableView.loadingviewType = LXGRrfreshConstants.loadingType.Circle
        tableView.tableFooterView = UIView()
        
        
        tableView.lxg_addRefreshWithActionHandle(true, headerActionHandle: {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                self.dataSource = initialData
                self.tableView.lxg_stopLoading()
                
            })
            
            
        }, footerIsOpen: true) {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                var appendSource : [Int] = []
                if let lastnum = self.dataSource.last {
                    
                    for num in 1...9{
                        let newnum = num + lastnum
                        appendSource.append(newnum)
                    }
                    
                   
                    
                }
                if appendSource.count != 0{
                    
                    self.dataSource = self.dataSource + appendSource
                }
                
                
                self.tableView.lxg_stopLoading()
            })
        }
        
        
    }
    
    
    
    deinit {
        
        tableView.lxg_removeRefresh()
    }
    
    
}
// MARK: -
// MARK: UITableView Data Source

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            cell!.contentView.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 251/255.0, alpha: 1.0)
        }
        
        if let cell = cell {
            
            
            cell.textLabel?.text = "\((indexPath as NSIndexPath).row)"
            return cell
            
            
            
        }
        
        return UITableViewCell()
    }
    
}

// MARK: -
// MARK: UITableView Delegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

