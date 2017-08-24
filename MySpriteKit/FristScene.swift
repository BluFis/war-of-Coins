//
//  FristScene.swift
//  MySpriteKit
//
//  Created by Apple on 2017/6/2.
//  Copyright © 2017年 Apple. All rights reserved.
//

import SpriteKit

class FirstScene : SKScene{
    
    override func didMove(to view: SKView) {
        creatScene()
        allright()
        begin()
        help()
        setUpScorecard()
       
    }
    func tapped(){
        removeAllChildren()
        self.view?.viewWithTag(06)?.removeFromSuperview()
        self.view?.viewWithTag(01)?.removeFromSuperview()
        self.view?.viewWithTag(07)?.removeFromSuperview()
        self.view?.viewWithTag(08)?.removeFromSuperview()
        let background2 = SKSpriteNode(imageNamed: "background_03.png")
        background2.size = (view?.bounds.size)!
        background2.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(background2)
        back()
        }
    func firstscene(){
        removeAllChildren()
        self.view?.viewWithTag(02)?.removeFromSuperview()
        let GameOverScene = FirstScene(size: self.size)
        self.view?.presentScene(GameOverScene)
    }
    func back()  {
        let bottom2:UIButton = UIButton(frame:CGRect(x: self.frame.midX-45, y: self.frame.minY+250, width: 90, height: 30))
        bottom2.setTitle("back", for: .normal)
        bottom2.tag = 02
        bottom2.setTitleColor(SKColor.white, for: .normal)
        bottom2.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        bottom2.setBackgroundImage(UIImage(named:"button.png"), for: .normal)
        bottom2.addTarget(self, action:#selector(firstscene), for:.touchUpInside)
        self.view?.addSubview(bottom2)
    }
    func help()  {
        let bottom8:UIButton = UIButton(frame:CGRect(x: self.frame.midX-45, y: self.frame.minY+335, width: 90, height: 30))
        bottom8.setTitle("help", for: .normal)
        bottom8.tag = 08
        bottom8.setTitleColor(SKColor.white, for: .normal)
        bottom8.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        bottom8.setBackgroundImage(UIImage(named:"button.png"), for: .normal)
        bottom8.addTarget(self, action:#selector(helpPage), for:.touchUpInside)
        self.view?.addSubview(bottom8)
    }
    func helpPage()  {
        removeAllChildren()
        self.view?.viewWithTag(06)?.removeFromSuperview()
        self.view?.viewWithTag(01)?.removeFromSuperview()
        self.view?.viewWithTag(07)?.removeFromSuperview()
        self.view?.viewWithTag(08)?.removeFromSuperview()
        let background4 = SKSpriteNode(imageNamed: "background_06")
        background4.size = (view?.bounds.size)!
        background4.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(background4)
        back()

        
    }
    func allright(){
        let bottom1:UIButton = UIButton(frame:CGRect(x: self.frame.midX-45, y: self.frame.minY+230, width: 90, height: 30))
        bottom1.setTitleColor(SKColor.white, for: .normal)
        bottom1.tag = 01
        bottom1.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        bottom1.setTitle("Copyright", for: .normal)
        bottom1.setBackgroundImage(UIImage(named:"button.png"), for: .normal)
        bottom1.addTarget(self, action:#selector(tapped), for:.touchUpInside)
        self.view?.addSubview(bottom1)
    }
    func creatScene() {
        let backgound1 = SKSpriteNode(imageNamed: "background_01.JPG")
        backgound1.scale(to:(view?.bounds.size)!)
        backgound1.position = CGPoint(x: size.width/2, y: size.height/2)
        backgound1.zPosition = 1
        addChild(backgound1)
        let myLabel = SKLabelNode(fontNamed: "Chalkduster")
        myLabel.name = "label"
        myLabel.text = "War of Coins"
        myLabel.fontColor = SKColor.white
        myLabel.fontSize = 70
        myLabel.zPosition = 2
        myLabel.position = CGPoint(x:self.frame.midX,y:(self.frame.midY + 50))
        self.addChild(myLabel)
    }
    func begin(){
        let bottom6:UIButton = UIButton(frame:CGRect(x: self.frame.midX-45, y: self.frame.minY+265, width: 90, height: 30))
        bottom6.setTitleColor(SKColor.white, for: .normal)
        bottom6.tag = 06
        bottom6.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        bottom6.setTitle("Start Game", for: .normal)
        bottom6.setBackgroundImage(UIImage(named:"button.png"), for: .normal)
        bottom6.addTarget(self, action:#selector(start), for:.touchUpInside)
        self.view?.addSubview(bottom6)
    }
    func bestScore() -> Int {
        return  UserDefaults.standard.integer(forKey:"BestScore")
    }
    
    func setBestScore(bestScore:Int)  {
        UserDefaults.standard.set(bestScore, forKey: "BestScore")
        UserDefaults.standard.synchronize()
    }
    func setUpScorecard()  {
        if SCORE > bestScore(){
            setBestScore(bestScore: SCORE)
        }
        let bottom7:UIButton = UIButton(frame:CGRect(x: self.frame.midX-45, y: self.frame.minY+300, width: 90, height: 30))
        bottom7.setTitleColor(SKColor.white, for: .normal)
        bottom7.tag = 07
        bottom7.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        bottom7.setTitle("Best Score", for: .normal)
        bottom7.setBackgroundImage(UIImage(named:"button.png"), for: .normal)
        bottom7.addTarget(self, action:#selector(displaybestscore), for:.touchUpInside)
        self.view?.addSubview(bottom7)
        
    }
    func displaybestscore()  {
        removeAllChildren()
        self.view?.viewWithTag(06)?.removeFromSuperview()
        self.view?.viewWithTag(01)?.removeFromSuperview()
        self.view?.viewWithTag(07)?.removeFromSuperview()
        self.view?.viewWithTag(08)?.removeFromSuperview()
        let background3 = SKSpriteNode(imageNamed: "background_05")
        background3.size = (view?.bounds.size)!
        background3.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(background3)
        let myLabel4 = SKLabelNode(text: "\(self.bestScore())")
        myLabel4.fontColor = SKColor.white
        myLabel4.fontSize = 30
        myLabel4.position = CGPoint(x: size.width/2-50, y: size.height/2)
        self.addChild(myLabel4)
        back()

    }
    func start(){
        self.view?.viewWithTag(01)?.removeFromSuperview()
        self.view?.viewWithTag(02)?.removeFromSuperview()
        self.view?.viewWithTag(06)?.removeFromSuperview()
        self.view?.viewWithTag(07)?.removeFromSuperview()
        self.view?.viewWithTag(08)?.removeFromSuperview()
        SCORE = 0
        let labelNode = self.childNode(withName: "label")
        let moveUp = SKAction.moveBy(x: 0, y: 100, duration: 0.5)
        let zoom = SKAction.scale(to: 2.0,duration :0.25)
        let pause = SKAction.wait(forDuration: 0.5)
        let fadeAway = SKAction.fadeOut(withDuration: 0.25)
        let remove = SKAction.removeFromParent()
        let movetoSequence = SKAction.sequence([moveUp,zoom,pause,fadeAway,remove])
        labelNode?.run(movetoSequence,completion:{
        let secondScene = Secondscene(size: self.size)
        let doors = SKTransition.doorsOpenVertical(withDuration: 0.5)
        self.view?.presentScene(secondScene,transition:doors)
        } )
    }
}

