//
//  APIWrapperViewController.swift
//  Demo
//
//  Created by 王云 on 2017/11/13.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

infix operator <-> : DefaultPrecedence

class APIWrapperViewController: UIViewController {
    
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var sliderView: UISlider!
    @IBOutlet weak var switchView: UISwitch!
    @IBOutlet weak var TapMeBtn: UIButton!
    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var sectionField: UITextField!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var actionSheetBtn: UIButton!
    @IBOutlet weak var alertViewBtn: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerView.date = Date()
        
        segmentTest()
        switchTest()
        activityTest()
        tapBtn()
        slider()
        datePicker()
        field()
        actionSheet()
        
        //创建一个Never序列，该序列不会发出任何事件，也不会终止
        Observable<String>.never()
            .subscribe({_ in
                print("This is will never bie printed")
            })
            .disposed(by: disposeBag)
        
        //empty(该序列只发出completed事件)
        Observable<Int>.empty().subscribe({event in
            print(event)
        }).disposed(by: disposeBag)
        
        //MARK:- just(序列只包含一个元素)  [1, 2, 3, 4]
        Observable.just([1, 2, 3, 4]).subscribe(onNext: {event in
            print(event)
        }).disposed(by: disposeBag)
        
        //MARK:- of(包含可变数量的元素)
        Observable.of(1, 2, 3, 4).subscribe(onNext: {element in
            print(element)
        }).disposed(by: disposeBag)
        
        //MARK:- from(通过数组来创建一个被观察序列)
        Observable.from(["a", "b", "c", "d"]).subscribe({ event in
            print(event)
        }).disposed(by: disposeBag)
        
        //MARK:- range(生成一个被观察的整数序列，发出事件n次)
        Observable.range(start: 0, count: 10).subscribe({event in
            print(event)
        }).disposed(by: disposeBag)
        
        //MARK:- repeatElement
        Observable.repeatElement(1).take(5)
            .subscribe({event in
                print(event)
            }).disposed(by: disposeBag)
        
        
    }
    
    //MARK:- segment
    func segmentTest() {
        
        segmentView.rx.value.asObservable()
            .subscribe(onNext: { [weak self] value in
                self?.textView.text = "SegmentControl value is \(value)"
            })
            .disposed(by: disposeBag)
    }
    
    //MARK:- switch
    func switchTest() {
        switchView.rx.value
            .subscribe(onNext: { value in
                self.textView.text = "SwitchView value is \(value)"
            })
            .disposed(by: disposeBag)
        
    }
    
    func activityTest() {
        switchView.rx.value
            .bind(to: activityView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    func tapBtn() {
        TapMeBtn.rx.tap
            .subscribe(onNext: {_ in
                self.textView.text = "Tap Me Btn Did Click"
            })
            .disposed(by: disposeBag)
    }
    
    func slider() {
        sliderView.rx.value
            .subscribe(onNext: {value in
                self.textView.text = "SliderView value is \(value)"
            })
            .disposed(by: disposeBag)
    }
    
    func datePicker() {
        datePickerView.rx.value.asObservable()
            .subscribe(onNext: {value in
                self.textView.text = "DatePickerView value is \(value)"
            })
            .disposed(by: disposeBag)
    }
    
    func field() {
        
        //MARK:- Bind绑定数据
//        firstField.rx.value
//            .bind(to: textView.rx.text)
//            .disposed(by: disposeBag)
//        sectionField.rx.value.map {"Second Field \(String(describing: $0))"}
//            .bind(to: textView.rx.text)
//            .disposed(by: disposeBag)
        
        
        //MARK:- Driver绑定数据
        firstField.rx.text.asDriver()
            .drive(textView.rx.text)
            .disposed(by: disposeBag)
        sectionField.rx.text.asDriver()
            .map {"Second Field \(String(describing: $0))"}
            .drive(textView.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    func actionSheet() {
        
        actionSheetBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
               self?.showActionSheet()
            })
            .disposed(by: disposeBag)
        
        alertViewBtn.rx.tap
            .subscribe(onNext: {[weak self] _ in
            self?.showAlert()
            })
            .disposed(by: disposeBag)
    }
    
    func showActionSheet() {
        let sheet = UIAlertController(title: "Tips", message: "Hello World!", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        sheet.addAction(action)
        self.present(sheet, animated: true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Tips", message: "Hello World!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    

}
