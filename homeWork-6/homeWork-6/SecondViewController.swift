//
//  SecondViewController.swift
//  homeWork-6
//
//  Created by Максим Жуков on 26/10/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit



class SecondViewController: UIViewController {
  
    let textLabel : UILabel = {
        let textLabel = UILabel()
        return textLabel
    }()
    
    let button : UIButton = {
       let button = UIButton()
        button.setTitle("PUSH", for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchDown)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    var cell = Cell()
    
    var textField = UITextField()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        let height = view.bounds.height
        let width = view.bounds.width
        
        textField = UITextField(frame: CGRect(origin: view.center, size: CGSize(width: 200, height: 40)))
        textField.center = CGPoint(x: width/2, y: height*0.75)
        textField.bounds.size.width = 200
        textField.bounds.size.height = 40
        textField.placeholder = "ENTER"
        textField.borderStyle = .roundedRect
        
        textLabel.frame = CGRect(x: 0, y: 100, width: width, height: 400)
        textLabel.numberOfLines = 0

        
        button.center = CGPoint(x: textField.center.x, y: textField.center.y + 60)
        button.bounds.size.width = 100
        button.bounds.size.height = 40
        button.layer.borderWidth = 1

        view.addSubview(textField)
        view.addSubview(textLabel)
        view.addSubview(button)
    }
    
    @objc func sendMessage() {
        let text = textField.text
        textLabel.text = text
        cell.textLabel?.text = text
    }
    
    
    
    deinit {
        print("deinit Second")
    }
}
