//
//  GameScene.swift
//  ZombieConga
//
//  Created by John Merki on 10/26/17.
//  Copyright © 2017 John Merki. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "background1")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint.zero
        background.zPosition = -1
        addChild(background)
    }
}


