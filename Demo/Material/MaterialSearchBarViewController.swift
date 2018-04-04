//
//  MaterialSearchBarViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/28.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import Material

class MaterialSearchBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupSearchBar()
    }

}

extension MaterialSearchBarViewController {
    func setupSearchBar() {
        let leftView1 = UILabel()
        leftView1.text = "leftView1"
        
//        let centerView = UIButton()
//        centerView.setTitle("CenterView", for: UIControlState.normal)
        
        let rightView1 = UILabel()
        rightView1.text = "rightView1"
        
        let searchBar = SearchBar()
        searchBar.backgroundColor = UIColor.lightGray
//        searchBar.leftViews = [leftView1]
//        searchBar.rightViews = [rightView1]
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}
