import SpriteKit
var HP = 100
var SCORE = 0
var boomTime = 1.0
var coinTime = 0.5
var medicineTime = 5.0

var vector = -20.0
var currentSpeed:CGFloat = 100
class Secondscene: SKScene,SKPhysicsContactDelegate{

    
    
    var rockArr = [SKSpriteNode]()
    var boomArr = [SKSpriteNode]()
    var hpMedicine = [SKSpriteNode]()
    var speedNod = [SKSpriteNode]()
    var poisionArr = [SKSpriteNode]()
    
  
    lazy var run = Run()
    
    override func didMove(to view: SKView) {
        creatScene()
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.categoryBitMask = BitType.scene
        self.physicsBody?.contactTestBitMask = BitType.role
        self.physicsBody?.isDynamic = false
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.usesPreciseCollisionDetection = true
        
    }
    
    func creatScene(){
        background()
        begins()
        turnLeftButton()
        turnRightButton()
        disPlayHP(HP: HP)
        disPlaySCORE(SCORE: SCORE)
        Timer.scheduledTimer(timeInterval: coinTime, target:self,selector:#selector(Secondscene.addRock), userInfo:nil,repeats: true)
        Timer.scheduledTimer(timeInterval: boomTime, target:self,selector:#selector(Secondscene.addBoom), userInfo:nil,repeats: true)
        Timer.scheduledTimer(timeInterval: medicineTime, target:self,selector:#selector(Secondscene.addmedicine), userInfo:nil,repeats: true)
        Timer.scheduledTimer(timeInterval: 10.0, target:self,selector:#selector(Secondscene.addspeed), userInfo:nil,repeats: true)
        Timer.scheduledTimer(timeInterval: 3.0, target:self,selector:#selector(Secondscene.addpoision), userInfo:nil,repeats: true)
      
    
    
    }
    internal func didBegin(_ contact : SKPhysicsContact){
        let boomstart = SKEmitterNode(fileNamed: "boomstart.sks")
       
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (BitType.role | BitType.boom){
            HP = HP - 50
            if HP > 0{
            print("\(HP)")
             self.childNode(withName: "label4")?.removeFromParent()
             scene?.childNode(withName: "boom")?.removeFromParent()
             boomstart?.targetNode = scene
             boomstart?.name = "boomstarted"
             boomstart?.position = contact.contactPoint
             addChild(boomstart!)
             disPlayHP(HP : HP)
            }else{
                gameover(point: SCORE)
            }
        }else if(contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (BitType.role) | (BitType.coin){
            SCORE = SCORE + 100
            print("\(String(describing: SCORE))")
            self.childNode(withName: "label3")?.removeFromParent()
            if contact.bodyA.categoryBitMask == BitType.role{
               contact.bodyB.node?.isHidden = true
            }else{
                contact.bodyA.node?.isHidden = true
            }
            disPlaySCORE(SCORE: SCORE)
            if SCORE < 10000{
                boomTime = boomTime - Double(SCORE/10000)
                coinTime = coinTime + Double(SCORE/10000)
                medicineTime = medicineTime + Double(SCORE/10000)
                vector = vector - Double(SCORE/5000)
            }else if SCORE > 10000{
                boomTime = 0.2
                vector = -25
            }
        }else if(contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (BitType.role) | (BitType.medicine){
            HP = HP + 30
            self.childNode(withName: "label4")?.removeFromParent()
            scene?.childNode(withName: "medicine")?.removeFromParent()
            disPlayHP(HP: HP)
        }else if(contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (BitType.role)|(BitType.speed){
            if currentSpeed < 300{
            currentSpeed = currentSpeed + 50
            scene?.childNode(withName: "speed")?.removeFromParent()
            }else{
                currentSpeed = 300
            }
        }else if(contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (BitType.role)|(BitType.poision){
            currentSpeed -= 30
            scene?.childNode(withName: "poision")?.removeFromParent()
        }
        
    }
    
    func disPlaySCORE(SCORE : Int)  {
        let myLabel3 = SKLabelNode(fontNamed: "Chalkduster")
        myLabel3.name = "label3"
        myLabel3.text = "金币:\(SCORE)"
        myLabel3.fontSize = 20
        myLabel3.fontColor = SKColor.white
        myLabel3.zPosition = 5
        myLabel3.position = CGPoint(x:(scene?.frame.minX)!+80,y:(scene?.frame.maxY)!-50)
        self.addChild(myLabel3)
    }
    
    func disPlayHP(HP : Int)  {
        let myLabel4 = SKLabelNode(fontNamed: "Chalkduster")
        myLabel4.name = "label4"
        myLabel4.text = "生命值:\(HP)"
        myLabel4.fontSize = 20
        myLabel4.fontColor = SKColor.white
        myLabel4.zPosition = 4
        myLabel4.position = CGPoint(x:(scene?.frame.minX)!+80,y:(scene?.frame.maxY)!-100)
        self.addChild(myLabel4)
        
    }
    
    func gameover(point:Int){
        removeAllChildren()
        self.view?.viewWithTag(03)?.removeFromSuperview()
        self.view?.viewWithTag(04)?.removeFromSuperview()
        let GameOverScene = gameOverScene(size: self.size)
        self.view?.presentScene(GameOverScene)
    }
    func background (){
        let backgound2 = SKSpriteNode(imageNamed: "background_02.png")
        backgound2.scale(to:(view?.bounds.size)!)
        backgound2.position = CGPoint(x: size.width/2, y: size.height/2)
        backgound2.zPosition = 1
        addChild(backgound2)
    }
    
    func begins(){
        run.position = CGPoint(x:self.frame.midX,y:self.frame.minY+50)
        run.zPosition = 2
        run.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        run.physicsBody?.isDynamic = false
        run.physicsBody?.affectedByGravity = false
        run.physicsBody?.allowsRotation = false
        run.physicsBody?.usesPreciseCollisionDetection = true
        run.physicsBody?.categoryBitMask = BitType.role
        run.physicsBody?.contactTestBitMask = BitType.boom
        run.physicsBody?.contactTestBitMask = BitType.coin
        run.physicsBody?.contactTestBitMask = BitType.scene
        run.physicsBody?.contactTestBitMask = BitType.medicine
        run.physicsBody?.contactTestBitMask = BitType.speed
        run.physicsBody?.contactTestBitMask = BitType.poision
        run.physicsBody?.collisionBitMask = 0
        print(run.physicsBody?.categoryBitMask as Any)
        self.addChild(run)
        
    }
    func addBoom(){
        let boom = SKSpriteNode(imageNamed: "boom.png")
        boom.position = CGPoint(x: size.width/2, y: size.height/2)
        boom.zPosition = 3
        let w = self.size.width
        let y = self.size.height - 20
        let x = CGFloat(arc4random()).truncatingRemainder(dividingBy: w)
        boom.position = CGPoint(x:x,y:y)
        boom.name = "boom"
        boom.physicsBody = SKPhysicsBody(circleOfRadius: 4)
        boom.physicsBody?.usesPreciseCollisionDetection = true
        boom.physicsBody?.categoryBitMask = BitType.boom
        boom.physicsBody?.contactTestBitMask = BitType.role
        boom.physicsBody?.collisionBitMask = 0
        self.addChild(boom)
        self.boomArr.append(boom)
        boom.physicsBody?.applyForce(CGVector(dx: 0, dy: vector))

        
    }
    func addRock(){
        let coin = SKSpriteNode(imageNamed: "coin.png")
        coin.position = CGPoint(x: size.width/2, y: size.height/2)
        coin.zPosition = 3
        let w = self.size.width
        let y = self.size.height - 20
        let x = CGFloat(arc4random()).truncatingRemainder(dividingBy: w)
        coin.position = CGPoint(x:x,y:y)
        coin.name = "coin"
        coin.physicsBody = SKPhysicsBody(circleOfRadius: 4)
        coin.physicsBody?.usesPreciseCollisionDetection = true
        coin.physicsBody?.categoryBitMask = BitType.coin
        coin.physicsBody?.contactTestBitMask = BitType.role
        coin.physicsBody?.collisionBitMask = 0
        self.addChild(coin)
        self.rockArr.append(coin)
        coin.physicsBody?.applyForce(CGVector(dx: 0, dy: vector))
    }
    func addmedicine(){
        let medicine = SKSpriteNode(imageNamed: "HpMedicine.png")
        medicine.position = CGPoint(x: size.width/2, y: size.height/2)
        medicine.zPosition = 3
        let w = self.size.width
        let y = self.size.height - 20
        let x = CGFloat(arc4random()).truncatingRemainder(dividingBy: w)
        medicine.position = CGPoint(x:x,y:y)
        medicine.name = "medicine"
        medicine.physicsBody = SKPhysicsBody(circleOfRadius: 4)
        medicine.physicsBody?.usesPreciseCollisionDetection = true
        medicine.physicsBody?.categoryBitMask = BitType.medicine
        medicine.physicsBody?.contactTestBitMask = BitType.role
        medicine.physicsBody?.collisionBitMask = 0
        self.addChild(medicine)
        self.hpMedicine.append(medicine)
        medicine.physicsBody?.applyForce(CGVector(dx: 0, dy: vector))
    }
    func addspeed(){
        let speed = SKSpriteNode(imageNamed: "speed.png")
        speed.position = CGPoint(x: size.width/2, y: size.height/2)
        speed.zPosition = 3
        let w = self.size.width
        let y = self.size.height - 20
        let x = CGFloat(arc4random()).truncatingRemainder(dividingBy: w)
        speed.position = CGPoint(x:x,y:y)
        speed.name = "speed"
        speed.physicsBody = SKPhysicsBody(circleOfRadius: 4)
        speed.physicsBody?.usesPreciseCollisionDetection = true
        speed.physicsBody?.categoryBitMask = BitType.speed
        speed.physicsBody?.contactTestBitMask = BitType.role
        speed.physicsBody?.collisionBitMask = 0
        self.addChild(speed)
        self.speedNod.append(speed)
        speed.physicsBody?.applyForce(CGVector(dx: 0, dy: vector))
        
    }
    func addpoision(){
        let poision = SKSpriteNode(imageNamed: "poision.png")
        poision.position = CGPoint(x: size.width/2, y: size.height/2)
        poision.zPosition = 3
        let w = self.size.width
        let y = self.size.height - 20
        let x = CGFloat(arc4random()).truncatingRemainder(dividingBy: w)
        poision.position = CGPoint(x:x,y:y)
        poision.name = "poision"
        poision.physicsBody = SKPhysicsBody(circleOfRadius: 4)
        poision.physicsBody?.usesPreciseCollisionDetection = true
        poision.physicsBody?.categoryBitMask = BitType.poision
        poision.physicsBody?.contactTestBitMask = BitType.role
        poision.physicsBody?.collisionBitMask = 0
        self.addChild(poision)
        self.poisionArr.append(poision)
        poision.physicsBody?.applyForce(CGVector(dx: 0, dy: vector))
    }

    

    func turnLeftButton(){
        let bottom3:UIButton = UIButton(frame:CGRect(x: self.frame.minX, y: self.frame.maxY-100, width: 100, height: 100))
        bottom3.setBackgroundImage(UIImage(named:"runleft.png"), for: .normal)
        
        bottom3.tag = 03
        bottom3.addTarget(self, action:#selector(turnLeft), for:.touchDown)
        self.view?.addSubview(bottom3)
    }
    
    func turnLeft(){
        run.left()
        
            }
    
    func turnRightButton(){
        let bottom4:UIButton = UIButton(frame:CGRect(x: self.frame.maxX-100, y: self.frame.maxY-100, width: 100, height: 100))
        bottom4.setBackgroundImage(UIImage(named:"runright.png"), for: .normal)
        bottom4.tag = 04
        bottom4.addTarget(self, action:#selector(turnRight), for:.touchDown)
        self.view?.addSubview(bottom4)
    }
    
   
    func turnRight(){
     
       run.right()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        for rock in rockArr{
            if rock.position.y<10 {
                rock.removeFromParent()
                rockArr.remove(at: rockArr.index(of: rock)!)
            }
        }
        for boom in boomArr{
            if boom.position.y<10 {
                boom.removeFromParent()
                boomArr.remove(at: boomArr.index(of: boom)!)
            }
        }
        for medic in hpMedicine{
            if medic.position.y<10 {
                medic.removeFromParent()
                hpMedicine.remove(at: hpMedicine.index(of: medic)!)
    }
        }
        for speed in speedNod{
            if speed.position.y<10 {
                speed.removeFromParent()
                speedNod.remove(at: speedNod.index(of: speed)!)
            }
        }
        for posion in poisionArr{
            if posion.position.y<10 {
                posion.removeFromParent()
                poisionArr.remove(at: poisionArr.index(of: posion)!)
            }
        }
        

    }

}

