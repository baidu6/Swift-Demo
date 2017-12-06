//
//  EstimateViewController.swift
//  Demo
//
//  Created by 王云 on 2017/12/6.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import SwiftForms
enum Type: Int{
    case BuildNumber
    case UnitNumber
    case RoomNumber
}

class EstimateViewController: FormViewController {
    
    var field1: UITextField!
    var field2: UITextField!
    var field3: UITextField!
    
    
    var cell1: EstimateCell!

    var second: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupForm()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        
    }
    
    func setupUI() {
       self.navigationItem.title = "Estimate"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Test", style: .plain, target: self, action: #selector(test))
    }
    
    @objc func test() {
        cell1 = self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! EstimateCell
        cell1.textFieldDidBegin = {
            if self.form.sections[1].footerView == nil {
                self.form.sections[1].footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
            }else {
                self.form.sections[1].footerView = nil
            }
        
            self.tableView.reloadSections(IndexSet(integer: 1), with: .fade)
            
//            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: UITableViewRowAnimation.automatic)
            
//            self.tableView.reloadData()
        }

        
//        let cell2 = self.tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! EstimateCell
//        cell2.textFieldDidBegin = {
//            self.form.sections[2].footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
//            self.tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
//        }
//        
//        
//        let cell3 = self.tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as! EstimateCell
//        cell3.textFieldDidBegin = {
//            self.form.sections[3].footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
//            self.tableView.reloadSections(IndexSet(integer: 3), with: .automatic)
//        }
    }
    
    func setupForm() {        
        
        let form = FormDescriptor(title: "Estimate")
        
        let section1 = defaultSectionDescriptor(headerTitle: nil, footerTitle: nil)
        var row = FormRowDescriptor(tag: "zuoluo", type: .text, title: "房屋坐落")
    
        defaultRowAppearance(row, placeholder: "搜索小区")
        section1.rows.append(row)
        
        
        //第二组内容
        let section2 = defaultSectionDescriptor(headerTitle: nil, footerTitle: nil, headerHeight: 10)
        section2.footerView = nil
        row = FormRowDescriptor(tag: "louhao", type: .unknown, title: "楼号")
        row.configuration.cell.cellClass = EstimateCell.self
        
        section2.rows.append(row)
        

        let section3 = defaultSectionDescriptor(headerTitle: nil, footerTitle: nil, headerHeight: 0)
        row = FormRowDescriptor(tag: "danyuan", type: .unknown, title: "单元号")
        defaultRowAppearance(row, placeholder: "请输入或选择单元号")
        row.configuration.cell.cellClass = EstimateCell.self

        section3.rows.append(row)

        let section4 = defaultSectionDescriptor(headerTitle: nil, footerTitle: nil, headerHeight: 0)
        row = FormRowDescriptor(tag: "fanghao", type: .unknown, title: "房号")
        row.configuration.cell.cellClass = EstimateCell.self
        defaultRowAppearance(row, placeholder: "请输入或选择房号")
        section4.rows.append(row)
        
        
        let section5 = defaultSectionDescriptor(headerTitle: nil, footerTitle: nil)
        row = FormRowDescriptor(tag: "area", type: .text, title: "建筑面积")
        defaultRowAppearance(row, placeholder: "请输入建筑面积")
        section5.rows.append(row)
        
        row = FormRowDescriptor(tag: "floor", type: .text, title: "所在层")
        defaultRowAppearance(row, placeholder: "请输入所在层")
        section5.rows.append(row)
        
        row = FormRowDescriptor(tag: "floors", type: .text, title: "总层数")
        defaultRowAppearance(row, placeholder: "请输入总层数")
        section5.rows.append(row)
        
        form.sections = [section1, section2, section3, section4, section5]
        self.form = form
        
        
        print(tableView.visibleCells)
    }
    
    func defaultSectionDescriptor(headerTitle: String?, footerTitle: String?, headerHeight: CGFloat = 10) -> FormSectionDescriptor {
        let section = FormSectionDescriptor(headerTitle: headerTitle, footerTitle: footerTitle)
        section.headerViewHeight = headerHeight
        section.footerView = nil
        section.footerViewHeight = 0
        return section
    }
    
    func defaultRowAppearance(_ row: FormRowDescriptor, placeholder: String) {
        if row.type == .text || row.type == .estimate {
            row.configuration.cell.appearance = ["textField.placeholder" : placeholder as AnyObject,
                                                 "textField.font": UIFont.systemFont(ofSize: 16),
                                                 "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject,
                                                 
                                                ]
        }
    }
    

}


