//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by EunKyoung on 2020/04/05.
//  Copyright © 2020 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class MenuListViewModel {
    
    var menuObservable = BehaviorRelay<[Menu]>(value: [])
    
    lazy var itemsCount = menuObservable.map {
        $0.map { $0.count }.reduce(0, +)
        
    }
    lazy var totalPrice = menuObservable.map {
        $0.map { $0.price * $0.count }.reduce(0, +)
    }
    
    init() {
        _ = APIService.fetchAllMenusRx()
            .map { data -> [MenuItem] in
                struct Response: Decodable {
                    let menus: [MenuItem]
                }
                let response = try! JSONDecoder().decode(Response.self, from: data)
                
                return response.menus
        }
        .map { menuItems -> [Menu] in
            var menus: [Menu] = []
            menuItems.enumerated().forEach { index, item in
                let menu = Menu.fromMenuItem(id: index, item: item)
                menus.append(menu)
                
            }
            return menus
        }
        .take(1)
        .bind(to: menuObservable)
    }
    
    func onOrder() {
        
    }
    
    func clearAllItemSelections() {
        _ = menuObservable
            .map { menus in
                return menus.map { m in
                    Menu (id: m.id,
                          name: m.name,
                          price: m.price,
                          count: 0)
                }
        }
        .take(1)
        .subscribe(onNext: {
            self.menuObservable.accept($0)
        })
    }
    
    func changeCount(item: Menu, increase:Int) {
        _ = menuObservable
            .map { menus in
                return menus.map { m in
                    if m.id == item.id {
                        return Menu(id: m.id,
                                    name: m.name,
                                    price: m.price,
                                    count: max(m.count + increase,0))
                    } else {
                        return Menu(id: m.id,
                                    name: m.name,
                                    price: m.price,
                                    count: 0)
                    }
                    
                }
        }
        .take(1)
        .subscribe(onNext: {
            self.menuObservable.accept($0)
        })
    }
    
    // subject - (이미 만들어진)옵저버블 밖에서 데이터를 컨트롤해서 새로운 값을 넣어줄 수 있음.
}
