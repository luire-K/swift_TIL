//
//  ViewModel.swift
//  RxSwiftIn4Hours
//
//  Created by EunKyoung on 2020/04/23.
//  Copyright © 2020 n.code. All rights reserved.
//

import Foundation
import RxSwift

class ViewModel {
    //input
    let emailText = BehaviorSubject(value: "")
    let pwText = BehaviorSubject(value: "")
    //output
    let isEmailValid = BehaviorSubject(value: false)
    let isPasswordValid = BehaviorSubject(value: false)
    
    init() {
        _ = emailText.distinctUntilChanged()
            .map(checkEmailValid)
            .bind(to: isEmailValid)
        
        _ = pwText.distinctUntilChanged()
            .map(checkPasswordValid)
            .bind(to: isPasswordValid)
    }
    
    func setPasswordText(_ pw: String) {
        let isValid = checkPasswordValid(pw)
        isPasswordValid.onNext(isValid)
    }
    
    // MARK: - Logic

       private func checkEmailValid(_ email: String) -> Bool {
           return email.contains("@") && email.contains(".")
       }

       private func checkPasswordValid(_ password: String) -> Bool {
           return password.count > 5
       }
}
