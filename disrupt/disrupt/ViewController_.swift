//
//  ViewController.swift
//  UITest
//
//  Created by Annette Chen on 6/8/17.
//  Copyright © 2017 Annette Chen. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController_: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var api = GetBusinesses()
    var dealList: [DealModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.api.getInfoFromAPI { [unowned self] data in
            print("Retrieving deals")
            self.dealList = self.api.dealList
            print(self.dealList[0].storename)
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as!TableViewCell
        
        if (indexPath.row < self.dealList.count) {
            let dealModel = self.dealList[indexPath.row]
            cell.storeName.text = dealModel.storename
            cell.deal.text = dealModel.deal
        }
        //let dealModel = self.dealList[indexPath.row]
        //cell.storeName.text = dealModel.storename
        //cell.deal.text = dealModel.deal
        
        return cell
        
        /*let newCell = collectionView.dequeueReusableCellWithReuseIdentifier("PokedexCell", forIndexPath: indexPath) as! PokedexCollectionViewCell
        let pokemonModel = filteredData[indexPath.row]
        newCell.nameLabel.text = pokemonModel.name.capitalizedString
        newCell.backgroundColor = UIColor.whiteColor()
        return newCell*/
    }
    
    


}

