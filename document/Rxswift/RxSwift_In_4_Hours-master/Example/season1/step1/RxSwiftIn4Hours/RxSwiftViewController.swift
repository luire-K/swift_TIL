//
//  RxSwiftViewController.swift
//  RxSwiftIn4Hours
//
//  Created by iamchiwon on 21/12/2018.
//  Copyright © 2018 n.code. All rights reserved.
//

import RxSwift
import UIKit

class RxSwiftViewController: UIViewController {
 
    // MARK: - IBAction
    var disposeBag: DisposeBag = DisposeBag()
    var disposeBag2: DisposeBag = DisposeBag()
    
    // MARK: - Field

    var counter: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable<Int>.create { emitter in
            var counter: Int = 0
            
            let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            counter += 1
            print(counter)
            emitter.onNext(counter)
        }
        return Disposables.create {
            timer.invalidate()
            }
        }
        .subscribe(onNext: { [weak self] i in
            self?.countLabel.text = "\(i)"
        })
            .disposed(by: disposeBag2)
    }

    // MARK: - IBOutlet

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var countLabel: UILabel!
    
    var disposBag: DisposeBag = DisposeBag()
    
    override func viewWillDisappear(_ animated: Bool) {
       disposBag = DisposeBag()
    }

    @IBAction func onLoadImage(_ sender: Any) {
        imageView.image = nil

       
        let disposable =
            rxswiftLoadImage(from: LARGER_IMAGE_URL)
                .observeOn(MainScheduler.instance)
                .subscribe({ result in
                    switch result {
                    case let .next(image):
                        self.imageView.image = image

                    case let .error(err):
                        print(err.localizedDescription)

                    case .completed:
                        break
                    }
                    
                })
                .disposed(by: disposBag)
        
    }

    @IBAction func onCancel(_ sender: Any) {
        disposBag = DisposeBag()
    }

    // MARK: - RxSwift

    func rxswiftLoadImage(from imageUrl: String) -> Observable<UIImage?> {
        return Observable.create { seal in
            asyncLoadImage(from: imageUrl) { image in
                seal.onNext(image)
                seal.onCompleted()
            }
            return Disposables.create()
        }
    }
}
