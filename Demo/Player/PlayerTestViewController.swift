//
//  PlayerTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/4/27.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import AVKit
import Player


private let videoUrl = URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
//private let videoUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "colgate.mp4", ofType: nil)!)


class PlayerTestViewController: UIViewController {
    
    private var playerVC: Player!

    override func viewDidLoad() {
        super.viewDidLoad()

//        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.backgroundColor = UIColor.white
        
        setupPlayer()
    }
    
    func setupPlayer() {
        playerVC = Player()
        playerVC.playerDelegate = self
        playerVC.playbackDelegate = self
        playerVC.view.frame = CGRect(x: 0, y: 100, width: SCREEN_WIDTH, height: 300)
    
        
        addChildViewController(playerVC)
        view.addSubview(playerVC.view)
        playerVC.didMove(toParentViewController: self)
        
        playerVC.playbackLoops = true
        
        playerVC.url = videoUrl
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playerVC.playFromBeginning()
    }

}

extension  PlayerTestViewController: PlayerPlaybackDelegate {
    
    func playerCurrentTimeDidChange(_ player: Player) {
        
    }
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
        
    }
    func playerPlaybackDidEnd(_ player: Player) {
        
    }
    func playerPlaybackWillLoop(_ player: Player) {
        
    }
}

extension PlayerTestViewController: PlayerDelegate {
    
    func playerReady(_ player: Player) {
        
    }
    func playerPlaybackStateDidChange(_ player: Player) {
        
    }
    func playerBufferingStateDidChange(_ player: Player) {
        
    }
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        
    }
}
