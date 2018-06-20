//
//  SwiftFormTestViewController.swift
//  Demo
//
//  Created by 王云 on 2017/10/27.
//  Copyright © 2017年 王云. All rights reserved.
//

import UIKit
import SwiftForms
import IQKeyboardManagerSwift

struct Static {
    
    static let NameTag = "name"
    static let Passwordtag = "password"
    static let FirstTag = "FirstTag"
    static let SecondTag = "SecondTag"
    static let JobTag = "JobTag"
    static let UrlTag = "UrlTag"
    static let PhoneTag = "PhoneTag"
    static let SwitchTag = "SwitchTag"
    static let CheckTag = "CheckTag"
    static let SegmentTag = "SegmentTag"
    static let PickerTag = "PickerTag"
    static let DateTag = "DateTag"
    static let SelectorTag = "SelectorTag"
    static let StepperTag = "StepperTag"
    static let SliderTag = "SliderTag"
    static let TextViewTag = "TextViewTag"
    static let ButtonTag = "ButtonTag"


}

class SwiftFormTestViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let estimateItem = UIBarButtonItem(title: "Estimate", style: .plain, target: self, action: #selector(estimate))
        let testItem = UIBarButtonItem(title: "TableTest", style: .plain, target: self, action: #selector(tableTest))
        self.navigationItem.rightBarButtonItems = [testItem, estimateItem]
        setupForm()
    }
    
    //MARK:- 测试TableView和IQKeyboardManager的影响关系
    @objc func tableTest() {
        let vc = IQKeyBoardViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func estimate() {
        let estimate = EstimateViewController()
        self.navigationController?.pushViewController(estimate, animated: true)
    }
    
    func setupForm() {
        let form = FormDescriptor(title: "Form Title")
        
        let section1 = FormSectionDescriptor(headerTitle: "", footerTitle: "")
        
        var row = FormRowDescriptor(tag: Static.NameTag, type: .email, title: "Email")
        row.configuration.cell.appearance = ["textField.placeholder": "wang@gmail.com" as AnyObject, "textField.textAlignment": NSTextAlignment.right.rawValue as AnyObject]
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.Passwordtag, type: .password, title: "Password")
        row.configuration.cell.appearance = ["textField.placeholder": "password" as AnyObject, "textField.textAlignment": NSTextAlignment.right.rawValue as AnyObject]
        section1.rows.append(row)
        
        let section2 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        row = FormRowDescriptor(tag: Static.FirstTag, type: .name, title: "First Name")
        row.configuration.cell.appearance = ["textField.placeholder": "First" as AnyObject, "textField.textAlignment": NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.SecondTag, type: .name, title: "Section Name")
        row.configuration.cell.appearance = ["textField.placeholder": "Section" as AnyObject, "textField.textAlignment": NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.JobTag, type: .text, title: "Job")
        row.configuration.cell.appearance = ["textField.placeholder": "Job" as AnyObject, "textField.textAlignment": NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        let section3 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.UrlTag, type: .url, title: "URL")
        row.configuration.cell.appearance = ["textField.placeholder": "URL" as AnyObject, "textField.textAlignment": NSTextAlignment.right.rawValue as AnyObject]
        section3.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.PhoneTag, type: .phone, title: "Phone")
        row.configuration.cell.appearance = ["textField.placeholder": "Phone" as AnyObject, "textField.textAlignment": NSTextAlignment.right.rawValue as AnyObject]
        section3.rows.append(row)
        
        let section4 = FormSectionDescriptor(headerTitle: "AN EXAMPLE HEADER TITLE", footerTitle: "an example header title")
        row = FormRowDescriptor(tag: Static.SwitchTag, type: .booleanSwitch, title: "Enable")
        section4.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.CheckTag, type: .booleanCheck, title: "Check")
        section4.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.SegmentTag, type: .segmentedControl, title: "SegmentControl")
        row.configuration.selection.options = [1, 2, 3, 4] as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? Int else {
                return ""
            }
            switch option {
            case 1:
                return "None"
            case 2:
                return "!"
            case 3:
                return "!!"
            case 4 :
                return "!!!"
            default:
                return ""
            }
        }
        row.configuration.cell.appearance = ["titleLabel.font": UIFont.systemFont(ofSize: 20), "segmentedControl.tintColor": UIColor.orange]
        section4.rows.append(row)
        
        
        let section5 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        row = FormRowDescriptor(tag: Static.PickerTag, type: .picker, title: "Picker")
        row.configuration.cell.showsInputToolbar = true
        row.configuration.selection.options = ["F", "M", "Other"] as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? String else {
                return ""
            }
            switch option {
            case "F":
                return "Female"
            case "M":
                return "Male"
            case "Other":
                return "Other"
            default:
                return ""
            }
        }
        row.value = "M" as AnyObject
        section5.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.DateTag, type: .date, title: "Date")
        row.configuration.cell.showsInputToolbar = true
        row.value = Date() as AnyObject
        section5.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.SelectorTag, type: .multipleSelector, title: "Selector")
        row.configuration.selection.allowsMultipleSelection = true
        row.configuration.selection.options = [0, 1, 2, 3, 4] as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? Int else {
                return ""
            }
            switch option {
            case 0:
                return "Aaaa"
            case 1:
                return "Bbbb"
            case 2:
                return "Cccc"
            case 3:
                return "Dddd"
            case 4:
                return "Ffff"
            default:
                return ""
            }
        }
        row.value = [0, 1] as AnyObject
        section5.rows.append(row)
        
        let section6 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        row = FormRowDescriptor(tag: Static.StepperTag, type: .stepper, title: "Stepper")
        row.configuration.stepper.maximumValue = 200.0
        row.configuration.stepper.minimumValue = 20.0
        row.configuration.stepper.steps = 20
        section6.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.SliderTag, type: .slider, title: "Slider")
        row.configuration.stepper.maximumValue = 100.0
        row.configuration.stepper.minimumValue = 0.0
        row.configuration.stepper.steps = 10
        row.value = 50 as AnyObject
        section6.rows.append(row)
        
        let section7 = FormSectionDescriptor(headerTitle: "TEXTVIEW", footerTitle: nil)
        row = FormRowDescriptor(tag: Static.TextViewTag, type: .multilineText, title: "NOTE")
        section7.rows.append(row)
        
        let section8 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        row = FormRowDescriptor(tag: Static.ButtonTag, type: .button, title: "End Editing")
        row.configuration.button.didSelectClosure = { _ in
            self.view.endEditing(true)
        }
        section8.rows.append(row)
        
        form.sections = [section1, section2, section3, section4, section5, section6, section7, section8]
        self.form = form
        
    }


}



