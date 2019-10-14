//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

enum EnumError: Error {
    case emptyString
    case isNil
}


class Storage {
    func set<T>(key x: T, value y: String) -> Result<String, Error> {
        guard y != "" else {
            return .failure(EnumError.emptyString)
        }
        UserDefaults.standard.set(x, forKey: y)
        return .success("succes")
    }
    
    func get<T>(for key: String) -> Result<T, Error>{
        guard let value = UserDefaults.standard.object(forKey: key) as? T else {
            return .failure(EnumError.isNil)
        }
            return .success(value)
    }
}



let storage = Storage()

switch storage.set(key: 21, value: "Max") {
case .success(let number):
    print(number)
case .failure(let error):
    print(error.localizedDescription)
}

switch storage.set(key: 0.003, value: "qwerty") {
case .success(let number):
    print(number)
case .failure(let error):
    print(error.localizedDescription)
}

switch storage.set(key: "Maxim", value: "") {
case .success(let number):
    print(number)
case .failure(let error):
    print(error.localizedDescription)
}

switch storage.set(key: true, value: "qw") {
case .success(let number):
    print(number)
case .failure(let error):
    print(error.localizedDescription)
}

var res: Result<Double, Error>
res = storage.get(for: "qwerty")
switch res {
case .success(let number):
    print(number)
case .failure(let error):
    print(error.localizedDescription)
}

res = storage.get(for: "aaa")
switch res {
case .success(let number):
    print(number)
case .failure(let error):
    print(error.localizedDescription)
}



