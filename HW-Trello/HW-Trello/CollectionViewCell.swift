//
//  CollectionViewCell.swift
//  HW-Trello
//
//  Created by Максим Жуков on 05/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit
import MobileCoreServices

class ModelCollectionViewCell:  UICollectionViewCell {
    let button : UIButton = {
        let button = UIButton()
        button.setTitle("Add Card", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9371759295, green: 0.9373072386, blue: 0.9371345043, alpha: 1)
        return button
    }()
    
    var tableView = UITableView.init(frame: .zero, style: UITableView.Style.plain)
    
    var model: Model?
    weak var parentVC: ViewController?
    
    
    func setup(with model: Model) {
        self.model = model
        tableView.reloadData()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
        tableView.frame = CGRect.init(origin: .zero, size: contentView.frame.size)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = CGRect(x: 0, y: 40, width: self.frame.width, height: self.frame.height - 50)
        tableView.tableFooterView = UIView()
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.sectionHeaderHeight =  45
        //
        button.frame = CGRect(x: 0, y: contentView.frame.height-45, width: contentView.frame.width, height: 45)
        button.addTarget(self, action: #selector(addTapped), for: .touchDown)
        
        contentView.addSubview(tableView)
        contentView.addSubview(button)
    }
    
    
    
    @objc func addTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Item", message: nil, preferredStyle:  .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else {
                return
            }
            
            guard let data = self.model else {
                return
            }
            
            data.items.append(text)
            let addedIndexPath = IndexPath(item: data.items.count - 1, section: 0)
            
            self.tableView.insertRows(at: [addedIndexPath], with: .automatic)
            self.tableView.scrollToRow(at: addedIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
}




extension ModelCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model?.title
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = "\(model!.items[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


extension ModelCollectionViewCell: UITableViewDropDelegate, UITableViewDragDelegate{
    
    //  MARK:- UITableViewDragDelegate
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let modell = model
        let stringData = modell!.items[indexPath.row].data(using: .utf8)
        let dragItem = UIDragItem(itemProvider: NSItemProvider(item: stringData as! NSData, typeIdentifier: kUTTypePlainText as String))
        session.localContext = (model, indexPath, tableView)
        return [dragItem]
    }
    
    //  MARK:- UITableViewDropDelegate
    //Этот метод будет вызван, когда пользователь поднимет палец от экрана.
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        coordinator.session.loadObjects(ofClass: NSString.self) { (items) in
            let string = items.first as! String
            
            if let destinationIndexPath =  coordinator.destinationIndexPath {
                self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
                self.tableView.beginUpdates()
                self.model?.items.insert(string, at: destinationIndexPath.row)
                self.tableView.insertRows(at: [destinationIndexPath], with: .automatic)
                self.tableView.endUpdates()
            } else {
                self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
                self.tableView.beginUpdates()
                self.model?.items.append(string)
                self.tableView.insertRows(at: [IndexPath(row: self.model!.items.count - 1 , section: 0)], with: .automatic)
                self.tableView.endUpdates()
            }
        }
    }
    
    func removeSourceTableData(localContext: Any?) {
        if let (dataSource, sourceIndexPath, tableView) = localContext as? (Model, IndexPath, UITableView) {
            tableView.beginUpdates()
            dataSource.items.remove(at: sourceIndexPath.row)
            tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    // Запускается первым. Этот метод сообщает системе, как мы хотим использовать данные drop элемента через UITableViewDropProposal в указанном indexPath, когда пользователь перетаскивает элемент. UITableViewDropProposal - это обработчика drop.
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
}
