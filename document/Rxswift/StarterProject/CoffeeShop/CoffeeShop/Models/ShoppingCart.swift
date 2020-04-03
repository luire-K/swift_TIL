//
//  ShoppingCart.swift
//  CoffeeShop
//
//  Created by Göktuğ Gümüş on 25.09.2018.
//  Copyright © 2018 Göktuğ Gümüş. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ShoppingCart {
  
    static let shared = ShoppingCart()
    
    // 추가(변경)한 코드 6
    var coffees: BehaviorRelay<[Coffee: Int]> = .init(value: [:])
    /* 1 여기에서 처음으로 Observable 이외의 유형을 사용. BehaviourRelay 는 BehaviourSubject 의 wrapper. Subjects는 Rx개념에서 Observable 및 Observer 역할을 모두 수행 할 수 있는 프록시 또는 브리지라고 말할 수 있음. 지금 우리가 알아야 할 것은 : BehaviourSubject는 변수를 구독 할 때 마지막으로 방출한 element를 반환한다는 것.
     */
  
    private init() {}
  
    func addCoffee(_ coffee: Coffee, withCount count: Int) {
        var tempCoffees = coffees.value
        /* 2 BehaviourSubject가 변수의 value 매개 변수에 액세스하면 마지막으로 방출 된 element를 얻을 수 있음.
           coffees.value 코드는 [Coffee: Int] 타입의 dictionary. 이 dictionary를 임시 변수에 할당하고 추가 할 커피를 업데이트.
         */
        
    
        if let currentCount = tempCoffees[coffee] {
            tempCoffees[coffee] = currentCount + count
            
        } else {
            tempCoffees[coffee] = count
            
        }
        coffees.accept(tempCoffees) // 3 accept(:_)메소드를 사용하여 BehaviourSubject type 변수 내에서 새 element를 생성 할 수 있음.
    }
  
    func removeCoffee(_ coffee: Coffee) {
        var tempCoffees = coffees.value // 4 변수를 추가 할 때와 같은 변수 내부의 마지막 값을 가져 와서 변수에 할당. 그 다음 dictionary에서 삭제하려는 coffee를 제거.
        tempCoffees[coffee] = nil
    
        coffees.accept(tempCoffees) // 5 coffees변수로 업데이트 한 dictionary를 내보낸다.
    }
  
    func getTotalCost() -> Observable<Float> { // 6 getTotalCost() 메소드를 Float 대신 Observable<Float>을 리턴하는 메소드로 바꿈.
        return coffees.map { $0.reduce(Float(0)) { $0 + ($1.key.price * Float($1.value)) }}
        // 7 BehaviourRelay는 Observable과 Observer 둘 다의 역할을 한다고 언급했음. coffees변수 내부의 element에 대한 가격 정보를 가져와서 총 계를 리턴해야 함. 동시에 Observable 변수로 리턴해야. 이를 위해 coffees변수 내부의 element를 매핑 하여 액세스하고 원하는대로 변경할 수 있다.
      }
      
      func getTotalCount() -> Observable<Int> { // 8 getTotalCount() 메소드를 Int 대신 Observable<Int>을 리턴하는 메소드로 바꿈.
        return coffees.map { $0.reduce(0) { $0 + $1.value }} // 9 Cart의 총 커피 갯수를 Observable로 리턴
      }
      
      func getCartItems() -> Observable<[CartItem]> { // 10 getCartItems() 메소드를 [CartItem] 대신 Observable<[CartItem]>을 리턴하는 메소드로 바꿈.
        return coffees.map { $0.map { CartItem(coffee: $0.key, count: $0.value) }} // 11 basket page의 tableView에서 사용하는 CartItem 모델을 Observable array로 리턴
      }
    }

