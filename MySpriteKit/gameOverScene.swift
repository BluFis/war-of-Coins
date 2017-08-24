import SpriteKit
class gameOverScene: SKScene {
    override func didMove(to view: SKView) {
       tapped()
       back()
    }
    func tapped(){
        removeAllChildren()
        let background2 = SKSpriteNode(imageNamed: "background_04.png")
        background2.size = (view?.bounds.size)!
        background2.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(background2)
        let myLabel2 = SKLabelNode(text: "您的得分是\(SCORE)")
        myLabel2.fontColor = SKColor.white
        myLabel2.fontName = "Chalkduster"
        myLabel2.fontSize = 30
        myLabel2.position = CGPoint(x: (scene?.size.width)!/2, y: (scene?.size.height)!/2-100)
        self.addChild(myLabel2)
        
    }
    func backward(){
        HP = 100
        boomTime = 0.5
        coinTime = 0.5
        medicineTime = 5.0
        vector = -1.0
        currentSpeed = 100
        removeAllChildren()
        self.view?.viewWithTag(05)?.removeFromSuperview()
        let GameOverScene = FirstScene(size: self.size)
        self.view?.presentScene(GameOverScene)
    }
    func back()  {
        let bottom5:UIButton = UIButton(frame:CGRect(x: self.frame.minX+100, y: self.frame.minY+50, width: 150, height: 50))
        bottom5.setTitle("返回", for: .normal)
        bottom5.tag = 05
        bottom5.setTitleColor(SKColor.white, for: .normal)
        bottom5.setBackgroundImage(UIImage(named:"button.png"), for: .normal)
        bottom5.addTarget(self, action:#selector(backward), for:.touchUpInside)
        self.view?.addSubview(bottom5)
        
    }
}
