//
//  Configurator.swift
//  HW-Viper
//
//  Created by Максим Жуков on 11/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import Foundation

class Configurator {
        func conf(view: ViewController) {
        let view = view
        let presenter = Presenter()
        let interactor = Interactor()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.output = view
        interactor.output = presenter
    }
}
