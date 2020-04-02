//
//  LoginViewController.swift
//  CoffeeShop
//
//  Created by Göktuğ Gümüş on 23.09.2018.
//  Copyright © 2018 Göktuğ Gümüş. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    @IBOutlet private weak var emailTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var logInButton: UIButton!
    // 추가한 코드 4
    private let throttleInterval = 0.1
    // 추가한 코드 1
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 추가한 코드 3
        let emailValid = emailTextfield
        .rx
        .text // 1 RxCocoa의 extension 중 하나인 text덕분에 obsevable한 변수로 UItextField의 text parameter에 도달 할 수 있음.
        .orEmpty // 2 textfield의 데이터는 string 또는 nil로 반환. orEmpty는 데이터가 항상 문자열 타입으로 제공되도록 함.
            .throttle(throttleInterval, scheduler: MainScheduler.instance)
            .map { self.validateEmail(with: $0) } // 3 입력 유효성은 validateEmail메소드를 통해 확인. emailValid변수가  Bool type Observable 변수로 바뀌길 원하기 때문에 map함수로 String을 Bool Type으로 입력을 변환.
        .debug("emailVaild", trimOutput: true) // 4 콘솔에서 이벤트 과정을 볼 수 있음. 이 옵션을 추가할 필요는 없지만 프로세스 관찰을 위해 추가.
        .share(replay: 1) // 5 만약 이 obsevable변수를 구독하는 다른 관찰자가 있다면 이 프로세스가 반복되지 않게.
        
        // 추가한 코드 5
        let passwordValid =  passwordTextfield.rx.text.orEmpty
            .throttle(throttleInterval, scheduler: MainScheduler.instance)
            .map { $0.count >= 6 } // 1 비밀번호 입력에 6자 이상 필요. 요구사항을 map함수에 작성.
        .debug("passworldValid", trimOutput: true)
        .share(replay: 1)
        
        // 추가한 코드 6
        let everythingValid = Observable
            .combineLatest(emailValid, passwordValid) { $0 && $1 } // 1 combineLatest은 Rxswift의 연결연산자 중 하나. 하나의 Observable 변수에 동일한 유형의 Observable 변수를 여러 개 모을 수 있음.
        .debug("everythingValid", trimOutput: true)
        .share(replay: 1)
        
        // 추가한 코드 7
        everythingValid
            .bind(to: logInButton.rx.isEnabled) // 1 bind(to:) 함수를 사용하면 Observable 변수를 동일한 유형으로 연결할 수 있다 . RxCocoa의 extension 중 하나인 버튼의 isEnabled변수를 Observable변수 rx.isEnabled 로 바꿔줌.
            .disposed(by: disposeBag) // 2 bind(to:) 함수는 일회용 입력 변수를 반환함. LoginViewController 클래스가 dealloc되었을때 만들었던 obsever를 폐기하기 위해 필요하다.
        
  }
    //추가한 코드 2
    private func validateEmail(with email: String) -> Bool {
      let emailPattern = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
      let predicate = NSPredicate(format:"SELF MATCHES %@", emailPattern)
      
      return predicate.evaluate(with: email)
    }
    
    @IBAction private func logInButtonPressed() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = mainStoryboard.instantiateInitialViewController()!
        
        UIApplication.changeRoot(with: initialViewController)
  }
}
