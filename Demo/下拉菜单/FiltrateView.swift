//
//  FiltrateView.swift
//  Demo
//
//  Created by 王云 on 2018/7/5.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
struct FiltrateDatas {
    // section title
    static let sectionTitles = ["房屋来源", "价格", "面积", "朝向", "户型"]
    // 房屋来源
    static let houseSources = ["个人房源", "疑似经纪人"]
    // 价格
    static let pricePlaceholder = ["min": "最低价（万元）", "max": "最高价（万元）"]
    // 面积
    static let areaPlaceholder = ["min": "最小（m²）", "max": "最大（m²）"]
    // 朝向
    static let orientations = ["东", "南", "西", "北", "东北", "东南", "西北", "西南", "东西", "南北", "其它"]
    // 户型
    static let houseType = ["开间", "一室一厅", "两室一厅", "三室一厅", "两室两厅", "三室两厅", "四室以上", "其它"]
    
    // 房屋来源选中状态
    static var houseSourceSelectStatus: [Bool] = Array(repeating: false, count: houseSources.count)
    
    // 价格
    static var housePriceValue: [String: String] = ["min": "", "max": ""]
    
    // 面积
    static var houseAreaValue: [String: String] = ["min": "", "max": ""]
    
    // 房屋朝向选中状态
    static var orientationsSelectStatus: [Bool] = Array(repeating: false, count: orientations.count)
    
    // 房屋户型
    static var houseTypeSelectStatus: [Bool] = Array(repeating: false, count: houseType.count)
}

private let headerTitleFont = UIFont.systemFont(ofSize: autoFont(size: 28))
private let headerTitleColor = UIColor.black
private let contentTitleFont = UIFont.systemFont(ofSize: autoFont(size: 26))
private let contentTitleColor = UIColor.black
private let contentBgColor = UIColor.ColorHex(hex: "EEEEEE")

class FiltrateView: UICollectionView {
    private let cellHeight: CGFloat = autoHeight(height: 60)
    private let headerViewHeight: CGFloat = autoHeight(height: 80)
    private let leftMargin: CGFloat = autoWidth(width: 30)
    private let middleMargin: CGFloat = autoWidth(width: 20)
    private let minimumLineSpacing: CGFloat = autoHeight(height: 20)
    private let footerHeight: CGFloat = autoHeight(height: 80)
    private let sectionFooterMargin: CGFloat = autoHeight(height: 50)
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        
        delegate = self
        dataSource = self
        backgroundColor = UIColor.white
  
        register(FiltrateFieldCell.self, forCellWithReuseIdentifier: "FiltrateFieldCellID")
        register(FiltrateTitleCell.self, forCellWithReuseIdentifier: "FiltrateTitleCellID")
        register(FiltrateHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "FiltrateHeaderViewID")
   
        let footer = FiltrateFooterView(frame: CGRect(x: 0, y: self.height - footerHeight, width: SCREEN_WIDTH, height: footerHeight))
        self.insertSubview(footer, at: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FiltrateView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return FiltrateDatas.sectionTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return FiltrateDatas.houseSources.count
        case 1, 2:
            return 1
        case 3:
            return FiltrateDatas.orientations.count
        case 4:
            return FiltrateDatas.houseType.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 || indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiltrateFieldCellID", for: indexPath) as! FiltrateFieldCell
            cell.placeholder = indexPath.section == 1 ? FiltrateDatas.pricePlaceholder : FiltrateDatas.areaPlaceholder
            cell.value = indexPath.section == 1 ? FiltrateDatas.housePriceValue : FiltrateDatas.houseAreaValue
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiltrateTitleCellID", for: indexPath) as! FiltrateTitleCell
        if indexPath.section == 0 {
            cell.title = FiltrateDatas.houseSources[indexPath.row]
            cell.selectStatus = FiltrateDatas.houseSourceSelectStatus[indexPath.row]
        } else if indexPath.section == 3 {
            cell.title = FiltrateDatas.orientations[indexPath.row]
            cell.selectStatus = FiltrateDatas.orientationsSelectStatus[indexPath.row]
        } else if indexPath.section == 4 {
            cell.title = FiltrateDatas.houseType[indexPath.row]
            cell.selectStatus = FiltrateDatas.houseTypeSelectStatus[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            //单选
            if FiltrateDatas.houseSourceSelectStatus[indexPath.row] == true {
                FiltrateDatas.houseSourceSelectStatus[indexPath.row] = false
            } else {
                FiltrateDatas.houseSourceSelectStatus = FiltrateDatas.houseSourceSelectStatus.map { _ in return false }
                FiltrateDatas.houseSourceSelectStatus[indexPath.row] = !FiltrateDatas.houseSourceSelectStatus[indexPath.row]
            }
            //刷新
            collectionView.reloadSections(IndexSet.init(integer: indexPath.section))
        case 3:
            //多选
            FiltrateDatas.orientationsSelectStatus[indexPath.row] = !FiltrateDatas.orientationsSelectStatus[indexPath.row]
            
            //刷新
            let cell = collectionView.cellForItem(at: indexPath) as! FiltrateTitleCell
            cell.selectStatus = FiltrateDatas.orientationsSelectStatus[indexPath.row]
            
        case 4:
            //多选
            FiltrateDatas.houseTypeSelectStatus[indexPath.row] = !FiltrateDatas.houseTypeSelectStatus[indexPath.row]
            //刷新
            let cell = collectionView.cellForItem(at: indexPath) as! FiltrateTitleCell
            cell.selectStatus = FiltrateDatas.houseTypeSelectStatus[indexPath.row]
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        var headerView: FiltrateHeaderView?
        if kind == UICollectionElementKindSectionHeader {
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "FiltrateHeaderViewID", for: indexPath) as? FiltrateHeaderView
            headerView?.title = FiltrateDatas.sectionTitles[indexPath.section]
            
        }
//        else if kind == UICollectionElementKindSectionFooter {
//            if indexPath.section == 4 {
//                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "FiltrateFooterViewID", for: indexPath) as? FiltrateFooterView
//                footerView?.footerBtnDidClick = { type in
//                    switch type {
//                    case .reset:
//                        FiltrateDatas.houseSourceSelectStatus = FiltrateDatas.houseSourceSelectStatus.map {_ in return false}
//                        FiltrateDatas.orientationsSelectStatus = FiltrateDatas.orientationsSelectStatus.map {_ in return false}
//                        FiltrateDatas.houseTypeSelectStatus = FiltrateDatas.houseTypeSelectStatus.map {_ in return false}
//                        FiltrateDatas.housePriceValue = ["min": "", "max": ""]
//                        FiltrateDatas.houseAreaValue = ["min": "", "max": ""]
//                        self.reloadData()
//                    case .confirm:
//                        print("确定")
//                    }
//                }
//                return footerView!
//            }
//        }
        return headerView!
    }
}

extension FiltrateView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: (SCREEN_WIDTH - leftMargin * 2 - middleMargin * 2) * 0.5, height: cellHeight)
        case 1, 2:
            return CGSize(width: SCREEN_WIDTH, height: cellHeight)
        case 3:
            return CGSize(width: (SCREEN_WIDTH - leftMargin * 2 - middleMargin * 4) / 4, height: cellHeight)
        case 4:
            return CGSize(width: (SCREEN_WIDTH - leftMargin * 2 - middleMargin * 3) / 3, height: cellHeight)
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 || section == 3 || section == 4 {
            return UIEdgeInsets(top: 0, left: leftMargin, bottom: 0, right: leftMargin)
        }
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: headerViewHeight)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        if section == 4 {
//            return CGSize(width: SCREEN_WIDTH, height: footerHeight)
//        }
//        return CGSize.zero
//    }
    
}

class FiltrateFieldCell: UICollectionViewCell {
    private var minField: UITextField!
    private var maxField: UITextField!
    
    var placeholder: [String: String]? {
        didSet {
            minField.placeholder = placeholder?["min"]
            maxField.placeholder = placeholder?["max"]
        }
    }
    
    var value: [String: String]? {
        didSet {
            minField.text = value?["min"]
            maxField.text = value?["max"]
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        minField = UITextField()
        minField.backgroundColor = contentBgColor
        minField.font = contentTitleFont
        minField.textColor = contentTitleColor
        minField.textAlignment = .center
        minField.borderStyle = .roundedRect
        minField.keyboardType = .numberPad
        contentView.addSubview(minField)
        
        let line = UIView()
        line.backgroundColor = UIColor.black
        contentView.addSubview(line)
        
        maxField = UITextField()
        maxField.backgroundColor = contentBgColor
        maxField.font = contentTitleFont
        maxField.textColor = contentTitleColor
        maxField.textAlignment = .center
        maxField.borderStyle = .roundedRect
        maxField.keyboardType = .numberPad
        contentView.addSubview(maxField)
        
        line.snp.makeConstraints { (make) in
            make.width.equalTo(autoWidth(width: 10))
            make.height.equalTo(autoHeight(height: 2))
            make.center.equalToSuperview()
        }
        
        minField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(autoWidth(width: 30))
            make.height.equalTo(autoHeight(height: 60))
            make.centerY.equalToSuperview()
            make.right.equalTo(line.snp.left).offset(autoWidth(width: -20))
        }
        
        maxField.snp.makeConstraints { (make) in
            make.left.equalTo(line.snp.right).offset(autoWidth(width: 20))
            make.right.equalToSuperview().offset(autoWidth(width: -30))
            make.centerY.equalToSuperview()
            make.height.equalTo(autoHeight(height: 60))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FiltrateTitleCell: UICollectionViewCell {
    
    private var titleLabel: UILabel!
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var selectStatus: Bool? {
        didSet {
            if let selectStatus = selectStatus {
                backgroundColor = selectStatus == true ? UIColor.red : contentBgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = contentBgColor
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        titleLabel = UILabel()
        titleLabel.font = contentTitleFont
        titleLabel.textAlignment = .center
        titleLabel.textColor = contentTitleColor
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FiltrateHeaderView: UICollectionReusableView {
    
    private var titleLabel: UILabel!
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        titleLabel = UILabel()
        titleLabel.font = headerTitleFont
        titleLabel.textAlignment = .left
        titleLabel.textColor = headerTitleColor
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(autoWidth(width: 30))
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class FiltrateFooterView: UICollectionReusableView {
    
    enum FooterButtonType {
        case reset
        case confirm
    }
    
    typealias SimpleCallBackWithButtonType = (_ type: FooterButtonType) -> ()
    var footerBtnDidClick: SimpleCallBackWithButtonType?
    
    // 重置
    private var resetBtn: UIButton!
    // 确定
    private var confirmBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        resetBtn = UIButton(type: .custom)
        resetBtn.setTitle("重置", for: .normal)
        resetBtn.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH * 0.5, height: self.frame.height)
        resetBtn.setTitleColor(contentTitleColor, for: .normal)
        resetBtn.backgroundColor = UIColor.white
        resetBtn.titleLabel?.font = contentTitleFont
        resetBtn.addTarget(self, action: #selector(resetAction), for: .touchUpInside)
        addSubview(resetBtn)
        
        confirmBtn = UIButton(type: .custom)
        confirmBtn.setTitle("确定", for: .normal)
        confirmBtn.frame = CGRect(x: SCREEN_WIDTH * 0.5, y: 0, width: SCREEN_WIDTH * 0.5, height: self.frame.height)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.backgroundColor = UIColor.red
        confirmBtn.titleLabel?.font = contentTitleFont
        confirmBtn.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        addSubview(confirmBtn)
        
        let seperatorLine = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: autoHeight(height: 1)))
        seperatorLine.backgroundColor = UIColor.lightGray
        addSubview(seperatorLine)

    }
    
    @objc func resetAction() {
        footerBtnDidClick?(.reset)
    }
    
    @objc func confirmAction() {
        footerBtnDidClick?(.confirm)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
