//
//  DropMenuViewController.swift
//  Demo
//
//  Created by 王云 on 2018/7/3.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class DropMenuViewController: UIViewController {
    
    private var subTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    struct DropMenuData {
        
        static var TitleDatas = ["出售", "区域", "来源", "筛选"]
        
        // 房屋类型
        static var HouseType = ["出租", "出售"]
        // 区域
        static var HouseArea = ["东城区": ["安定门", "交道口", "王府井", "和平里", "北新桥", "东直门外", "东直门", "雍和宫"], "西城区": ["新街口", "阜成门", "金融街", "长椿街", "西单"], "朝阳区": ["双井", "国贸", "北苑", "大望路", "四惠", "十里堡", "花家池"], "丰台区": ["方庄", "角门", "草桥", "木樨园", "宋家庄", "东大街", "南苑", "大红门"]]
        //来源
        static var HouseSource = ["全部来源", "房天下", "便民网", "列表网", "城际分类", "58同城", "赶集", "安居客"]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.title = "下拉菜单"
        
        let menu = DropMenuView(origin: CGPoint(x: 0, y: 64), menuHeight: 30)
        menu.delegate = self
        menu.dataSource = self
        view.addSubview(menu)
    }

}

extension DropMenuViewController: DropDownMenuDelegate, DropDownMenuDataSource {
    func menu(_ menu: DropMenuView, didSelectRowAtIndexPath indexPath: DropMenuView.Index) {
        print("当前选中了第\(indexPath.column)列，第\(indexPath.row)行， 第\(indexPath.item)个元素")
    }
    
    func numberOfColumnsInMenu(_ menu: DropMenuView) -> Int {
        return DropMenuData.TitleDatas.count
    }
    
    func menu(_ menu: DropMenuView, numberOfRowsInColumn column: Int) -> Int {
        switch column {
        case 0:
            return DropMenuData.HouseType.count
        case 1:
            return DropMenuData.HouseArea.count
        case 2:
            return DropMenuData.HouseSource.count
        default:
            return 0
        }
            
    }
    
    func menu(_ menu: DropMenuView, numberOfItemsInRow row: Int, inColumn: Int) -> Int {
        if inColumn == 1 {
            return Array(DropMenuData.HouseArea.values)[row].count
        }
        return 0
    }
    
    func menu(_ menu: DropMenuView, titleForItemsInRowAtIndexPath indexPath: DropMenuView.Index) -> String {
        if indexPath.column == 1 {
            return Array(DropMenuData.HouseArea.values)[indexPath.row][indexPath.item]
        }
        return ""
    }
    
    func menu(_ menu: DropMenuView, titleForRowAtIndexPath indexPath: DropMenuView.Index) -> String {
        switch indexPath.column {
        case 0:
            return DropMenuData.HouseType[indexPath.row]
        case 1:
            return Array(DropMenuData.HouseArea.keys)[indexPath.row]
        case 2:
            return DropMenuData.HouseSource[indexPath.row]
        default:
            return "筛选"
        }
    }
  
}
