//
//  Level3.swift
//  Revolution
//
//  Created by Cristian Alonso on 11/25/14.
//  Copyright (c) 2014 Ouroboros. All rights reserved.
//

import Foundation
import SpriteKit

class level3 :SKScene {
    
        
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func handlePanGesture(panGesture: UIPanGestureRecognizer){
        
        
        
        
        
        if panGesture.state == UIGestureRecognizerState.Began {
            
            bgTile1.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile2.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile3.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile4.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile5.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile6.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile7.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile8.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile9.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile10.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile11.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile12.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile13.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile14.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile15.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile16.physicsBody?.velocity = CGVectorMake(0, 0)
            
            
        }
        
        
        
        
        
        
        
        
        
        if panGesture.state == UIGestureRecognizerState.Changed{
            
            
            var deltaPoint = panRecognizer?.translationInView(self.view!)
            
            
            if bgTile1.position.x + deltaPoint!.x > self.size.width / 2 {
                
                deltaPoint!.x = self.size.width / 2 - bgTile1.position.x
                
            }
                
            else if bgTile4.position.x + deltaPoint!.x < self.size.width / 2 {
                
                deltaPoint!.x = self.size.width / 2 - bgTile4.position.x
                
            }
            
            
            bgTile1.position.x = bgTile1.position.x + deltaPoint!.x
            bgTile2.position.x = bgTile2.position.x + deltaPoint!.x
            bgTile3.position.x = bgTile3.position.x + deltaPoint!.x
            bgTile4.position.x = bgTile4.position.x + deltaPoint!.x
            bgTile5.position.x = bgTile5.position.x + deltaPoint!.x
            bgTile6.position.x = bgTile6.position.x + deltaPoint!.x
            bgTile7.position.x = bgTile7.position.x + deltaPoint!.x
            bgTile8.position.x = bgTile8.position.x + deltaPoint!.x
            bgTile9.position.x = bgTile9.position.x + deltaPoint!.x
            bgTile10.position.x = bgTile10.position.x + deltaPoint!.x
            bgTile11.position.x = bgTile11.position.x + deltaPoint!.x
            bgTile12.position.x = bgTile12.position.x + deltaPoint!.x
            bgTile13.position.x = bgTile13.position.x + deltaPoint!.x
            bgTile14.position.x = bgTile14.position.x + deltaPoint!.x
            bgTile15.position.x = bgTile15.position.x + deltaPoint!.x
            bgTile16.position.x = bgTile16.position.x + deltaPoint!.x
            
            
            
            if bgTile1.position.y - deltaPoint!.y < self.size.height / 2 {
                
                deltaPoint!.y = self.size.height / 2 - bgTile1.position.y
                
            }
                
            else if bgTile13.position.y - deltaPoint!.y > self.size.height / 2 {
                deltaPoint!.y = self.size.height / 2 - bgTile13.position.y
            }
            
            
            bgTile1.position.y = bgTile1.position.y - deltaPoint!.y
            bgTile2.position.y = bgTile2.position.y - deltaPoint!.y
            bgTile3.position.y = bgTile3.position.y - deltaPoint!.y
            bgTile4.position.y = bgTile4.position.y - deltaPoint!.y
            bgTile5.position.y = bgTile5.position.y - deltaPoint!.y
            bgTile6.position.y = bgTile6.position.y - deltaPoint!.y
            bgTile7.position.y = bgTile7.position.y - deltaPoint!.y
            bgTile8.position.y = bgTile8.position.y - deltaPoint!.y
            bgTile9.position.y = bgTile9.position.y - deltaPoint!.y
            bgTile10.position.y = bgTile10.position.y - deltaPoint!.y
            bgTile11.position.y = bgTile11.position.y - deltaPoint!.y
            bgTile12.position.y = bgTile12.position.y - deltaPoint!.y
            bgTile13.position.y = bgTile13.position.y - deltaPoint!.y
            bgTile14.position.y = bgTile14.position.y - deltaPoint!.y
            bgTile15.position.y = bgTile15.position.y - deltaPoint!.y
            bgTile16.position.y = bgTile16.position.y - deltaPoint!.y
            
            
            
            
            
            
            panGesture.setTranslation(CGPointZero, inView: self.view)
            
        }
        
        var finalVelocityStorage = panGesture.velocityInView(self.view)
        
        if panGesture.state == UIGestureRecognizerState.Ended {
           println(finalVelocityStorage)
            
            
            bgTile1.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile2.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile3.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile4.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile5.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile6.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile7.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile8.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile9.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile10.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile11.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile12.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile13.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile14.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile15.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile16.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    var panRecognizer: UIPanGestureRecognizer?
    
    
    
    
    
    //Creating the Tiled Background Nodes
    
    let bgTile1 = SKSpriteNode(imageNamed: "HDHR_Space_BG1")
    let bgTile2 = SKSpriteNode(imageNamed: "HDHR_Space_BG2")
    let bgTile3 = SKSpriteNode(imageNamed: "HDHR_Space_BG3")
    let bgTile4 = SKSpriteNode(imageNamed: "HDHR_Space_BG4")
    let bgTile5 = SKSpriteNode(imageNamed: "HDHR_Space_BG5")
    let bgTile6 = SKSpriteNode(imageNamed: "HDHR_Space_BG6")
    let bgTile7 = SKSpriteNode(imageNamed: "HDHR_Space_BG7")
    let bgTile8 = SKSpriteNode(imageNamed: "HDHR_Space_BG8")
    let bgTile9 = SKSpriteNode(imageNamed: "HDHR_Space_BG9")
    let bgTile10 = SKSpriteNode(imageNamed: "HDHR_Space_BG10")
    let bgTile11 = SKSpriteNode(imageNamed: "HDHR_Space_BG11")
    let bgTile12 = SKSpriteNode(imageNamed: "HDHR_Space_BG12")
    let bgTile13 = SKSpriteNode(imageNamed: "HDHR_Space_BG13")
    let bgTile14 = SKSpriteNode(imageNamed: "HDHR_Space_BG14")
    let bgTile15 = SKSpriteNode(imageNamed: "HDHR_Space_BG15")
    let bgTile16 = SKSpriteNode(imageNamed: "HDHR_Space_BG16")
    
    
    
    override func didMoveToView(view: SKView) {
        
        
        
        bgTile1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile3.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile4.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile5.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile6.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile7.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile8.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile9.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile10.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile11.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile12.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile13.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile14.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile15.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile16.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        
        
        
        bgTile1.physicsBody?.dynamic = true
        bgTile2.physicsBody?.dynamic = true
        bgTile3.physicsBody?.dynamic = true
        bgTile4.physicsBody?.dynamic = true
        bgTile5.physicsBody?.dynamic = true
        bgTile6.physicsBody?.dynamic = true
        bgTile7.physicsBody?.dynamic = true
        bgTile8.physicsBody?.dynamic = true
        bgTile9.physicsBody?.dynamic = true
        bgTile10.physicsBody?.dynamic = true
        bgTile11.physicsBody?.dynamic = true
        bgTile12.physicsBody?.dynamic = true
        bgTile13.physicsBody?.dynamic = true
        bgTile14.physicsBody?.dynamic = true
        bgTile15.physicsBody?.dynamic = true
        bgTile16.physicsBody?.dynamic = true
        
        
        
        
        
        
        
        
        //Adding the Tiled Background
        
        
        bgTile1.position = CGPointMake(-1334, 1500)
        bgTile2.position = CGPointMake(0, 1500)
        bgTile3.position = CGPointMake(1334, 1500)
        bgTile4.position = CGPointMake(2668, 1500)
        bgTile5.position = CGPointMake(-1334, 750)
        bgTile6.position = CGPointMake(0, 750)
        bgTile7.position = CGPointMake(1334, 750)
        bgTile8.position = CGPointMake(2668, 750)
        bgTile9.position = CGPointMake(-1334, 0)
        bgTile10.position = CGPointMake(0, 0)
        bgTile11.position = CGPointMake(1334, 0)
        bgTile12.position = CGPointMake(2668, 0)
        bgTile13.position = CGPointMake(-1334, -750)
        bgTile14.position = CGPointMake(0, -750)
        bgTile15.position = CGPointMake(1334, -750)
        bgTile16.position = CGPointMake(2668, -750)
        
        
        
        bgTile1.zPosition = 0
        bgTile2.zPosition = 0
        bgTile3.zPosition = 0
        bgTile4.zPosition = 0
        bgTile5.zPosition = 0
        bgTile6.zPosition = 0
        bgTile7.zPosition = 0
        bgTile8.zPosition = 0
        bgTile9.zPosition = 0
        bgTile10.zPosition = 0
        bgTile11.zPosition = 0
        bgTile12.zPosition = 0
        bgTile13.zPosition = 0
        bgTile14.zPosition = 0
        bgTile15.zPosition = 0
        bgTile16.zPosition = 0
        
        bgTile1.name = "bgTile1"
        bgTile2.name = "bgTile2"
        bgTile3.name = "bgTile3"
        bgTile4.name = "bgTile4"
        bgTile5.name = "bgTile5"
        bgTile6.name = "bgTile6"
        bgTile7.name = "bgTile7"
        bgTile8.name = "bgTile8"
        bgTile9.name = "bgTile9"
        bgTile10.name = "bgTile10"
        bgTile11.name = "bgTile11"
        bgTile12.name = "bgTile12"
        bgTile13.name = "bgTile13"
        bgTile14.name = "bgTile14"
        bgTile15.name = "bgTile15"
        bgTile16.name = "bgTile16"
        
        
        addChild(bgTile1)
        addChild(bgTile2)
        addChild(bgTile3)
        addChild(bgTile4)
        addChild(bgTile5)
        addChild(bgTile6)
        addChild(bgTile7)
        addChild(bgTile8)
        addChild(bgTile9)
        addChild(bgTile10)
        addChild(bgTile11)
        addChild(bgTile12)
        addChild(bgTile13)
        addChild(bgTile14)
        addChild(bgTile15)
        addChild(bgTile16)
        
        
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
    
                
        panRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        panRecognizer?.minimumNumberOfTouches = 2
        panRecognizer?.maximumNumberOfTouches = 2
        self.view?.addGestureRecognizer(panRecognizer!)
    
    
    
    
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if touches.count == 2 {
        
        bgTile1.physicsBody?.velocity = CGVectorMake(0, 0)
        bgTile2.physicsBody?.velocity = CGVectorMake(0, 0)
        bgTile3.physicsBody?.velocity = CGVectorMake(0, 0)
        bgTile4.physicsBody?.velocity = CGVectorMake(0, 0)
        bgTile5.physicsBody?.velocity = CGVectorMake(0, 0)
        bgTile6.physicsBody?.velocity = CGVectorMake(0, 0)
        bgTile7.physicsBody?.velocity = CGVectorMake(0, 0)
        bgTile8.physicsBody?.velocity = CGVectorMake(0, 0)
        bgTile9.physicsBody?.velocity = CGVectorMake(0, 0)
        bgTile10.physicsBody?.velocity = CGVectorMake(0, 0)
        bgTile11.physicsBody?.velocity = CGVectorMake(0, 0)
        bgTile12.physicsBody?.velocity = CGVectorMake(0, 0)
        bgTile13.physicsBody?.velocity = CGVectorMake(0, 0)
        bgTile14.physicsBody?.velocity = CGVectorMake(0, 0)
        bgTile15.physicsBody?.velocity = CGVectorMake(0, 0)
        bgTile16.physicsBody?.velocity = CGVectorMake(0, 0)
        
        }
        
    }
    
    
    
    
    
    
    
    
    override func update(currentTime: CFTimeInterval) {
        
        var decellerationConst:CGFloat = 7
        
        
        if bgTile1.physicsBody?.velocity.dx > decellerationConst {
            
            bgTile1.physicsBody?.velocity.dx -= decellerationConst
            bgTile2.physicsBody?.velocity.dx -= decellerationConst
            bgTile3.physicsBody?.velocity.dx -= decellerationConst
            bgTile4.physicsBody?.velocity.dx -= decellerationConst
            bgTile5.physicsBody?.velocity.dx -= decellerationConst
            bgTile6.physicsBody?.velocity.dx -= decellerationConst
            bgTile7.physicsBody?.velocity.dx -= decellerationConst
            bgTile8.physicsBody?.velocity.dx -= decellerationConst
            bgTile9.physicsBody?.velocity.dx -= decellerationConst
            bgTile10.physicsBody?.velocity.dx -= decellerationConst
            bgTile11.physicsBody?.velocity.dx -= decellerationConst
            bgTile12.physicsBody?.velocity.dx -= decellerationConst
            bgTile13.physicsBody?.velocity.dx -= decellerationConst
            bgTile14.physicsBody?.velocity.dx -= decellerationConst
            bgTile15.physicsBody?.velocity.dx -= decellerationConst
            bgTile16.physicsBody?.velocity.dx -= decellerationConst
        }
        else if bgTile1.physicsBody?.velocity.dx <= decellerationConst && bgTile1.physicsBody?.velocity.dx > 0 {
            bgTile1.physicsBody?.velocity.dx = 0
            bgTile2.physicsBody?.velocity.dx = 0
            bgTile3.physicsBody?.velocity.dx = 0
            bgTile4.physicsBody?.velocity.dx = 0
            bgTile5.physicsBody?.velocity.dx = 0
            bgTile6.physicsBody?.velocity.dx = 0
            bgTile7.physicsBody?.velocity.dx = 0
            bgTile8.physicsBody?.velocity.dx = 0
            bgTile9.physicsBody?.velocity.dx = 0
            bgTile10.physicsBody?.velocity.dx = 0
            bgTile11.physicsBody?.velocity.dx = 0
            bgTile12.physicsBody?.velocity.dx = 0
            bgTile13.physicsBody?.velocity.dx = 0
            bgTile14.physicsBody?.velocity.dx = 0
            bgTile15.physicsBody?.velocity.dx = 0
            bgTile16.physicsBody?.velocity.dx = 0
            
        }
        else if bgTile1.physicsBody?.velocity.dx >= -decellerationConst && bgTile1.physicsBody?.velocity.dx < 0 {
            bgTile1.physicsBody?.velocity.dx = 0
            bgTile2.physicsBody?.velocity.dx = 0
            bgTile3.physicsBody?.velocity.dx = 0
            bgTile4.physicsBody?.velocity.dx = 0
            bgTile5.physicsBody?.velocity.dx = 0
            bgTile6.physicsBody?.velocity.dx = 0
            bgTile7.physicsBody?.velocity.dx = 0
            bgTile8.physicsBody?.velocity.dx = 0
            bgTile9.physicsBody?.velocity.dx = 0
            bgTile10.physicsBody?.velocity.dx = 0
            bgTile11.physicsBody?.velocity.dx = 0
            bgTile12.physicsBody?.velocity.dx = 0
            bgTile13.physicsBody?.velocity.dx = 0
            bgTile14.physicsBody?.velocity.dx = 0
            bgTile15.physicsBody?.velocity.dx = 0
            bgTile16.physicsBody?.velocity.dx = 0
        }
        else if bgTile1.physicsBody?.velocity.dx < -decellerationConst {
            bgTile1.physicsBody?.velocity.dx += decellerationConst
            bgTile2.physicsBody?.velocity.dx += decellerationConst
            bgTile3.physicsBody?.velocity.dx += decellerationConst
            bgTile4.physicsBody?.velocity.dx += decellerationConst
            bgTile5.physicsBody?.velocity.dx += decellerationConst
            bgTile6.physicsBody?.velocity.dx += decellerationConst
            bgTile7.physicsBody?.velocity.dx += decellerationConst
            bgTile8.physicsBody?.velocity.dx += decellerationConst
            bgTile9.physicsBody?.velocity.dx += decellerationConst
            bgTile10.physicsBody?.velocity.dx += decellerationConst
            bgTile11.physicsBody?.velocity.dx += decellerationConst
            bgTile12.physicsBody?.velocity.dx += decellerationConst
            bgTile13.physicsBody?.velocity.dx += decellerationConst
            bgTile14.physicsBody?.velocity.dx += decellerationConst
            bgTile15.physicsBody?.velocity.dx += decellerationConst
            bgTile16.physicsBody?.velocity.dx += decellerationConst
        }
        
        if bgTile1.physicsBody?.velocity.dy > decellerationConst {
            
            bgTile1.physicsBody?.velocity.dy -= decellerationConst
            bgTile2.physicsBody?.velocity.dy -= decellerationConst
            bgTile3.physicsBody?.velocity.dy -= decellerationConst
            bgTile4.physicsBody?.velocity.dy -= decellerationConst
            bgTile5.physicsBody?.velocity.dy -= decellerationConst
            bgTile6.physicsBody?.velocity.dy -= decellerationConst
            bgTile7.physicsBody?.velocity.dy -= decellerationConst
            bgTile8.physicsBody?.velocity.dy -= decellerationConst
            bgTile9.physicsBody?.velocity.dy -= decellerationConst
            bgTile10.physicsBody?.velocity.dy -= decellerationConst
            bgTile11.physicsBody?.velocity.dy -= decellerationConst
            bgTile12.physicsBody?.velocity.dy -= decellerationConst
            bgTile13.physicsBody?.velocity.dy -= decellerationConst
            bgTile14.physicsBody?.velocity.dy -= decellerationConst
            bgTile15.physicsBody?.velocity.dy -= decellerationConst
            bgTile16.physicsBody?.velocity.dy -= decellerationConst
        }
        else if bgTile1.physicsBody?.velocity.dy <= decellerationConst && bgTile1.physicsBody?.velocity.dy > 0 {
            bgTile1.physicsBody?.velocity.dy = 0
            bgTile2.physicsBody?.velocity.dy = 0
            bgTile3.physicsBody?.velocity.dy = 0
            bgTile4.physicsBody?.velocity.dy = 0
            bgTile5.physicsBody?.velocity.dy = 0
            bgTile6.physicsBody?.velocity.dy = 0
            bgTile7.physicsBody?.velocity.dy = 0
            bgTile8.physicsBody?.velocity.dy = 0
            bgTile9.physicsBody?.velocity.dy = 0
            bgTile10.physicsBody?.velocity.dy = 0
            bgTile11.physicsBody?.velocity.dy = 0
            bgTile12.physicsBody?.velocity.dy = 0
            bgTile13.physicsBody?.velocity.dy = 0
            bgTile14.physicsBody?.velocity.dy = 0
            bgTile15.physicsBody?.velocity.dy = 0
            bgTile16.physicsBody?.velocity.dy = 0
            
        }
        else if bgTile1.physicsBody?.velocity.dy >= -decellerationConst && bgTile1.physicsBody?.velocity.dy < 0 {
            bgTile1.physicsBody?.velocity.dy = 0
            bgTile2.physicsBody?.velocity.dy = 0
            bgTile3.physicsBody?.velocity.dy = 0
            bgTile4.physicsBody?.velocity.dy = 0
            bgTile5.physicsBody?.velocity.dy = 0
            bgTile6.physicsBody?.velocity.dy = 0
            bgTile7.physicsBody?.velocity.dy = 0
            bgTile8.physicsBody?.velocity.dy = 0
            bgTile9.physicsBody?.velocity.dy = 0
            bgTile10.physicsBody?.velocity.dy = 0
            bgTile11.physicsBody?.velocity.dy = 0
            bgTile12.physicsBody?.velocity.dy = 0
            bgTile13.physicsBody?.velocity.dy = 0
            bgTile14.physicsBody?.velocity.dy = 0
            bgTile15.physicsBody?.velocity.dy = 0
            bgTile16.physicsBody?.velocity.dy = 0
        }
        else if bgTile1.physicsBody?.velocity.dy < -decellerationConst {
            bgTile1.physicsBody?.velocity.dy += decellerationConst
            bgTile2.physicsBody?.velocity.dy += decellerationConst
            bgTile3.physicsBody?.velocity.dy += decellerationConst
            bgTile4.physicsBody?.velocity.dy += decellerationConst
            bgTile5.physicsBody?.velocity.dy += decellerationConst
            bgTile6.physicsBody?.velocity.dy += decellerationConst
            bgTile7.physicsBody?.velocity.dy += decellerationConst
            bgTile8.physicsBody?.velocity.dy += decellerationConst
            bgTile9.physicsBody?.velocity.dy += decellerationConst
            bgTile10.physicsBody?.velocity.dy += decellerationConst
            bgTile11.physicsBody?.velocity.dy += decellerationConst
            bgTile12.physicsBody?.velocity.dy += decellerationConst
            bgTile13.physicsBody?.velocity.dy += decellerationConst
            bgTile14.physicsBody?.velocity.dy += decellerationConst
            bgTile15.physicsBody?.velocity.dy += decellerationConst
            bgTile16.physicsBody?.velocity.dy += decellerationConst
        }

        
        
        
        if bgTile1.position.x - bgTile1.size.width/2 > 0 {
            
            bgTile1.position.x = bgTile1.size.width/2
            bgTile5.position.x = bgTile1.position.x
            bgTile9.position.x = bgTile5.position.x
            bgTile13.position.x = bgTile9.position.x
            bgTile2.position.x = bgTile1.position.x + bgTile1.size.width
            bgTile6.position.x = bgTile2.position.x
            bgTile10.position.x = bgTile6.position.x
            bgTile14.position.x = bgTile10.position.x
            bgTile3.position.x = bgTile2.position.x + bgTile2.size.width
            bgTile7.position.x = bgTile3.position.x
            bgTile11.position.x = bgTile7.position.x
            bgTile15.position.x = bgTile11.position.x
            bgTile4.position.x = bgTile3.position.x + bgTile3.size.width
            bgTile8.position.x = bgTile4.position.x
            bgTile12.position.x = bgTile8.position.x
            bgTile16.position.x = bgTile12.position.x
            
            
            
            bgTile1.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile2.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile3.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile4.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile5.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile6.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile7.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile8.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile9.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile10.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile11.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile12.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile13.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile14.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile15.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile16.physicsBody?.velocity = CGVectorMake(0, 0)
            
            
        }
        
        if bgTile1.position.y + bgTile1.size.height/2 < 750 {
            
            bgTile1.position.y = 750 - bgTile1.size.height/2
            bgTile2.position.y = bgTile1.position.y
            bgTile3.position.y = bgTile2.position.y
            bgTile4.position.y = bgTile3.position.y
            bgTile5.position.y = bgTile1.position.y - bgTile1.size.height
            bgTile6.position.y = bgTile5.position.y
            bgTile7.position.y = bgTile6.position.y
            bgTile8.position.y = bgTile7.position.y
            bgTile9.position.y = bgTile5.position.y - bgTile5.size.height
            bgTile10.position.y = bgTile9.position.y
            bgTile11.position.y = bgTile10.position.y
            bgTile12.position.y = bgTile11.position.y
            bgTile13.position.y = bgTile9.position.y - bgTile9.size.height
            bgTile14.position.y = bgTile13.position.y
            bgTile15.position.y = bgTile14.position.y
            bgTile16.position.y = bgTile15.position.y
            
            
            
            bgTile1.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile2.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile3.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile4.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile5.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile6.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile7.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile8.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile9.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile10.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile11.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile12.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile13.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile14.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile15.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile16.physicsBody?.velocity = CGVectorMake(0, 0)
        }
        
        if bgTile16.position.x + bgTile16.size.width/2 < 1334 {
            
            bgTile16.position.x = 1334 - bgTile16.size.width/2
            bgTile12.position.x = bgTile16.position.x
            bgTile8.position.x = bgTile12.position.x
            bgTile4.position.x = bgTile8.position.x
            bgTile15.position.x = bgTile16.position.x - bgTile16.size.width
            bgTile11.position.x = bgTile15.position.x
            bgTile7.position.x = bgTile11.position.x
            bgTile3.position.x = bgTile7.position.x
            bgTile14.position.x = bgTile15.position.x - bgTile15.size.width
            bgTile10.position.x = bgTile14.position.x
            bgTile6.position.x = bgTile10.position.x
            bgTile2.position.x = bgTile6.position.x
            bgTile13.position.x = bgTile14.position.x - bgTile14.size.width
            bgTile9.position.x = bgTile13.position.x
            bgTile5.position.x = bgTile9.position.x
            bgTile1.position.x = bgTile5.position.x
            
            
            
            
            bgTile1.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile2.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile3.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile4.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile5.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile6.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile7.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile8.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile9.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile10.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile11.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile12.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile13.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile14.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile15.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile16.physicsBody?.velocity = CGVectorMake(0, 0)
            
        }
        
        if bgTile16.position.y - bgTile16.size.height/2 > 0 {
            
            bgTile16.position.y = bgTile16.size.height/2
            bgTile15.position.y = bgTile16.position.y
            bgTile14.position.y = bgTile15.position.y
            bgTile13.position.y = bgTile14.position.y
            bgTile12.position.y = bgTile16.position.y + bgTile16.size.height
            bgTile11.position.y = bgTile12.position.y
            bgTile10.position.y = bgTile11.position.y
            bgTile9.position.y = bgTile10.position.y
            bgTile8.position.y = bgTile12.position.y + bgTile12.size.height
            bgTile7.position.y = bgTile8.position.y
            bgTile6.position.y = bgTile7.position.y
            bgTile5.position.y = bgTile6.position.y
            bgTile4.position.y = bgTile8.position.y + bgTile8.size.height
            bgTile3.position.y = bgTile4.position.y
            bgTile2.position.y = bgTile3.position.y
            bgTile1.position.y = bgTile2.position.y
            
            
            
            bgTile1.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile2.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile3.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile4.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile5.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile6.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile7.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile8.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile9.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile10.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile11.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile12.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile13.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile14.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile15.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile16.physicsBody?.velocity = CGVectorMake(0, 0)
        }
 
        
        
        
        
    }
    
    
}
