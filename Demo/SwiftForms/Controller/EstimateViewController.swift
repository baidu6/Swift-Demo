//
//  EstimateViewController.swift
//  Demo
//
//  Created by 王云 on 2017/12/6.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import SwiftForms

typealias EstimateType = (section:Int, expand:Bool)

class EstimateViewController: FormViewController {
    
    var field1: UITextField!
    var field2: UITextField!
    var field3: UITextField!
    
    var open = false
    var type: EstimateType = (0, false)

    var cell1: EstimateCell!

    var second: Bool = false
    
    var footer: UIView = UIView()
    
    var resultArray: [ResultTableView] = [ResultTableView]()
    
    fileprivate var resultTableView1: ResultTableView!
    fileprivate var resultTableView2: ResultTableView!
    fileprivate var resultTableView3: ResultTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupForm()

    }
 
    
    func setupUI() {
       self.navigationItem.title = "Estimate"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "test", style: .plain, target: self, action: #selector(test))
        footer.backgroundColor = UIColor.orange
        
        
        resultTableView1 = ResultTableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200), style: .plain)
        resultTableView2 = ResultTableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200), style: .plain)
        resultTableView3 = ResultTableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200), style: .plain)
        
        resultArray.append(resultTableView1)
        resultArray.append(resultTableView2)
        resultArray.append(resultTableView3)

        
    }
    
    @objc func test() {
        let result1 = resultArray[0]
        result1.datas = ["哈哈哈哈哈", "嘿嘿嘿嘿"]
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
        
        var isHangzhou = true
        if isHangzhou {
            row = FormRowDescriptor(tag: "type", type: .text, title: "房屋类型")
            row.configuration.cell.appearance = ["titleLabel.textAlignment": NSTextAlignment.left as AnyObject]
            section5.rows.append(row)
            
            row = FormRowDescriptor(tag: "jignguan", type: .button, title: "景观")
            section5.rows.append(row)
        }
        
        form.sections = [section1, section2, section3, section4, section5]
        self.form = form

    }
    
    func defaultSectionDescriptor(headerTitle: String?, footerTitle: String?, headerHeight: CGFloat = 10) -> FormSectionDescriptor {
        let section = FormSectionDescriptor(headerTitle: headerTitle, footerTitle: footerTitle)
        section.headerViewHeight = headerHeight
//        section.footerView = nil
//        section.footerViewHeight = 0
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

extension EstimateViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        if cell.isKind(of: EstimateCell.classForCoder()) {
            let cell = cell as! EstimateCell
      
            cell.fieldDidBegin = {
                if self.type.expand == false {
                    self.type = (indexPath.section, true)
                }else {
                    self.type = (indexPath.section, true)
                }
                
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 1 || section == 2 || section == 3 {
//            let result = ResultTableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200), style: .plain)
//            return result
            let result = resultArray[section - 1]
            print(result)
//            result.datas = ["上一组：：：\(section - 1)", "所在组：：：\(section)"]
            return resultArray[section - 1]
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            if section == self.type.section {
                return self.type.expand ? 200 : 0
            }
        return 0
    }
    
}


