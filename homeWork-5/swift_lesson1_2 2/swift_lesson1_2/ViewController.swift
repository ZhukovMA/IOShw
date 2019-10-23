//
//  ViewController.swift
//  swift_lesson1_2
//
//  Created by 16817252 on 14/10/2019.
//  Copyright © 2019 16817252. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var picture : UIImageView = {
        let imagee = UIImage(named: "heart")
        let imageView = UIImageView(image: imagee)
        return imageView
    }()
    
    
	var timer : Timer?
    
    @objc func showLove() {
        let height = view.frame.size.height
        let width = view.frame.size.width
        
        let heightToInt : Int = Int(ceil(view.frame.size.height))
        let widthToInt : Int = Int(ceil(view.frame.size.width))
        
        let xRandom = Int.random(in: 0 ... widthToInt)
        let yRandom = Int.random(in: heightToInt/3 ... Int(Double(heightToInt)*0.8))
        
        picture.frame = CGRect(x: width/2, y: height, width: 300, height: 300)
        
        let animationsGroup = CAAnimationGroup()
        animationsGroup.animations = [CABasicAnimation]()
        
        let animation1 = CABasicAnimation(keyPath: "position")
        animation1.fromValue = [width/2, height]
        animation1.toValue = [xRandom,yRandom]
        animation1.duration = 1.0
        animation1.beginTime = 0.0
        animationsGroup.animations?.append(animation1)
        
        let animation2 = CABasicAnimation(keyPath: "transform.scale")
        animation2.fromValue = 0.05
        animation2.toValue = 0.5
        animation2.beginTime = animation1.beginTime
        animation2.duration = 1.0
        animationsGroup.animations?.append(animation2)
        
        let animation3 = CABasicAnimation(keyPath: "opacity")
        animation3.fromValue = 1
        animation3.toValue = 0
        animation3.beginTime = animation1.beginTime
        animation3.duration = 1.0
        animationsGroup.animations?.append(animation3)
        
        animationsGroup.duration = 1.0
        picture.layer.add(animationsGroup, forKey: "max")
        view.addSubview(picture)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = UIColor.cyan
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                                     target: self,
                                                     selector: #selector(showLove),
                                                     userInfo: nil,
                                                     repeats: true)
        }
        
        //        view.addSubview(button)
        //        view.addSubview(button2)
        //        view.addSubview(button3)
        //        view.addSubview(button4)
        //
        //        view.addSubview(button5)
    }
    
//    let button : UIButton = {
//        let button = UIButton(type: .custom)
//        button.setTitle("Назад", for: .normal)
//        button.backgroundColor = UIColor.white
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.addTarget(self, action:  #selector(tapButton), for:.touchDown)
//        button.frame = CGRect(x: 25.0, y: 100.0, width: 100.0, height: 40.0)
//        return button
//    }()
//    //----------------------------------------------------------------------------------------------------
//
//    let button2 : UIButton = {
//        let button = UIButton(type: .custom)
//        button.setTitle("Запуск анимации", for: .normal)
//        button.backgroundColor = UIColor.white
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.addTarget(self, action:  #selector(tapButton2), for:.touchDown)
//        button.frame = CGRect(x: 25.0, y: 150.0, width: 150.0, height: 40.0)
//        return button
//    }()
//
//    @objc func tapButton2 () {
//        createTimer()
//    }
//
//    @objc func updateTimer () {
//        let x = button.frame.origin.x + 20.0
//        button.frame = CGRect(x: x, y: 100.0, width: 100.0, height: 40.0)
//        //        print(timer?.description)
//    }
//
//    @objc func createTimer()
//    {
//        if timer == nil {
//            timer = Timer.scheduledTimer(timeInterval: 1.0,
//                                         target: self,
//                                         selector: #selector(updateTimer),
//                                         userInfo: nil,
//                                         repeats: true)
//        }
//    }
//
//    //----------------------------------------------------------------------------------------------------
//
//
//    let button3 : UIButton = {
//        let button = UIButton(type: .custom)
//        button.setTitle("CABasicAnimation", for: .normal)
//        button.backgroundColor = UIColor.white
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.addTarget(self, action:  #selector(tapButton3), for:.touchDown)
//        button.frame = CGRect(x: 25.0, y: 200.0, width: 150.0, height: 40.0)
//        return button
//    }()
//
//    @objc func tapButton3 () {
//        button.layer.removeAllAnimations()
//        button.layer.removeAnimation(forKey: "nika")
//
//        let theAnimation = CABasicAnimation(keyPath: "opacity")
//        theAnimation.fromValue = 1.0
//        theAnimation.toValue = 0.0
//        theAnimation.duration = 3.0
//        theAnimation.autoreverses = true
//        //true - возвращает в исходное значение либо плавно, либо нет
//        theAnimation.repeatCount = 1
//
//        let theAnimation2 = CABasicAnimation(keyPath: "position")
//        theAnimation2.fromValue = [0, 0]
//        theAnimation2.toValue = [100, 100]
//        theAnimation2.duration = 3.0
//
//        let animation = CABasicAnimation(keyPath: "backgroundColor")
//        animation.fromValue = UIColor.red.cgColor
//        animation.toValue = UIColor.blue.cgColor
//        animation.duration = 3.0
//
//        button.layer.add(theAnimation, forKey: "nika")
//        //        button.layer.add(theAnimation2, forKey: "nika2")
//        //        button.layer.add(animation, forKey: "nika3")
//    }
//
//
//
//    //----------------------------------------------------------------------------------------------------
//
//    let button4 : UIButton = {
//        let button = UIButton(type: .custom)
//        button.setTitle("CAKeyframeAnimation", for: .normal)
//        button.backgroundColor = UIColor.white
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.addTarget(self, action:  #selector(tapButton4), for:.touchDown)
//        button.frame = CGRect(x: 25.0, y: 250.0, width: 150.0, height: 40.0)
//        return button
//    }()
//
//    @objc func tapButton4 () {
//        let animation = CAKeyframeAnimation(keyPath: "position")
//        let pathArray = [[10, 10], [100, 100], [10, 100], [10, 10]]
//        animation.values = pathArray
//        animation.duration = 5.0
//        button.layer.add(animation, forKey: "position2")
//    }
//    //----------------------------------------------------------------------------------------------------

//    let button5 : UIButton = {
//        let button = UIButton(type: .custom)
//        button.setTitle("CAAnimationGroup", for: .normal)
//        button.backgroundColor = UIColor.white
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.addTarget(self, action:  #selector(tapButton5), for:.touchDown)
//        button.frame = CGRect(x: 25.0, y: 300.0, width: 150.0, height: 40.0)
//        return button
//    }()
//
//    @objc func tapButton5 () {
//
//        let theAnimation1 = CABasicAnimation(keyPath: "position")
//        theAnimation1.fromValue = [10, 10]
//        theAnimation1.toValue = [100, 100]
//        theAnimation1.duration = 1.0
//        theAnimation1.beginTime = 0.0
//
//        let theAnimation2 = CABasicAnimation(keyPath: "position")
//        theAnimation2.fromValue = [100, 100]
//        theAnimation2.toValue = [10, 100]
//        theAnimation2.duration = 1.0
//        theAnimation2.beginTime = theAnimation1.beginTime + theAnimation1.duration
//
//        let theAnimation3 = CABasicAnimation(keyPath: "position")
//        theAnimation3.fromValue = [10, 100]
//        theAnimation3.toValue = [10, 10]
//        theAnimation3.duration = 1.0
//        theAnimation3.beginTime = theAnimation2.beginTime + theAnimation2.duration
//
//        let animation = CAAnimationGroup()
//        animation.animations = [theAnimation1, theAnimation2, theAnimation3]
//        animation.duration = theAnimation3.beginTime + theAnimation3.duration
//        button5.layer.add(animation, forKey: "position3")
//    }
    
    //----------------------------------------------------------------------------------------------------
    
//    @objc func tapButton6 () {
//
//        UIView.animate(withDuration: 1.5,
//                       delay: 0.0,
//                       options: .curveEaseOut,
//                       animations: {
//                        self.button.alpha = 0.0
//
//                        //view.isHidden
//
//        }) { (true) in
//            //self.button.alpha = 0.0
//        }
//    }
	
    //----------------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

	
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
//        timer?.invalidate()
//        timer = nil
	}

//    @objc func tapButton () {
//        navigationController?.popViewController(animated: true)
//    }
	

}

