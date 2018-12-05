//
//  VentureAnalysisViewController.swift
//  Demo
//
//  Created by 王云 on 2018/3/12.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

import StreamingKit

class VentureAnalysisViewController: UIViewController {
    
    var tableView: VentureAnalysisTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupUI()
        
        let audioPlayer = STKAudioPlayer()
        audioPlayer.play(URL(string: "https://api.book.lapuasi.com/attachments/25/27/1540170585_905256.mp3"))
    }
    
    func setupUI() {
        tableView = VentureAnalysisTableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
    }

}
