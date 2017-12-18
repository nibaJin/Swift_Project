//
//  ViewController.swift
//  JiuHuarSalesOrder
//
//  Created by jin fu on 2017/12/7.
//  Copyright © 2017年 jin fu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = FJHomeViewModel.init()
    
    var count = 0
    
    @IBOutlet weak var tableView: RefreshTableView!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.pullingDelegate = self
        tableView.r_contentInset = UIEdgeInsetsMake(navHeight, 0, 0, 0)
        tableView.haveMore = false
        
        activity.hidesWhenStopped = true
        activity.startAnimating()
        loadDataFromHead(true)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: PullRefreshDelegate {
    func loadDataFromHead(_ isHead: Bool) {
        if isHead {
            viewModel.page = 1
        }
        
        viewModel.fetchHomeData(completion: { (success,reachEnd) in
            self.activity.stopAnimating()
            if success {
                self.tableView.reloadData()
                self.tableView.haveMore = reachEnd
                self.tableView.endheaderRefresh()
                self.tableView.endFooterRefrsh()
            } else {
                self.tableView.endheaderRefresh()
                self.tableView.endFooterRefrsh()
                self.tableView.haveMore = reachEnd
            }
        })
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newestComments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FJExampleCell = tableView.dequeueReusableCell(withIdentifier: "FJExampleCell") as! FJExampleCell
        cell.model = viewModel.newestComments[indexPath.row] as? BeerModel
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
}
