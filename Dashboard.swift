//
//  Dashboard.swift
//  MyProject
//
//  Created by محمود محمد on 12/9/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import UIKit

class Dashboard: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate, UITableViewDataSource {
    
    
    
@IBOutlet weak var OnDashboard_View: UIView!
@IBOutlet weak var Main_View: UIView!
@IBOutlet var collectionView: UICollectionView!
@IBOutlet var scrollView: UIScrollView!
@IBOutlet weak var TrendingBit_View: UIView!
@IBOutlet weak var TransactionHistory_View: UIView!
@IBOutlet var tableView: UITableView!
    var coins = [Coin]()
    var youPurchased:String=""
    var youSold:String=""
    var youEarned:String=""
    var youLost:String=""
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        collectionView.delegate = self
        collectionView.dataSource = self
        //
        tableView.delegate = self
        tableView.dataSource = self
        //
        registerNibs()
        //
        requestNewCoins()
        //
        let Color_One = UIColor(hexString:"#5927FF")!
        let Color_Two = UIColor(hexString: "#8160EF")!
        OnDashboard_View.applyGradient(colours: [Color_Two, Color_One])
        //
        self.collectionView?.backgroundColor = UIColor.clear
        self.collectionView?.backgroundView = UIView(frame: CGRect.zero)
        
        
        
        //Radius
        TrendingBit_View.layer.cornerRadius = 8
        // shadow
        TrendingBit_View.layer.shadowColor = UIColor.black.cgColor
        TrendingBit_View.layer.shadowOffset = CGSize(width: 1, height: 1)
        TrendingBit_View.layer.shadowOpacity = 0.1
        TrendingBit_View.layer.shadowRadius = 4.0
        
        
        //Radius
        TransactionHistory_View.layer.cornerRadius = 8
        // shadow
        TransactionHistory_View.layer.shadowColor = UIColor.black.cgColor
        TransactionHistory_View.layer.shadowOffset = CGSize(width: 1, height: 1)
        TransactionHistory_View.layer.shadowOpacity = 0.1
        TransactionHistory_View.layer.shadowRadius = 4.0
        
       
        

    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    
    }
    @IBAction func ShowTransactionHistory(_ sender: Any){
        performSegue(withIdentifier: "ShowTransactionHistory", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowTransactionHistory"){
            let TransactionHistory=segue.destination as! TransactionHistory
            TransactionHistory.coins.removeAll()
            TransactionHistory.coins = coins
            TransactionHistory.youLost = youLost
            TransactionHistory.youSold = youSold
            TransactionHistory.youEarned = youEarned
            TransactionHistory.youPurchased = youPurchased
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        tableView.reloadData()
//
//    }
////    override func viewWillDisappear(_ animated: Bool) {
////        super.viewWillDisappear(animated)
////         self.navigationController?.setNavigationBarHidden(false, animated: animated)
////    }
//
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        
        // shadow
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 2.0
    
        if(indexPath.row == 0){
            cell.Circle_ImageView.image=UIImage(named:"")
            cell.Circle_ImageView.image=#imageLiteral(resourceName: "Bit Coin")
            cell.Title_Label.text="Bit Coin"
            cell.SubTitle_Label.text="BTC"
            cell.Value_Label.text="₹359,536.28"
            cell.VarValue_Label.text="-0.45"
            let Color_1 = UIColor(hexString:"#F45B7E")!
            cell.VarValue_Label.textColor = .init(Color_1)
            
        }else if(indexPath.row == 1){
            cell.Circle_ImageView.image=UIImage(named:"")
            cell.Circle_ImageView.image=#imageLiteral(resourceName: "EthereumETH")
            cell.Title_Label.text="Ethereum"
            cell.SubTitle_Label.text="ETH"
            cell.Value_Label.text="₹10,699.58"
            cell.VarValue_Label.text="+0.56"
            let Color_1 = UIColor(hexString:"#06B966")!
            cell.VarValue_Label.textColor = .init(Color_1)
            
        }else if(indexPath.row == 2){
            cell.Circle_ImageView.image=UIImage(named:"")
            cell.Circle_ImageView.image=#imageLiteral(resourceName: "EthereumBTC")
            cell.Title_Label.text="Ethereum"
            cell.SubTitle_Label.text="BTC"
            cell.Value_Label.text="₹10,699.58"
            cell.VarValue_Label.text="+0.56"
            let Color_1 = UIColor(hexString:"#06B966")!
            cell.VarValue_Label.textColor = .init(Color_1)
        }
       
        //cell.cellNumber.text = "\(dataCount[indexPath.row])"
        return cell
    }
  
    func registerNibs(){
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        let nibId = "customCell"
        collectionView.register(nib, forCellWithReuseIdentifier: nibId)
    }
 //-----------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = Bundle.main.loadNibNamed("CustomTableViewCell", owner: self, options: nil)?.first as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
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
        return cell
    }
    
   
    func requestNewCoins() {
        
        let session = URLSession.shared
        guard let url = URL(string: "https://scadagame.com/bitCuckoo") else {
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            do {
                // Parse the data
                guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] else {
                    return
                }
                let x = json["result"] as! [String:Any]
                let you_purchased = (x["you_purchased"] as! NSString).doubleValue
                let you_sold = (x["you_sold"] as! NSString).doubleValue
                let you_earned = (x["you_earned"] as! NSString).doubleValue
                let you_lost = (x["you_lost"] as! NSString).doubleValue
                let transactions = x["transactions"] as! [[String : Any]]
                
                self.youPurchased=String(you_purchased)
                self.youSold=String(you_sold)
                self.youEarned=String(you_earned)
                self.youLost=String(you_lost)
                
                for a in transactions {
                    
                    self.coins.append(Coin(TitleCoin: a["title"]! as! String, DateCoin: a["date"]! as! String, ValueCoin: a["price"]! as! Int))
                }
                
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
        
    }
  
    

    
}
