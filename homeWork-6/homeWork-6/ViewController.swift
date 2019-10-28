//
//  ViewController.swift
//  homeWork-6
//
//  Created by Максим Жуков on 24/10/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    
    let arrays = [["Sign to your Iphone"], ["Genetal", "Privacy"], ["Passwords & Accounts"], ["Maps", "Safari", "News", "Siri", "Photos", "Game Center"]]
    let images = [["person"], ["general", "privacy"] , ["password"], ["maps", "siri", "photos", "game", "safari", "news"]]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrays.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arrays[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.textLabel?.numberOfLines = 0;
        var targetSize = CGSize(width: 30, height: 30)
        if(indexPath.section == 0) {
            targetSize = CGSize(width: 80, height: 80)
            cell.detailTextLabel?.text = "Set up ICloud, the App Store, and more."
            cell.detailTextLabel?.textColor = .gray
            cell.textLabel?.textColor = .blue
        }
        
        cell.imageView?.image = cell.resizeImage(image: UIImage(named: images[indexPath.section][indexPath.row])!,
                                                 targetSize: targetSize)
        cell.textLabel?.text = arrays[indexPath.section][indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animation = CATransition()
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        navigationController?.view.layer.add(animation, forKey: "transition")
        
        let secondViewController = SecondViewController()
        secondViewController.cell = tableView.cellForRow(at: indexPath)! as! Cell
        
        navigationController?.pushViewController(secondViewController, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = CGRect.init(origin: .zero, size: view.frame.size)
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
    }
    
    deinit {
        print("deinit ROOT")
    }
}



