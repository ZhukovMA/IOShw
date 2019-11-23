//
//  ViewController.swift
//  UrlSessionLesson
//
//  Created by Максим Жуков on 23/11/2019.
//  Copyright © 2019 Константин Богданов. All rights reserved.
//

import UIKit



class DetailViewController: UIViewController {
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height)
    
        return imageView
    }()
    
    var image : UIImage?
    convenience init() {
        self.init(for: nil)
        
    }
    
    init(for image:UIImage?) {
        super.init(nibName: nil, bundle: nil)
        self.image = image!
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        view.addSubview(imageView)
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
