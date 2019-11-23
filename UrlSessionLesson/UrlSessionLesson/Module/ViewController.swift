//
//  ViewController.swift
//  UrlSessionLesson
//
//  Created by Константин Богданов on 06/11/2019.
//  Copyright © 2019 Константин Богданов. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let tableView = UITableView()
    var images: [Image] = []
    let reuseId = "UITableViewCellreuseId"
    let interactor: InteractorInput
    let searchController = UISearchController(searchResultsController: nil)
    var second = Date().timeIntervalSince1970
    lazy var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        activityIndicator.bounds.size = CGSize(width: 1000, height: 1000 )
        activityIndicator.center = view.center
        return activityIndicator
    }()
    
    init(interactor: InteractorInput) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Метод не реализован")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.resignFirstResponder()
        searchController.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.title = "Flickr"
        view.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Image> = Image.fetchRequest()
        do {
           images = try context.fetch(fetchRequest)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    private func search(by searchString: String) {
        activityIndicator.startAnimating()
        print(searchString)
        interactor.loadImageList(by: searchString) { [weak self] models in
            self?.loadImages(with: models)
        }
    }

    
    private func loadImages(with models: [ImageModel]) {
        let group = DispatchGroup()
        for model in models {
            group.enter()
            interactor.loadImage(at: model.path) { [weak self] image in
                guard let image = image else {
                    group.leave()
                    return
                }
                DispatchQueue.main.sync {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                    let entity = NSEntityDescription.entity(forEntityName: "Image", in: context)
                    let imageObject = NSManagedObject(entity: entity!, insertInto: context) as! Image
                    imageObject.image = image
                    do {
                        try context.save()
                        self!.images.append(imageObject)
                        print("Saved succes")
                    } catch  {
                        print(error.localizedDescription)
                    }

                }
               
                group.leave()
                
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func deleteAllData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Image> = Image.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
            images.removeAll()
            tableView.reloadData()
            try! context.save()
        } catch  {
            print(error.localizedDescription)
        }
    }
}



// MARK: - UISearchResultsUpdating
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        deleteAllData()
        self.search(by: searchController.searchBar.text!)
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailViewController(for: tableView.cellForRow(at: indexPath)?.imageView?.image), animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        let model = images[indexPath.row]
        cell.imageView?.image = UIImage(data: model.image!)
        return cell
        
    }
}
