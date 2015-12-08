

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let catRemaining = 20
    var score = 0
    var catLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var cats = [SKSpriteNode]()
    
    let spriteCategory : UInt32 = 1 << 0
    let groundCategory : UInt32 = 1 << 1
    let blocksCategory : UInt32 = 1 << 2
    let postCategory : UInt32 = 1 << 3
    let biggoalCategory : UInt32 = 1 << 4
    let smallgoalCategory : UInt32 = 1 << 5
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.physicsWorld.contactDelegate = self
        
        makeGround()
        makePosts()
        makeBlocks()
        makeLabels()
        makeGoals()
        
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Game Time!";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
    }
    
    func makeLabels(){
        self.catLabel = SKLabelNode(fontNamed: "AlNile-Bold ")
        self.catLabel.fontColor = UIColor.blueColor()
        self.catLabel.text = "Cats: \(catRemaining)"
        self.catLabel.fontSize = 30
        self.catLabel.position = CGPoint(x: self.frame.size.width * 0.25, y: self.frame.size.height * 0.6)
        self.addChild(self.catLabel)
        
        self.scoreLabel = SKLabelNode(fontNamed: "AlNile-Bold ")
        self.scoreLabel.fontColor = UIColor.blueColor()
        self.scoreLabel.text = "Score: 0"
        self.scoreLabel.fontSize = 30
        self.scoreLabel.position = CGPoint(x: self.frame.size.width * 0.75, y: self.frame.size.height * 0.6)
        self.addChild(self.scoreLabel)
    }
    
    
    func updateLabels(){
        self.catLabel.text = "Cats: \(self.catRemaining - self.cats.count)"
        self.scoreLabel.text = "Score: \(self.score)"
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if self.cats.count >= catRemaining {
                self.removeChildrenInArray(self.cats)
                self.cats = []
                self.score = 0
                updateLabels()
            } else {
            
            let sprite = SKSpriteNode(imageNamed:"cat")
            
            sprite.xScale = 0.15
            sprite.yScale = 0.15
            sprite.position = location
                
                if sprite.position.y > self.frame.size.height * 0.5 {
            
                sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.height / 2)
                sprite.physicsBody?.categoryBitMask = self.spriteCategory
                sprite.physicsBody?.collisionBitMask = self.groundCategory | self.blocksCategory | self.postCategory | self.spriteCategory
                sprite.physicsBody?.contactTestBitMask = self.smallgoalCategory | self.biggoalCategory

                
                self.addChild(sprite)
                self.cats.append(sprite)
                updateLabels()
                }
            }
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == self.smallgoalCategory || contact.bodyB.categoryBitMask == self.smallgoalCategory {
            self.score += 500
        }
        if contact.bodyA.categoryBitMask == self.biggoalCategory || contact.bodyB.categoryBitMask == self.biggoalCategory {
            self.score += 100
        }
        updateLabels()
    }
    
    func makeGoals() {
        let goal0 = SKNode()
        goal0.position = CGPoint(x: self.frame.size.width * 0.12, y: 70)
        goal0.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 45, height: 20))
        goal0.physicsBody?.dynamic = false
        goal0.physicsBody?.categoryBitMask = self.smallgoalCategory
        self.addChild(goal0)
        
        let goal1 = SKNode()
        goal1.position = CGPoint(x: self.frame.size.width * 0.88, y: 70)
        goal1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 45, height: 20))
        goal1.physicsBody?.dynamic = false
        goal1.physicsBody?.categoryBitMask = self.smallgoalCategory
        self.addChild(goal1)
        
        let goal2 = SKNode()
        goal2.position = CGPoint(x: self.frame.size.width * 0.5, y: 50)
        goal2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 145, height: 40))
        goal2.physicsBody?.dynamic = false
        goal2.physicsBody?.categoryBitMask = self.biggoalCategory
        self.addChild(goal2)
    }
    
    func makeGround() {
        let ground = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 150, height: 20))
        ground.position = CGPoint(x: self.frame.size.width / 2, y: 20)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 150, height: 20))
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.categoryBitMask = self.groundCategory
        self.addChild(ground)
        
        let ground1 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 50, height: 10))
        ground1.position = CGPoint(x: self.frame.size.width * 0.88, y: 60)
        ground1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 50, height: 10))
        ground1.physicsBody?.dynamic = false
        ground1.physicsBody?.categoryBitMask = self.groundCategory
        self.addChild(ground1)
        
        let ground2 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 50, height: 10))
        ground2.position = CGPoint(x: self.frame.size.width * 0.12, y: 60)
        ground2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 50, height: 10))
        ground2.physicsBody?.dynamic = false
        ground2.physicsBody?.categoryBitMask = self.groundCategory
        self.addChild(ground2)
        
    }
    
    func makeBlocks() {
        
        let block0 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block0.position = CGPoint(x: self.frame.size.width * 0.12, y: 150)
        block0.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block0.physicsBody?.dynamic = false
        block0.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block0)
        
        let block1 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block1.position = CGPoint(x: self.frame.size.width * 0.88, y: 150)
        block1.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block1.physicsBody?.dynamic = false
        block1.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block1)
        
        let block2 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block2.position = CGPoint(x: self.frame.size.width * 0.40, y: 150)
        block2.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block2.physicsBody?.dynamic = false
        block2.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block2)
        
        let block3 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block3.position = CGPoint(x: self.frame.size.width * 0.60, y: 150)
        block3.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block3.physicsBody?.dynamic = false
        block3.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block3)
        
        ///////
        
        let block4 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block4.position = CGPoint(x: self.frame.size.width * 0.06, y: 200)
        block4.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block4.physicsBody?.dynamic = false
        block4.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block4)
        
        let block5 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block5.position = CGPoint(x: self.frame.size.width * 0.18, y: 200)
        block5.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block5.physicsBody?.dynamic = false
        block5.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block5)
        
        let block6 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block6.position = CGPoint(x: self.frame.size.width * 0.30, y: 200)
        block6.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block6.physicsBody?.dynamic = false
        block6.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block6)
        
        let blockmid = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        blockmid.position = CGPoint(x: self.frame.size.width * 0.50, y: 200)
        blockmid.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        blockmid.physicsBody?.dynamic = false
        blockmid.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(blockmid)
        
        let block7 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block7.position = CGPoint(x: self.frame.size.width * 0.70, y: 200)
        block7.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block7.physicsBody?.dynamic = false
        block7.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block7)
        
        let block8 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block8.position = CGPoint(x: self.frame.size.width * 0.82, y: 200)
        block8.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block8.physicsBody?.dynamic = false
        block8.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block8)
        
        let block9 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block9.position = CGPoint(x: self.frame.size.width * 0.94, y: 200)
        block9.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block9.physicsBody?.dynamic = false
        block9.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block9)
        
        ///
        
        let block10 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block10.position = CGPoint(x: self.frame.size.width * 0.12, y: 250)
        block10.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block10.physicsBody?.dynamic = false
        block10.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block10)
        
        let block11 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block11.position = CGPoint(x: self.frame.size.width * 0.88, y: 250)
        block11.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block11.physicsBody?.dynamic = false
        block11.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block11)
        
        let block12 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block12.position = CGPoint(x: self.frame.size.width * 0.40, y: 250)
        block12.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block12.physicsBody?.dynamic = false
        block12.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block12)
        
        let block13 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block13.position = CGPoint(x: self.frame.size.width * 0.60, y: 250)
        block13.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block13.physicsBody?.dynamic = false
        block13.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block13)
        
        ///
        
        let block14 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block14.position = CGPoint(x: self.frame.size.width * 0.06, y: 300)
        block14.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block14.physicsBody?.dynamic = false
        block14.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block14)
        
        let block15 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block15.position = CGPoint(x: self.frame.size.width * 0.18, y: 300)
        block15.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block15.physicsBody?.dynamic = false
        block15.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block15)
        
        let block16 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block16.position = CGPoint(x: self.frame.size.width * 0.30, y: 300)
        block16.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block16.physicsBody?.dynamic = false
        block16.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block16)
        
        let blockmid2 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        blockmid2.position = CGPoint(x: self.frame.size.width * 0.50, y: 300)
        blockmid2.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        blockmid2.physicsBody?.dynamic = false
        blockmid2.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(blockmid2)
        
        let block17 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block17.position = CGPoint(x: self.frame.size.width * 0.70, y: 300)
        block17.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block17.physicsBody?.dynamic = false
        block17.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block17)
        
        let block18 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block18.position = CGPoint(x: self.frame.size.width * 0.82, y: 300)
        block18.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block18.physicsBody?.dynamic = false
        block18.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block18)
        
        let block19 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 7, height: 7))
        block19.position = CGPoint(x: self.frame.size.width * 0.94, y: 300)
        block19.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        block19.physicsBody?.dynamic = false
        block19.physicsBody?.categoryBitMask = self.blocksCategory
        self.addChild(block19)
    }
    
    func makePosts(){
        
        let postWidth = CGFloat(5)
        let postHeight = CGFloat(70)
        
        let post0 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: postWidth, height: postHeight))
        post0.position = CGPoint(x: self.frame.size.width / 2 - 75, y: 45)
        post0.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: postWidth, height: 80))
        post0.physicsBody?.dynamic = false
        post0.physicsBody?.categoryBitMask = self.postCategory
        self.addChild(post0)
        
        let post1 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: postWidth, height: postHeight))
        post1.position = CGPoint(x: self.frame.size.width / 2 + 75, y: 45)
        post1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: postWidth, height: 80))
        post1.physicsBody?.dynamic = false
        post1.physicsBody?.categoryBitMask = self.postCategory
        self.addChild(post1)
        
        let post2 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: postWidth, height: 40))
        post2.position = CGPoint(x: self.frame.size.width * 0.12 - 25, y: 75)
        post2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: postWidth, height: 35))
        post2.physicsBody?.dynamic = false
        post2.physicsBody?.categoryBitMask = self.postCategory
        self.addChild(post2)
        
        let post3 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: postWidth, height: 40))
        post3.position = CGPoint(x: self.frame.size.width * 0.12 + 25, y: 75)
        post3.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: postWidth, height: 35))
        post3.physicsBody?.dynamic = false
        post3.physicsBody?.categoryBitMask = self.postCategory
        self.addChild(post3)
        
        let post4 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: postWidth, height: 40))
        post4.position = CGPoint(x: self.frame.size.width * 0.88 + 25, y: 75)
        post4.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: postWidth, height: 35))
        post4.physicsBody?.dynamic = false
        post4.physicsBody?.categoryBitMask = self.postCategory
        self.addChild(post4)
        
        let post5 = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: postWidth, height: 40))
        post5.position = CGPoint(x: self.frame.size.width * 0.88 - 25, y: 75)
        post5.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: postWidth, height: 35))
        post5.physicsBody?.dynamic = false
        post5.physicsBody?.categoryBitMask = self.postCategory
        self.addChild(post5)
        
    }

   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
