//
//  ShoppingCartViewController.swift
//  CoffeeShop
//
//  Created by Göktuğ Gümüş on 25.09.2018.
//  Copyright © 2018 Göktuğ Gümüş. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ShoppingCartViewController: BaseViewController {
  
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var totalPriceLabel: UILabel!
    
    // 추가한 코드 8
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        // Rx - Setup
        
        ShoppingCart.shared.getCartItems()
            .bind(to: tableView.rx
                .items(cellIdentifier: "cartCoffeeCell", cellType: CartCoffeeCell.self)) { row, element, cell in
                    cell.configure(with: element)
        }
        .disposed(by: disposeBag)
        
        ShoppingCart.shared.getTotalCost()
            .subscribe(onNext: { [weak self] totalCost in
                self?.totalPriceLabel.text = CurrencyFormatter.turkishLirasFormatter.string(from: totalCost)
            })
         .disposed(by: disposeBag)
       
        tableView.rx
            .modelDeleted(CartItem.self)
            // 1 modelDeleted(_:)는 tableView의 reactive extension 메소드로 리턴 될 element를 전달하고 호출하면 메소드는 tableView에서 삭제 된 element를 Observable로 리턴
            .subscribe(onNext: { cartItem in // 2 이 Observable 변수를 subscribe(onNext:)메소드 내부의 클로저에 전달
                ShoppingCart.shared.removeCoffee(cartItem.coffee) // 3 모델에서 삭제 된 모델 의 coffee객체도 삭제
            })
            .disposed(by: disposeBag) // 4 subscribe(onNext:)메소드는 Disposable 변수를 리턴. Observer를 폐기하려면이 클래스에 이것을 추가해야함.
  }
    
    private func configureTableView() {
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        
        tableView.rowHeight = 104
    }
}
