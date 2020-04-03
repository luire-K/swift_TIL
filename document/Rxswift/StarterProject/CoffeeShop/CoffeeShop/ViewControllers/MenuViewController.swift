//
//  MenuViewController.swift
//  CoffeeShop
//
//  Created by Göktuğ Gümüş on 23.09.2018.
//  Copyright © 2018 Göktuğ Gümüş. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: BaseViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var shoppingCartButton: BadgeBarButtonItem = {
        let button = BadgeBarButtonItem(image: "cart_menu_icon", badgeText: nil, target: self, action: #selector(shoppingCartButtonPressed))
        button!.badgeButton!.tintColor = Colors.brown
        
        return button!
  }()
    
    //추가한 코드 3
    private let disposeBag = DisposeBag()
  
    // 추가(변경)한 코드 2
    private lazy var coffees: Observable<[Coffee]> = {
        let espresso = Coffee(name: "Espresso", icon: "espresso", price: 4.5)
        let cappuccino = Coffee(name: "Cappuccino", icon: "cappuccino", price: 11)
        let macciato = Coffee(name: "Macciato", icon: "macciato", price: 13)
        let mocha = Coffee(name: "Mocha", icon: "mocha", price: 8.5)
        let latte = Coffee(name: "Latte", icon: "latte", price: 7.5)
    
        return .just([espresso, cappuccino, macciato, mocha, latte])
        
        /* .just 함수는 이 Observable type의 변수가 절대 변하지 않을 것임을 보여줌.
            그러나 변수가 변하지 않더라도 Observable 변수를 만들고 있을 것.
         */
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = shoppingCartButton
    
        configureTableView()
        
        // Rx - Setup 추가한 코드 4 - 이 코드는 coffees변수에 변화가 있을때 cell이 tableView에 추가되도록 함.
        // 이 경우에는 coffee변수에 정의된 5개의 커피data가 tableView에 cell로 추가 됨.
        
        // 1 tableView의 모든 라인에 대해 coffee변수와 연결하기위해 bind(to:)함수를 호출함.
        coffees
        .bind(to: tableView
            .rx // 2 RxCocoa extension을 위해 메소드를 호출.
            .items(cellIdentifier: "coffeeCell", cellType: CoffeeCell.self)) { row, element, cell in
                // 3 items(cellIdentifier:cellType:)메소드 에서 사용하려는 셀 식별자와 셀 클래스를 전달.
                // Rx프레임워크는 일반적으로 델리게이트를 사용하여 생성한 대기열 제거방법(dequeuing methods)을 호출
              cell.configure(with: element) // 4 이 코드 블록은 각각의 새로운 요소에 대해 실행. row, element 및 cell 정보를 얻을 수 있음.
                //이 경우 element변수는 Coffee type임. configure(with:_)메소드에 현재 Coffee data를 제공함으로써 CoffeeCell을 구성.
            }
    .disposed(by: disposeBag) // 5 bind(to:) 함수는 일회용변수를 반환. MenuViewController 클래스가 할당 취소될 때 생성한 Observer를 적절히 폐기하려면 이 클래스에 추가해야 함.
        
        // 추가한 코드 5
        tableView
        .rx // 1 rx 메소드를 호출하여 RxCocoa extension에 액세스.
            .modelSelected(Coffee.self) // 2 modelSelected(_:) 메소드로 리턴할 element 타입, tableView의 reactive extension을 전달, tableView에서 선택된 element를 Observable로 리턴
            .subscribe(onNext: { [weak self] coffee in // 3 Observable 변수를 subscribe(onNext:) 메서드 내부의 클로저에 전달.cell을 클릭할 때 실행.
                self?.performSegue(withIdentifier: "OrderCoffeeSegue", sender: coffee)
                // 4 스토리 보드에서 이전에 정의한 segue를 실행. coffee detail page로 이동.
                
                if let selectedRowIndexPath = self?.tableView.indexPathForSelectedRow { // 5 tableView에서 선택한 선을 선택된 상태에서 제거
                    self?.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
            })
        .disposed(by: disposeBag) // 6 subscribe(onNext:) 메소드는 Disposable type 변수를 리턴. 클래스를 할당해제 할때 Observer를 올바르게 처리하려면 추가해야 함.
        
        // 추가한 코드 7
        ShoppingCart.shared.getTotalCount()
            .subscribe(onNext: { [weak self] totalOrderCount in
                self?.shoppingCartButton.badgeText = totalOrderCount != 0 ? "\(totalOrderCount)" : nil
            })
            
            .disposed(by: disposeBag)
        
         // GetTotalCount()라고 명명된 Observable<Int> 타입 메소드를 구독. 피 변수가 변경될 때마다 주문한 커피의 현재 합계 정보가 totalOrderCount 변수와 함께 리턴 됨.
    }
  
  private func configureTableView() {
    tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
    tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
    
    // 추가한 코드 1
    tableView.rowHeight = 104
  }
  
  @objc private func shoppingCartButtonPressed() {
    performSegue(withIdentifier: "ShowCartSegue", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let coffee = sender as? Coffee else { return }
    
    if segue.identifier == "OrderCofeeSegue" {
      if let viewController = segue.destination as? OrderCoffeeViewController {
        viewController.coffee = coffee
        viewController.title = coffee.name
      }
    }
  }
}
