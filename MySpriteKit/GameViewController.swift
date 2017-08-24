//
//  GameViewController.swift
//  MySpriteKit
//
//  Created by Apple on 2017/6/2.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = FirstScene(size:view.bounds.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = true
            
        }

  }

}
