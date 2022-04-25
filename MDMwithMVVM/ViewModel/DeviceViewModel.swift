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
        
    }
    
}
