//
//  TransactionHistory.swift
//  MyProject
//
//  Created by محمود محمد on 12/11/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import UIKit

class TransactionHistory: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var you_purchased_Label: UILabel!
    @IBOutlet weak var you_sold_Label: UILabel!
    @IBOutlet weak var you_earned_Label: UILabel!
    @IBOutlet weak var you_lost_Label: UILabel!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ViewHeightConstraint: NSLayoutConstraint!
    var coins = [Coin]()
    var youPurchased:String=""
    var youSold:String=""
    var youEarned:String=""
    var youLost:String=""

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        tableView.delegate = self
        tableView.dataSource = self

        //Creating a custom navigation bar..
        navigationBar.barTintColor = .white
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        var item = UINavigationItem(title: "Transaction History")
        item.prompt = "            "
        let img = UIImage(named: "BackButton")
        let barButton = UIBarButtonItem(image: img, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.backButtonPressed))
        navigationBar.tintColor = UIColor.init(hexString:"#9A9CB8")
        item.leftBarButtonItems = [barButton]
        navigationBar.setItems([item], animated: true)
        

    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
        @objc func backButtonPressed() {
        dismiss(animated: true, completion: nil)
        //        navigationController?.popViewController(animated: true)
        }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    
    //-----------------

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = Bundle.main.loadNibNamed("CustomTableViewCell", owner: self, options: nil)?.first as? CustomTableViewCell else {
            return UITableViewCell()
        }
        let Color = UIColor(hexString:"#F0F1F4")!
        cell.View_TableViewCell.backgroundColor = .init(Color)
        if(coins[indexPath.row].TitleCoin == "Bit Coin"){
            cell.Coins_ImageView.image=UIImage(named:"")
            cell.Coins_ImageView.image=#imageLiteral(resourceName: "Bit Coin")
        }else if(coins[indexPath.row].TitleCoin == "Ethereum"){
            cell.Coins_ImageView.image=UIImage(named:"")
            cell.Coins_ImageView.image=#imageLiteral(resourceName: "EthereumETH")
        }else{
            cell.Coins_ImageView.image=UIImage(named:"")
            cell.Coins_ImageView.image=#imageLiteral(resourceName: "EthereumBTC")
        }
        cell.TitleCoins_Label.text = coins[indexPath.row].TitleCoin
        cell.Date_Label.text = coins[indexPath.row].DateCoin
        cell.ValueCoins_Label.text = "₹ \(String(coins[indexPath.row].ValueCoin))"
        you_purchased_Label.text=youPurchased
        you_sold_Label.text=youSold
        you_earned_Label.text="₹\(youEarned)"
        you_lost_Label.text="₹\(youLost)"
        return cell
    }
}
