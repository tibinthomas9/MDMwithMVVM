//
//  DeviceViewModel.swift
//  MDMwithMVVM
//
//  Created by Tibin Thomas on 24/04/22.
//

import Foundation
import RxSwift
import RxCocoa

class DeviceViewModel {
    
    let items = PublishSubject<[Device]>()
    
    func fetchDeviceList() {
            

            let devices = [
                Device(id: "123", type: "Sensor", price: 20, currency: "USD", isFavorite: true, imageURL: "", title: "Test Sensor", deviceDescription: "dcdd")                            ]
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
         let url = URL(fileURLWithPath: path)
            let request = JsonRequest<Devices>(url: url)
                    request.load { (data) in
                        DispatchQueue.main.async { [weak self] in
                            self?.items.onNext(data?.devices ?? [])
                            self?.items.onCompleted()
                        }
                    }
        
        }
//        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
//            print("jsonResult")
//            do {
//                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//                print(jsonResult)
//                  if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let devices = jsonResult["devices"] as? [Any] {
//                            // do stuff
//                      print(devices)
//                  }
//              } catch {
//                   // handle error
//                  print("devices")
//              }
//        }
        
    }
    
}
