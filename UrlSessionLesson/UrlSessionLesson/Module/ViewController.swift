//
//  ViewController.swift
//  UrlSessionLesson
//
//  Created by Константин Богданов on 06/11/2019.
//  Copyright © 2019 Константин Богданов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	let tableView = UITableView()
	var images: [ImageViewModel] = []
	let reuseId = "UITableViewCellreuseId"
	let interactor: InteractorInput
    let searchController = UISearchController(searchResultsController: nil)
    var second = Date().timeIntervalSince1970
    var count = 0
    var model : [ImageModel]?
    
    
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
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.resignFirstResponder()
        navigationItem.searchController = searchController
        navigationItem.title = "Flickr"
	}


	private func search(by searchString: String) {
        print(searchString)
		interactor.loadImageList(by: searchString) { [weak self] models in
            self?.model = models
            self?.loadImages(with: self!.model!, suffix: 0)
		}
	}

    private func loadImages(with models: [ImageModel], suffix: Int) {
		let models = models.suffix(30 + suffix)
		let group = DispatchGroup()
        for model in models {
            group.enter()
			interactor.loadImage(at: model.path) { [weak self] image in
				guard let image = image else {
					group.leave()
					return
				}
				let viewModel = ImageViewModel(description: model.description,
							image: image)
				self?.images.append(viewModel)
				group.leave()
                
			}
		}
        
		group.notify(queue: DispatchQueue.main) {
			self.tableView.reloadData()
		}
	}
}



// MARK: - UISearchResultsUpdating
extension ViewController: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
      
        if((Date().timeIntervalSince1970 - second) > 0.1) {
            self.search(by: searchController.searchBar.text!)
            
            images.removeAll()
            tableView.reloadData()
            second = Date().timeIntervalSince1970

        }
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return images.count
	}
    
    
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        guard !images.isEmpty else { return cell }
		let model = images[indexPath.row]
		cell.imageView?.image = model.image
		cell.textLabel?.text = model.description
        if(indexPath.row == (tableView.numberOfRows(inSection: 0)-1)) {
            loadImages(with: self.model!, suffix: 30)
        }
		return cell
    
	}
}
