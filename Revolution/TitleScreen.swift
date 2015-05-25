//
//  TitleScreen.swift
//  Revolution
//
//  Created by Aidan Hodge on 11/21/14.
//  Copyright (c) 2014 Ouroboros. All rights reserved.
//

import Foundation
import SpriteKit

class title :SKScene {
    
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let star1 = planet(imageNamed: "titleStar")
    let star2 = planet(imageNamed: "titleStar")
    let titleText = titleImage(imageNamed: "revolution")
    let gravityField = SKFieldNode.radialGravityField()    
    let startButton = SKSpriteNode(imageNamed: "start_button")
    
    override func didMoveToView(view: SKView) {
        
        
        let background = SKSpriteNode(imageNamed: "Space_BG_1b")
        
        background.position = CGPointMake(self.size.width/2, self.size.height/2)
        addChild(background)
        
        
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        let radius = star1.size.width / 2
        
        gravityField.enabled = true;
        gravityField.position = CGPoint(x: 620, y: 400)
        gravityField.strength = 3
        
        addChild(gravityField)
        
        //Title
        
        titleText.position = CGPoint(x: 530, y: 400)
        
        addChild(titleText)
        
        //Star1
        
        star1.physicsBody?.friction = 0
        star1.position = CGPoint(x: 380, y: 400)
        star1.physicsBody?.velocity = CGVectorMake(0, 206)
        star1.physicsBody?.mass = 0
        star1.physicsBody?.linearDamping = 0
        star1.physicsBody?.angularDamping = 0
        
        addChild(star1)
        
        
        
        //Star2
        
        star2.physicsBody?.friction = 0
        star2.position = CGPoint(x: 860,y: 400)
        star2.physicsBody?.velocity = CGVectorMake(0, -206)
        star2.physicsBody?.mass = 0
        star2.physicsBody?.linearDamping = 0
        star2.physicsBody?.angularDamping = 0
        
        addChild(star2)
        
        startButton.zPosition = 1
        startButton.name = "startButton"
        startButton.position = CGPointMake(self.size.width / 1.3, self.size.height / 6)
        addChild(startButton)
        
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        
        for touch: AnyObject in touches{
            let touchLocation = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(touchLocation)
            if (touchedNode.name == "startButton"){
                let reveal = SKTransition.crossFadeWithDuration(1.5)
                let levelSelectSize = CGSizeMake(1334, 750)
                let levelSelectScene = levelSelect(size: levelSelectSize)
                self.view?.presentScene(levelSelectScene, transition: reveal)
            }
            
        }
        
    }
    

    
    
    
    override func update(currentTime: CFTimeInterval) {
        
        
        
        
    }
    
    
}