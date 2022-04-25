//
//  ViewController.swift
//  MDMwithMVVM
//
//  Created by Tibin Thomas on 24/04/22.
//

import UIKit
import RxSwift
import RxCocoa

class DevicesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    
    private let bag = DisposeBag()
    private let viewModel = DeviceViewModel()
    let cellId = "deviceCellId"
    let nidName = "DeviceTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        bindTableView()
    }
    
    private func bindTableView() {
        tableView.register(UINib(nibName: nidName, bundle: nil), forCellReuseIdentifier: cellId)
        
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: DeviceTableViewCell.self)) { (row,item,cell) in
            cell.item = item
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(Device.self).subscribe(onNext: { item in
            print("SelectedItem: \(item.title)")
        }).disposed(by: bag)
        
        viewModel.fetchDeviceList()
    }


}

extension DevicesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

