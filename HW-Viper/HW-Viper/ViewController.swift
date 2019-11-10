//
//  ViewController.swift
//  HW-Viper
//
//  Created by Максим Жуков on 10/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PresenterOutput {
    
    var presenter : PresenterInput?
    var configurator = Configurator()
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 200)
        imageView.bounds.size = CGSize(width: 300, height: 300)
        imageView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return imageView
    }()
    
    lazy var show : UIButton = {
        let show = UIButton()
        show.frame.size = CGSize(width: 200, height: 30)
        show.center = CGPoint(x: self.imageView.center.x, y: self.imageView.center.y +  self.imageView.bounds.height/2 + 10.0 + show.bounds.width/2)
        show.addTarget(self, action: #selector(showImageButton), for: .touchDown)
        show.setTitle("Отобразить", for: .normal)
        show.setTitleColor(.black, for: .normal)
        return show
    }()
    
   lazy var download : UIButton = {
        let download = UIButton()
        download.frame.size = CGSize(width: 200, height: 30)
        download.center = CGPoint(x: self.show.center.x, y: self.show.center.y +  self.show.bounds.height/2 + 10.0 + show.bounds.width/2)
        download.addTarget(self, action: #selector(downloadButton), for: .touchDown)
        download.setTitle("Скачать", for: .normal)
        download.setTitleColor(.black, for: .normal)
        return download
    }()
    
    lazy var clearCash : UIButton = {
        let clearCash = UIButton()
        clearCash.frame.size = CGSize(width: 200, height: 30)
        clearCash.center = CGPoint(x: self.download.center.x, y: self.download.center.y +  self.download.bounds.height/2 + 10.0 + download.bounds.width/2)
        clearCash.addTarget(self, action: #selector(clearCashButton), for: .touchDown)
        clearCash.setTitle("Очистить кэш", for: .normal)
        clearCash.setTitleColor(.black, for: .normal)
        return clearCash
    }()
    
    func showAlertView(withTitle title:String, andText text: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                
            })
            self.present(alertController, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(show)
        view.addSubview(download)
        view.addSubview(clearCash)
        view.addSubview(imageView)
        configurator.conf(view: self)
    }
    
    @objc func showImageButton() {
        presenter?.getImageFromCash()
    }

    
    @objc func downloadButton() {
        presenter?.getImageFromNetwork()
    }
    
    @objc func clearCashButton() {
        presenter?.clearCash()
    }
    
    func showImage(with image: UIImage?) {
        imageView.image = image
    }
}

