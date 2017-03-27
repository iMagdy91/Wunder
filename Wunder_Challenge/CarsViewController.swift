//
//  CarsViewController.swift
//  Wunder_Challenge
//
//  Created by Mohamed Magdy on 3/26/17.
//  Copyright © 2017 Mohamed Magdy. All rights reserved.
//

import UIKit
import MBProgressHUD

fileprivate let cellHeight: CGFloat = 65.0

class CarsViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Properties
    private var cars:[CarViewModel]?
    private var refreshControl: UIRefreshControl!
    
    //MARK:- View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        getCars()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Private Methods
    @objc private func getCars() {
        MBProgressHUD.showAdded(to: view, animated: true)
        CarStore.getCarsList(successBlock: { [weak self](model) in
            guard let weakSelf = self else {return}
            MBProgressHUD.hide(for: weakSelf.view, animated: true)
            weakSelf.cars = model as? [CarViewModel]
            weakSelf.refreshControl.endRefreshing()
            weakSelf.tableView.reloadData()
            
        }) { [weak self](error) in
            self?.handleError(error: error)
            self?.refreshControl.endRefreshing()
        }
    }
    private func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(getCars), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    //MARK:- UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CarCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CarTableViewCell
        
        if cell == nil {
            cell = CarTableViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        cell?.customizeCell(withModel: cars?[indexPath.row])
        
        if indexPath.row % 2 == 0 {
            cell?.backgroundColor = UIColor.lightGray
        }
        else {
            cell?.backgroundColor = UIColor.white
        }
        cell?.selectionStyle = .none
        
        return cell!
    }
    //MARK:- UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    
    
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        if segue.identifier == Segue.mapSegue {
            if let mapViewController = segue.destination as? CarMapViewController {
                mapViewController.cars = cars
            }
        }
        
     }
    
    
}
