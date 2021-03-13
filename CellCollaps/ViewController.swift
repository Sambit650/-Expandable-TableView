//
//  ViewController.swift
//  CellCollaps
//
//  Created by Sambit Das on 12/03/21.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayHeader = [1,1,1,1]
    var data = [
        ["Apple", "Watermelon", "Orange", "Pear", "Cherry", "Strawberry", "Nectarine", "Mango", "Blueberry", "Pomegranate"],
        ["Tomato", "Potato", "Carrot", "Beet","Onion"],
        ["iPhone", "Samsung", "mi", "OnePlus", "Realme", "MicroMax"],
        ["Bangalore", "Hydrabad", "Bhubaneswar", "Chennai", "Mumbai"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
    }
    
    @objc func tapSection(sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        self.arrayHeader[tag] = (self.arrayHeader[tag] == 0) ? 1 : 0
        self.tableView.reloadSections([tag], with: .fade)
    }
    
}

extension ViewController:  UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Change the number of row in section as per your uses
        return (self.arrayHeader[section] == 0) ? 0 : data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollapsTableViewCell", for: indexPath) as! CollapsTableViewCell
        cell.label.text = data[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView") as! CustomHeaderView
        headerView.backgroundColor = UIColor.darkGray
        headerView.headerLabel.text = "\(section) Section"
        headerView.headerButton.setImage(UIImage(systemName: "plus.app"), for: .normal) //minus.square
        headerView.tag = section
        let tabAction = UITapGestureRecognizer(target: self, action:  #selector(tapSection(sender:)))
        headerView.addGestureRecognizer(tabAction)
        tabAction.delegate = self
        return headerView
    }
    
}

