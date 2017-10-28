//
//  GameScene.swift
//  ZombieConga
//
//  Created by John Merki on 10/26/17.
//  Copyright © 2017 John Merki. All rights reserved.
//

import SpriteKit

let zombie = SKSpriteNode(imageNamed: "zombie1")
let hitIdle = SKSpriteNode(imageNamed: "hit_idle_1")
let background = SKSpriteNode(imageNamed: "background1")

var lastUpdateTime: TimeInterval = 0
var dt: TimeInterval = 0

let zombieMovePointsPerSec: CGFloat = 480.0
let hitMovePointsPerSec: CGFloat = 480.0
var velocity = CGPoint.zero



class GameScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint.zero
        background.zPosition = -1
        addChild(background)
        
        //Zombie Sprite
        //zombie.position = CGPoint(x: 400, y: 400)
        //zombie.setScale(2)
        //addChild(zombie)
        
        //Hit Sprite
        hitIdle.position = CGPoint(x: 400, y: 400)
        hitIdle.setScale(4)
        addChild(hitIdle) 
        
        //Spawn Enemy
        spawnEnemy()
    }

    let playableRect: CGRect
    
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        super.init(size: size)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
                dt = currentTime - lastUpdateTime
            } else {
                dt = 0
            }
        lastUpdateTime = currentTime
        
        //Zombie Move
        //move(sprite: zombie, velocity: velocity)
        //boundsCheckZombie()
        //rotate(sprite: zombie, direction: velocity)
        
        //Hit Move
        move(sprite: hitIdle, velocity: velocity)
        boundsCheckHit()
        rotate(sprite: hitIdle, direction: velocity)
    }
    
    func move(sprite: SKSpriteNode, velocity: CGPoint) {
        let amountToMove = velocity * CGFloat(dt)
        print("Amount to move: \(amountToMove)")
        sprite.position += amountToMove
    }
    
    func moveZombieToward(location: CGPoint) {
        let offset = location - zombie.position
        let length = offset.length()
        let direction = offset.normalized()
        velocity = direction * zombieMovePointsPerSec
    }
    
    func moveHitToward(location: CGPoint) {
        let offset = location - hitIdle.position
        let length = offset.length()
        let direction = offset.normalized()
        velocity = direction * hitMovePointsPerSec
    }
    
    func spawnEnemy() {
        //Initialize Enemy Sprite
        let enemy = SKSpriteNode(imageNamed: "enemy")
        enemy.position = CGPoint(x: size.width + enemy.size.width/2, y: size.height/2)
        enemy.setScale(4)
        addChild(enemy)
        
        //Enemy Sprite Movement Straight Line
        //let actionMove = SKAction.move(to: CGPoint(x: -enemy.size.width/2, y: enemy.position.y), duration: 2.0)
        //enemy.run(actionMove)
        
        //Enemy Sprite Movement V Shape
        let actionMidMove = SKAction.move(to: CGPoint(x: size.width/2, y: playableRect.minY + enemy.size.height/2), duration: 1.0)
        let actionMove = SKAction.move(to: CGPoint(x: -enemy.size.width/2, y: enemy.position.y), duration: 1.0)
        let sequence = SKAction.sequence([actionMidMove, actionMove])
        enemy.run(sequence)
        
    }
    
    func sceneTouched(touchLocation:CGPoint) {
        //moveZombieToward(location: touchLocation)
        moveHitToward(location: touchLocation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
    func boundsCheckZombie() {
        let bottomLeft = CGPoint(x: 0, y: playableRect.minY)
        let topRight = CGPoint(x: size.width, y: playableRect.maxY)
        
        if zombie.position.x <= bottomLeft.x {
            zombie.position.x = bottomLeft.x
            velocity.x = -velocity.x
        }
        if zombie.position.x >= topRight.x {
            zombie.position.x = topRight.x
            velocity.x = -velocity.x
        }
        if zombie.position.y <= bottomLeft.y {
            zombie.position.y = bottomLeft.y
            velocity.y = -velocity.y
        }
        if zombie.position.y >= topRight.y {
            zombie.position.y = topRight.y
            velocity.y = -velocity.y
        }
    }
    
    func boundsCheckHit() {
        let bottomLeft = CGPoint(x: 0, y: playableRect.minY)
        let topRight = CGPoint(x: size.width, y: playableRect.maxY)
        
        if hitIdle.position.x <= bottomLeft.x {
            hitIdle.position.x = bottomLeft.x
            velocity.x = -velocity.x
        }
        if hitIdle.position.x >= topRight.x {
            hitIdle.position.x = topRight.x
            velocity.x = -velocity.x
        }
        if hitIdle.position.y <= bottomLeft.y {
            hitIdle.position.y = bottomLeft.y
            velocity.y = -velocity.y
        }
        if hitIdle.position.y >= topRight.y {
            hitIdle.position.y = topRight.y
            velocity.y = -velocity.y
        }
    }
    
    func rotate(sprite: SKSpriteNode, direction: CGPoint) {
        sprite.zRotation = CGFloat(direction.angle)
        
    }
    
}


