//
//  ViewController.swift
//  v_player
//
//  Created by Yu on 23.08.22.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        playVideo()
    }
    
    private func playVideo(){
        // get the Bundle path
        guard let path = Bundle.main.path(forResource: "test", ofType: "mp4") else {
            debugPrint("test.mp4 not found")
            return
        }
        
        // create player + Controller => combine them
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        
        // show the player
        present(playerController, animated: true)
        
        // play video when screen load
        player.play()
    }
}
