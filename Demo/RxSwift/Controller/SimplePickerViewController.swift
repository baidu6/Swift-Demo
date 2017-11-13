//
//  SimplePickerViewController.swift
//  Demo
//
//  Created by 王云 on 2017/11/13.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SimplePickerViewController: UIViewController {
    
    @IBOutlet weak var pickerView1: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var pickerView3: UIPickerView!
    @IBOutlet weak var pickerView4: UIPickerView!

    let disposedBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView1()
        setupPickerView2()
        setupPickerview3()
        setupPickerView4()
    }
    
    func setupPickerView1() {
        Observable.just([1, 2, 3])
            .bind(to: pickerView1.rx.itemTitles) {_, item in
                return "\(item)"
        }
        .disposed(by: disposedBag)
        
        pickerView1.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("model selected \(models)")
            })
            .disposed(by: disposedBag)
        
    }
    
    func setupPickerView2() {
        Observable.just([1, 2, 3])
            .bind(to: pickerView2.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)", attributes:            [NSAttributedStringKey.foregroundColor: UIColor.cyan, NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleDouble.rawValue])
        }
            .disposed(by: disposedBag)
        
        pickerView2.rx.modelSelected(Int.self)
            .subscribe(onNext: { item in
                print("pickerView2 model selected \(item)")
            })
            .disposed(by: disposedBag)
    }
    
    func setupPickerview3() {
        Observable.just([UIColor.red, UIColor.orange, UIColor.blue])
            .bind(to: pickerView3.rx.items) {a, item, b in
                
                let view = UIView()
                view.backgroundColor = item
                return view
        }
            .disposed(by: disposedBag)
        
        pickerView3.rx.modelSelected(UIColor.self)
            .subscribe(onNext: { item in
                print("pickerView3 model selected:\(item)")
            })
            .disposed(by: disposedBag)
    }
    
    func setupPickerView4() {
        
        Observable.just([[1, 2, 3], [5, 8, 13], [21, 34]])
            .bind(to: pickerView4.rx.items(adapter: PickerViewViewAdapter()))
            .disposed(by: disposedBag)
        
        pickerView4.rx.modelSelected(Int.self)
            .subscribe(onNext: {model in
                print(model)
            })
            .disposed(by: disposedBag)
    }


}

final class PickerViewViewAdapter: NSObject, UIPickerViewDelegate, UIPickerViewDataSource, RxPickerViewDataSourceType, SectionedViewDataSourceType {
    typealias Element = [[CustomStringConvertible]]
    private var items: [[CustomStringConvertible]] = []
    
    func model(at indexPath: IndexPath) throws -> Any {
        return items[indexPath.section][indexPath.row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = items[component][row].description
        label.textColor = UIColor.red
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, observedEvent: Event<Element>) {
        Binder(self) { (adapter, items) in
            adapter.items = items
            pickerView.reloadAllComponents()
            }.on(observedEvent)
    }
    
}
