//
//  ViewController.swift
//  RxSwiftIn4Hours
//
//  Created by iamchiwon on 21/12/2018.
//  Copyright © 2018 n.code. All rights reserved.
//

import RxSwift
import UIKit

class ViewController: UITableViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func exJust1() {
         Observable.from(["RxSwift", "In", "4", "Hours"]) // just에 넣으면 넣은 값이 그대로 나옴
            .subscribe(onNext: {s in
                print("s")
            })
        .disposed(by: disposeBag)
        }
//            .single()
//            .subscribe { event in
//                switch event {
//                case .next(let str):
//                    print("next: \(str)")
//                break
//                case .error(let err):
//                    print("next: \(err.localizedDescription)")
//                break
//                case .completed:
//                    print("complete")//stream은 error나 complete가 나면 종료
//                    break
//                }
//        }
//    .disposed(by: disposeBag)
//    }

    @IBAction func exJust2() {
        Observable.just(["Hello", "World"])
            .subscribe(onNext: { arr in
                print(arr)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func exFrom1() {
        Observable.from(["RxSwift", "In", "4", "Hours"]) //from에 어레이가 들어가면 어레이에 있는 요소들을 빼서 내려보내 줌
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func exMap1() {
        Observable.just("Hello")
            .map { str in "\(str) RxSwift" } // 받은것을 변환(바꿔치기)해서 내려보내줌
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func exMap2() {
        Observable.from(["with", "곰튀김"]) //stream
            .map { $0.count }
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func exFilter() {
        Observable.from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
            .filter { $0 % 2 == 0 } //false면 내려가지 않는다 (더이상 진행되지 않는다)
            .subscribe(onNext: { n in
                print(n)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func exMap3() {
        Observable.just("800x600")
            .map { $0.replacingOccurrences(of: "x", with: "/") } // 800/600
            .map { "https://picsum.photos/\($0)/?random" } // https://picsum.photos/800/600/?random
            .map { URL(string: $0) } // URL?
            .filter { $0 != nil }
            .map { $0! } //URL!
            .map { try Data(contentsOf: $0) } // Data
            .map { UIImage(data: $0) } // UIImage?
            .observeOn(MainScheduler.instance)
            .do(onNext: { image in
                print(image?.size)
            })
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .subscribe(onNext: { image in
                self.imageView.image = image //side effect
            })
            .disposed(by: disposeBag)
    }
}
