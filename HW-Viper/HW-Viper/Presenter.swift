//
//  Presenter.swift
//  HW-Viper
//
//  Created by Максим Жуков on 10/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit

protocol PresenterInput {
    func getImageFromNetwork()
    func getImageFromCash()
    func clearCash()
}

class Presenter: PresenterInput, InteractorOutput {


    var output: PresenterOutput?
    var interactor: InteractorInput?
    var cash: Data?
    
    // MARK:- from interactor
    
    func setImage(data: Data?) {
        if let data = data {
            cash = data
            output?.showAlertView(withTitle: "Успешно", andText: "Изображение загружено")
        } else {
            output?.showAlertView(withTitle: "Ошибка", andText: "Не удалось загрузить изображение")
        }
    }
    
    // MARK:- from view
    
    func getImageFromNetwork() {
        interactor?.downloadImage()
    }
    
    func getImageFromCash() {
        if let cash = cash {
            output?.showImage(with: UIImage(data: cash)!)
        } else {
            output?.showAlertView(withTitle: "Ошибка", andText: "Кэш пустой")
        }
    }
    
    func clearCash() {
        self.cash = nil
        output?.showImage(with: nil)
        output?.showAlertView(withTitle: "Успешно", andText: "Кэш очищен")
    }
}

protocol PresenterOutput {
    func showImage(with image: UIImage?)
    func showAlertView(withTitle title: String, andText: String)
}
