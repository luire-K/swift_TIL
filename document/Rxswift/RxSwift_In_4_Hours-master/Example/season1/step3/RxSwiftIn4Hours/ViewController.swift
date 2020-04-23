//
//  ViewController.swift
//  RxSwiftIn4Hours
//
//  Created by iamchiwon on 21/12/2018.
//  Copyright © 2018 n.code. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput()
    }

    // MARK: - IBOutler

    @IBOutlet var idField: UITextField!
    @IBOutlet var pwField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var idValidView: UIView!
    @IBOutlet var pwValidView: UIView!

    // MARK: - Bind UI
    
    let idInputText : BehaviorSubject<String> = BehaviorSubject(value: "")
    let idValid : BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let pwInputText : BehaviorSubject<String> = BehaviorSubject(value: "")
    let pwValid : BehaviorSubject<Bool> = BehaviorSubject(value: false)

    private func bindInput() {
        // id input +--> check valid --> bullet
        //          |
        //          +--> button enable
        //          |
        // pw input +--> check valid --> bullet
        
        //input 2:  아이디 입력, 비번입력
        idField.rx.text.orEmpty
            .bind(to: viewModel.emailText)
            .disposed(by: disposeBag)
        
        pwField.rx.text.orEmpty
            .bind(to: viewModel.pwText)
            .disposed(by: disposeBag)
        
        //output2: 아이디 비번 체크상태
        viewModel.isEmailValid
            .bind(to: idValidView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.isPasswordValid
        .bind(to: pwValidView.rx.isHidden)
        .disposed(by: disposeBag)
        
        //output 1: 버튼의 enable 상태
        Observable.combineLatest(viewModel.isEmailValid, viewModel.isPasswordValid, resultSelector: { $0 && $1 })
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
    }
}
