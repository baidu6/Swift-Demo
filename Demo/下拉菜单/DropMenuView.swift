//
//  DropMenuView.swift
//  Demo
//
//  Created by 王云 on 2018/7/3.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

protocol DropDownMenuDelegate: class {
    //MARK:- 点击
    func menu(_ menu: DropMenuView, didSelectRowAtIndexPath indexPath: DropMenuView.Index)
}

protocol DropDownMenuDataSource: class {
    //MARK:- optional 有几列
    func numberOfColumnsInMenu(_ menu: DropMenuView) -> Int

    //MARK:- 每一列有多少行
    func menu(_ menu: DropMenuView, numberOfRowsInColumn column: Int) -> Int
    
    //MARK:- 每一列每行的title
    func menu(_ menu: DropMenuView, titleForRowAtIndexPath indexPath: DropMenuView.Index) -> String
    
    //MARK:- 某列某行的item数量，如果有，则说明有二级菜单
    func menu(_ menu: DropMenuView, numberOfItemsInRow row: Int, inColumn: Int) -> Int
    
    //MARK:- 二级菜单的标题
    func menu(_ menu: DropMenuView, titleForItemsInRowAtIndexPath indexPath: DropMenuView.Index) -> String
    
}

extension DropDownMenuDataSource {
    func numberOfColumnsInMenu(_ menu: DropMenuView) -> Int {
        return 1
    }
    
    func menu(_ menu: DropMenuView, numberOfItemsInRow row: Int, inColumn: Int) -> Int {
        return 0
    }
    
    func menu(_ menu: DropMenuView, titleForItemsInRowAtIndexPath indexPath: DropMenuView.Index) -> String {
        return ""
    }
}

class DropMenuView: UIView {
    
    public struct Index {
        //MARK:- 列
        var column: Int
        //MARK:- 行
        var row: Int
        //MARK:- 行的子行
        var item: Int
        //MARK:- 是否有item
        var haveItem: Bool {
            return item != -1
        }
        
        init(column: Int, row: Int, item: Int = -1) {
            self.column = column
            self.row = row
            self.item = item
        }
    }
    
    //MARK:- 代理
    weak var delegate: DropDownMenuDelegate?
    
    //MARK:- 数据源
    weak var dataSource: DropDownMenuDataSource? {
        didSet {
            if oldValue === dataSource {
                return
            }
            didSetDataSource(dataSource: dataSource!)
        }
    }
    
    private var currentSelectedColumn: Int = -1
    private var currentSelectedRows = [Int]()
    
    private var animationDuration: TimeInterval = 0.3
    
    private var heightForTableView: CGFloat = SCREEN_HEIGHT - 200
    
    private var menuOrigin: CGPoint = CGPoint.zero
    private var menuHeight: CGFloat = 0
    
    private var isShow: Bool = false
    private var filtrateViewIsShow: Bool = false
    private var filtrateViewHeight: CGFloat = 0
    
    private var titleButtons = [UIButton]()
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: CGRect(x: menuOrigin.x, y: menuOrigin.y, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.alpha = 0
        return view
    }()
    
    private lazy var leftTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: menuOrigin.x, y: menuOrigin.y + menuHeight, width: SCREEN_WIDTH * 0.5, height: 0), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCellID")
        return tableView
    }()
    
    private lazy var rightTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: menuOrigin.x + SCREEN_WIDTH * 0.5, y: menuOrigin.y + menuHeight, width: SCREEN_WIDTH * 0.5, height: 0))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCellID")
        return tableView
    }()
    
    private lazy var filtrateView: FiltrateView = {
       let view = FiltrateView(frame: CGRect(x: menuOrigin.x, y: -SCREEN_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - menuHeight))
        return view
    }()
    
    init(origin: CGPoint, menuHeight height: CGFloat) {
        
        menuOrigin = origin
        menuHeight = height
        filtrateViewHeight = SCREEN_HEIGHT - height - 64
        super.init(frame: CGRect(x: origin.x, y: origin.y, width: SCREEN_WIDTH, height: height))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTaped))
        backgroundView.addGestureRecognizer(tapGesture)
        
        leftTableView.tableFooterView = UIView()
        rightTableView.tableFooterView = UIView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTitleButtons(with columns: Int) {
        let btnW: CGFloat = SCREEN_WIDTH / CGFloat(columns)
        let btnH: CGFloat = self.height
        let btnY: CGFloat = 0
        var btnX: CGFloat = 0
        for i in 0..<columns {
            let btn = UIButton(type: .custom)
            btnX = btnW * CGFloat(i)
            btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            btn.setTitle(dataSource?.menu(self, titleForRowAtIndexPath: DropMenuView.Index(column: i, row: 0)), for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: autoFont(size: 30))
            btn.titleLabel?.textAlignment = .center
            btn.backgroundColor = i % 2 == 0 ? UIColor.red : UIColor.lightGray
            btn.addTarget(self, action: #selector(titleBtnDidClick(btn:)), for: .touchUpInside)
            btn.tag = 100 + i
            addSubview(btn)
            titleButtons.append(btn)
        }
    }
    
    @objc func backgroundViewTaped() {
        animationTableView(show: false)
        isShow = false
    }
    
    func animationTableView(show: Bool) {
        var haveItems = false
        let numberOfRows = leftTableView.numberOfRows(inSection: 0)
        if let dataSource = dataSource {
            for i in 0..<numberOfRows {
                if dataSource.menu(self, numberOfItemsInRow: i, inColumn: currentSelectedColumn) > 0 {
                    haveItems = true
                }
            }
        }
        
        let heightForTableView = CGFloat(numberOfRows) * cellHeight > self.heightForTableView ? self.heightForTableView : CGFloat(numberOfRows) * cellHeight
        
        if show {
            superview?.addSubview(backgroundView)
            superview?.addSubview(self)
            
            if haveItems {
                leftTableView.frame = CGRect(x: menuOrigin.x, y: menuOrigin.y + menuHeight, width: SCREEN_WIDTH * 0.5, height: 0)
                rightTableView.frame = CGRect(x: SCREEN_WIDTH * 0.5, y: menuOrigin.y + menuHeight, width: SCREEN_WIDTH * 0.5, height: 0)
                superview?.addSubview(leftTableView)
                superview?.addSubview(rightTableView)
            } else {
                rightTableView.removeFromSuperview()
                leftTableView.frame = CGRect(x: menuOrigin.x, y: menuOrigin.y + menuHeight, width: SCREEN_WIDTH, height: 0)
                superview?.addSubview(leftTableView)
            }
            
            UIView.animate(withDuration: animationDuration) {
                self.backgroundView.alpha = 1.0
                self.leftTableView.frame.size.height = heightForTableView
                if haveItems {
                    self.rightTableView.frame.size.height = heightForTableView
                }
            }
            
        } else {
            UIView.animate(withDuration: animationDuration, animations: {
                self.backgroundView.alpha = 0
                self.leftTableView.frame.size.height = 0
                if haveItems {
                    self.rightTableView.frame.size.height = 0
                }
            }) { (_) in
                self.leftTableView.removeFromSuperview()
                if haveItems {
                    self.rightTableView.removeFromSuperview()
                }
                self.backgroundView.removeFromSuperview()
            }
        }
    }
    
    func animationFiltrateView(show: Bool) {
        if show {
            superview?.addSubview(backgroundView)
            superview?.addSubview(filtrateView)
            superview?.addSubview(self)
            UIView.animate(withDuration: animationDuration) {
                self.filtrateView.frame.origin.y = self.menuOrigin.y + self.menuHeight
                self.backgroundView.alpha = 1.0
            }
        } else {
            
            UIView.animate(withDuration: animationDuration, animations: {
                self.filtrateView.frame.origin.y = -SCREEN_HEIGHT
                self.backgroundView.alpha = 0
            }) { (_) in
                self.filtrateView.removeFromSuperview()
                self.backgroundView.removeFromSuperview()
            }
        }
    }
    
    func didSetDataSource(dataSource: DropDownMenuDataSource) {
        //列数
        let columns = dataSource.numberOfColumnsInMenu(self)
        createTitleButtons(with: columns)
        
        currentSelectedRows = Array<Int>(repeating: 0, count: columns)
    }
    
    @objc func titleBtnDidClick(btn: UIButton) {
        let column = btn.tag - 100
        
        guard let dataSource = dataSource else {
            return
        }
        
        // 点击筛选
        if column == titleButtons.count - 1 {
            
            if isShow {
                animationTableView(show: false)
                isShow = false
            }
            // 弹出 或 收回
            if currentSelectedColumn == column && filtrateViewIsShow {
                animationFiltrateView(show: false)
                filtrateViewIsShow = false
            } else {
                currentSelectedColumn = column
                animationFiltrateView(show: true)
                filtrateViewIsShow = true
            }
            return
        }
        
        // 收回或者弹出当前的menu
        if currentSelectedColumn == column && isShow {
            //收回
            animationTableView(show: false)
            isShow = false
            
        } else {
            currentSelectedColumn = column
            //载入数据
            leftTableView.reloadData()
            
            if dataSource.menu(self, numberOfItemsInRow: currentSelectedRows[currentSelectedColumn], inColumn: currentSelectedColumn) > 0 {
                rightTableView.reloadData()
            }
            
            //收回筛选
            if filtrateViewIsShow {
                UIView.animate(withDuration: animationDuration) {
                    self.filtrateView.frame.origin.y = self.menuOrigin.y + self.menuHeight
                }
                filtrateView.removeFromSuperview()
                filtrateViewIsShow = false
            }
            
            //弹出
            self.animationTableView(show: true)
            self.isShow = true
            
        }
        
    }

}

extension DropMenuView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            if let dataSource = dataSource {
                return dataSource.menu(self, numberOfRowsInColumn: currentSelectedColumn)
            }
        } else {
            if let dataSource = dataSource {
                return dataSource.menu(self, numberOfItemsInRow: currentSelectedRows[currentSelectedColumn], inColumn: currentSelectedColumn)
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellID")
        
        if tableView == leftTableView {
            if let dataSource = dataSource {
                cell?.textLabel?.text = dataSource.menu(self, titleForRowAtIndexPath: Index(column: currentSelectedColumn, row: indexPath.row))
            }
            
            //选中上次选择的行
            if currentSelectedRows[currentSelectedColumn] == indexPath.row {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            }
            
            
        } else {
            if let dataSource = dataSource {
                cell?.textLabel?.text = dataSource.menu(self, titleForItemsInRowAtIndexPath: Index(column: currentSelectedColumn, row: currentSelectedRows[currentSelectedColumn], item: indexPath.item))
            }
            
            //选中上次选择的行
            if cell?.textLabel?.text == titleButtons[currentSelectedColumn].title(for: .normal) {
                leftTableView.selectRow(at: IndexPath(row: currentSelectedRows[currentSelectedColumn], section: 0), animated: true, scrollPosition: .middle)
                rightTableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataSource = dataSource else {
            return
        }
        if tableView == leftTableView {
            currentSelectedRows[currentSelectedColumn] = indexPath.row
            
            let haveItems = dataSource.menu(self, numberOfItemsInRow: indexPath.row, inColumn: currentSelectedColumn) > 0
            
            if haveItems {
                rightTableView.reloadData()
                
            } else {
                // 收回列表
                animationTableView(show: false)
                isShow = false
                
                //更新title
                titleButtons[currentSelectedColumn].setTitle(dataSource.menu(self, titleForRowAtIndexPath: Index(column: currentSelectedColumn, row: indexPath.row)), for: .normal)
            }
            
            delegate?.menu(self, didSelectRowAtIndexPath: Index(column: currentSelectedColumn, row: indexPath.row))
            
        } else {
            //收回列表
            animationTableView(show: false)
            isShow = false
            
            
            //更新title
            let index = Index(column: currentSelectedColumn, row: currentSelectedRows[currentSelectedColumn], item: indexPath.row)
            
            titleButtons[currentSelectedColumn].setTitle(dataSource.menu(self, titleForItemsInRowAtIndexPath: index), for: .normal)
        
            delegate?.menu(self, didSelectRowAtIndexPath: index)
        }
    }
}

