//
//  LeftRun.swift
//  MySpriteKit
//
//  Created by Apple on 2017/6/3.
//  Copyright © 2017年 Apple. All rights reserved.
//

import SpriteKit

enum Status:Int {
    case left=1,right;
}


class Run: SKSpriteNode {
    let leftAtlas = SKTextureAtlas(named: "left")
    var leftFrames = [SKTexture]()
    
    let rightAtlas = SKTextureAtlas(named: "right")
    var rightFrames = [SKTexture]()
    
    var status = Status.left
        init(){
        let texture = leftAtlas.textureNamed("SampleCustom_19")
        let size = texture.size()
        super.init(texture: texture, color: SKColor.white, size: size)
        for i in 19...27{
            let tempName = String(format:"SampleCustom_%.2d",i)
            let leftTexture = leftAtlas.textureNamed(tempName)
            leftFrames.append(leftTexture)
        }
        for i in 55...63{
            let tempName = String(format:"SampleCustom_%.2d",i)
            let rightTexture = rightAtlas.textureNamed(tempName)
            rightFrames.append(rightTexture)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func left(){
        self.removeAllActions()
        self.status = .left
        self.run(SKAction.repeatForever(SKAction.animate(with: leftFrames, timePerFrame: 0.05)))
        self.run(SKAction.repeatForever(SKAction.moveTo(x:0, duration: TimeInterval((self.position.x-0)/currentSpeed))))
    }
    func right(){
        self.removeAllActions()
        self.status = .right
        self.run(SKAction.repeatForever(SKAction.animate(with: rightFrames, timePerFrame: 0.05)))
        self.run(SKAction.repeatForever(SKAction.moveTo(x:(scene?.frame.maxX)!, duration: TimeInterval(((scene?.frame.maxX)!-self.position.x)/currentSpeed))))
      
       
    }
}


