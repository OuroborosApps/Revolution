//
//  LevelSelectTrial.swift
//  Revolution
//
//  Created by Cristian Alonso on 12/5/14.
//  Copyright (c) 2014 Ouroboros. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class levelSelectTrial :SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    
    
    struct PhysicsCategory {
        static let None : UInt32 = 0
        static let All : UInt32 = UInt32.max
        static let viewer : UInt32 = 0b1
        
    }
    
    
    
    var currentNode: SKNode?
    var nextNode: SKNode?
    var releaseVelocity: CGPoint?
    
    var decelConst:CGFloat = 0
    var decelConst2:CGFloat = 0
    
    var isSwiping = false
    var hasSlid = false
    var calcOnce = false
    var hasSlidIn = false
    var blockedSlide = false
    var calcBlockedSlide = false
    
    var panGestureRecognizer: UIPanGestureRecognizer?
    
    var centerPoint: CGPoint?
    
    let background = SKSpriteNode(imageNamed: "Space_BG_1b")
    
    let viewer1 = SKSpriteNode(imageNamed: "planetLevelViewer1")
    let viewer2 = SKSpriteNode(imageNamed: "planetLevelViewer2")
    let viewer3 = SKSpriteNode(imageNamed: "planetLevelViewer3")
    let viewer4 = SKSpriteNode(imageNamed: "planetLevelViewer4")
    let viewer5 = SKSpriteNode(imageNamed: "planetLevelViewer5")
    let viewer6 = SKSpriteNode(imageNamed: "planetLevelViewer6")
    let viewer7 = SKSpriteNode(imageNamed: "planetLevelViewer7")
    let viewer8 = SKSpriteNode(imageNamed: "planetLevelViewer8")
    let viewer9 = SKSpriteNode(imageNamed: "planetLevelViewer9")
    let viewer10 = SKSpriteNode(imageNamed: "planetLevelViewer10")
    
   
    
    
    
    var levelIndex:CGFloat = 1
    
    
    
    
    
    
    
    
        
    func handlePanGesture(gesture: UIPanGestureRecognizer){
        
        if !isSwiping {
        
            isSwiping = true
        
        
        if gesture.state == UIGestureRecognizerState.Began{
            println("reset")
          centerPoint = CGPointMake(self.size.width / 2, self.size.height / 2)
          println(centerPoint)
            currentNode = nodeAtPoint(centerPoint!)
            
        }
        
        
            
            
        var newPointTemp = panGestureRecognizer?.translationInView(self.view!)
        var newPoint = convertPointFromView(newPointTemp!)
        
            
        currentNode!.position.x = currentNode!.position.x + newPoint.x
        
            
            
        gesture.setTranslation(CGPointZero, inView: self.view)
            
        
        
         releaseVelocity = gesture.velocityInView(self.view)
        
        
        
        
        if gesture.state == UIGestureRecognizerState.Ended{
            
            
            
            if  releaseVelocity!.x > 600 {
                
                
                if levelIndex > 1 {
                    println("a")
                    
                    calcOnce = true
                    hasSlid = true
                    hasSlidIn = true
                    
                    currentNode?.physicsBody?.velocity.dx = releaseVelocity!.x
                    nextNode = nodeAtPoint(CGPointMake(-viewer1.size.width, self.size.height / 2))
                    nextNode?.physicsBody?.velocity.dx = releaseVelocity!.x
                    levelIndex--
                    currentNode?.zPosition = 12 - levelIndex
                
                }
                else {
                    println("b")
                    blockedSlide = true
                    calcBlockedSlide = true
                    currentNode?.physicsBody?.velocity.dx = releaseVelocity!.x
                    
                    
                }
                
            }
            
            else if releaseVelocity!.x < -600 {
                
                if levelIndex < 10 {
                    println("c")
                    calcOnce = true
                    hasSlid = true
                    hasSlidIn = true
                    nextNode = nodeAtPoint(CGPointMake(self.size.width + viewer1.size.width, self.size.height / 2))
                    currentNode?.physicsBody?.velocity.dx = releaseVelocity!.x
                    nextNode?.physicsBody?.velocity.dx = releaseVelocity!.x
                    levelIndex++
                    nextNode?.zPosition = levelIndex
                    
                }
                else {
                    println("d")
                    blockedSlide = true
                    calcBlockedSlide = true
                    currentNode?.physicsBody?.velocity.dx = releaseVelocity!.x
                }
            }
            
            else if currentNode!.position.x < self.size.width / 4  {
                
                if levelIndex < 10 {
                    println("e")
                    calcOnce = true
                    hasSlid = true
                    hasSlidIn = true
                    nextNode = nodeAtPoint(CGPointMake(self.size.width + viewer1.size.width, self.size.height / 2))
                    currentNode?.physicsBody?.velocity.dx = -750
                    nextNode?.physicsBody?.velocity.dx = -750
                    levelIndex++
                    nextNode?.zPosition = levelIndex
                    
                }
                else {
                    println("f")
                    blockedSlide = true
                    calcBlockedSlide = true
                    currentNode?.physicsBody?.velocity.dx = releaseVelocity!.x
                }
                
                
                
            }
            
            else if currentNode!.position.x > 3 * self.size.width / 4 {
                if levelIndex > 1 {
                    println("g")
                    calcOnce = true
                    hasSlid = true
                    hasSlidIn = true
                    currentNode?.physicsBody?.velocity.dx = 750
                    nextNode = nodeAtPoint(CGPointMake(-viewer1.size.width, self.size.height / 2))
                    nextNode?.physicsBody?.velocity.dx = 750
                    levelIndex--
                    nextNode?.zPosition = 12 - levelIndex
                    
                }
                else {
                    println("h")
                    blockedSlide = true
                    calcBlockedSlide = true
                    currentNode?.physicsBody?.velocity.dx = releaseVelocity!.x
                    
                    
                }
                
            }
            else {
                println("i")
                
                
                    runAction(SKAction.moveTo(CGPointMake(self.size.width / 2, self.size.height / 2), duration: 0.1))
                
                
                    
                
            }
            
            
        }
            isSwiping = false
        }
        
    }
        
        
        
        
        
        
        
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    override func didMoveToView(view: SKView) {
        
        
       
        
        
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        
        
        
        
        background.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        background.name = "background"
        background.zPosition = 0
        
        addChild(background)
        
        
        
        
        viewer1.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        viewer1.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        viewer1.zPosition = 1
        viewer1.physicsBody?.categoryBitMask = PhysicsCategory.viewer
        viewer1.physicsBody?.contactTestBitMask = PhysicsCategory.None
        viewer1.physicsBody?.collisionBitMask = PhysicsCategory.None
        viewer1.name = "level1"
        
        
        
        viewer2.position = CGPointMake(self.size.width + viewer2.size.width / 2, self.size.height / 2)
        viewer2.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        viewer2.zPosition = 10
        viewer2.physicsBody?.categoryBitMask = PhysicsCategory.viewer
        viewer2.physicsBody?.contactTestBitMask = PhysicsCategory.None
        viewer2.physicsBody?.collisionBitMask = PhysicsCategory.None
        viewer2.name = "level2"
       
        
        viewer3.position = CGPointMake(self.size.width + viewer3.size.width / 2, self.size.height / 2)
        viewer3.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        viewer3.zPosition = 9
        viewer3.physicsBody?.categoryBitMask = PhysicsCategory.viewer
        viewer3.physicsBody?.contactTestBitMask = PhysicsCategory.None
        viewer3.physicsBody?.collisionBitMask = PhysicsCategory.None
        viewer3.name = "level3"
       
        
        viewer4.position = CGPointMake(self.size.width + viewer4.size.width / 2, self.size.height / 2)
        viewer4.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        viewer4.zPosition = 8
        viewer4.physicsBody?.categoryBitMask = PhysicsCategory.viewer
        viewer4.physicsBody?.contactTestBitMask = PhysicsCategory.None
        viewer4.physicsBody?.collisionBitMask = PhysicsCategory.None
        viewer4.name = "level4"
        
        viewer5.position = CGPointMake(self.size.width + viewer5.size.width / 2, self.size.height / 2)
        viewer5.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        viewer5.zPosition = 7
        viewer5.physicsBody?.categoryBitMask = PhysicsCategory.viewer
        viewer5.physicsBody?.contactTestBitMask = PhysicsCategory.None
        viewer5.physicsBody?.collisionBitMask = PhysicsCategory.None
        viewer5.name = "level5"
        
        
        viewer6.position = CGPointMake(self.size.width + viewer6.size.width / 2, self.size.height / 2)
        viewer6.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        viewer6.zPosition = 6
        viewer6.physicsBody?.categoryBitMask = PhysicsCategory.viewer
        viewer6.physicsBody?.contactTestBitMask = PhysicsCategory.None
        viewer6.physicsBody?.collisionBitMask = PhysicsCategory.None
        viewer6.name = "level6"
        
        viewer7.position = CGPointMake(self.size.width + viewer7.size.width / 2, self.size.height / 2)
        viewer7.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        viewer7.zPosition = 5
        viewer7.physicsBody?.categoryBitMask = PhysicsCategory.viewer
        viewer7.physicsBody?.contactTestBitMask = PhysicsCategory.None
        viewer7.physicsBody?.collisionBitMask = PhysicsCategory.None
        viewer7.name = "level7"
        
        viewer8.position = CGPointMake(self.size.width + viewer8.size.width / 2, self.size.height / 2)
        viewer8.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        viewer8.zPosition = 4
        viewer8.physicsBody?.categoryBitMask = PhysicsCategory.viewer
        viewer8.physicsBody?.contactTestBitMask = PhysicsCategory.None
        viewer8.physicsBody?.collisionBitMask = PhysicsCategory.None
        viewer8.name = "level8"
        
        viewer9.position = CGPointMake(self.size.width + viewer9.size.width / 2, self.size.height / 2)
        viewer9.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        viewer9.zPosition = 3
        viewer9.physicsBody?.categoryBitMask = PhysicsCategory.viewer
        viewer9.physicsBody?.contactTestBitMask = PhysicsCategory.None
        viewer9.physicsBody?.collisionBitMask = PhysicsCategory.None
        viewer9.name = "level9"
        
        viewer10.position = CGPointMake(self.size.width + viewer10.size.width / 2, self.size.height / 2)
        viewer10.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        viewer10.zPosition = 2
        viewer10.physicsBody?.categoryBitMask = PhysicsCategory.viewer
        viewer10.physicsBody?.contactTestBitMask = PhysicsCategory.None
        viewer10.physicsBody?.collisionBitMask = PhysicsCategory.None
        viewer10.name = "level10"
        
        
        
        
        
        
        addChild(viewer1)
        addChild(viewer2)
        addChild(viewer3)
        addChild(viewer4)
        addChild(viewer5)
        addChild(viewer6)
        addChild(viewer7)
        addChild(viewer8)
        addChild(viewer9)
        addChild(viewer10)
        
        
        
        
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        self.view?.addGestureRecognizer(panGestureRecognizer!)
        
        
        
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        
        for touch: AnyObject in touches{
            let touchLocation = touch.locationInNode!(self)
            let selectedLevel = nodeAtPoint(touchLocation)
            var testString = String(selectedLevel.name!)
            
            switch testString {
                
            case "level1":
                
                let reveal = SKTransition.crossFadeWithDuration(0.5)
                let level1Size = CGSizeMake(1334, 750)
                
                let level1Scene = level1(size: level1Size)
                self.view?.presentScene(level1Scene, transition: reveal)
                
            case "level2":
                
                let reveal = SKTransition.crossFadeWithDuration(0.5)
                let level2Size = CGSizeMake(1334, 750)
               
                let level2Scene = level2Trial(size: level2Size)
                self.view?.presentScene(level2Scene, transition: reveal)
                
            case "level3":
                
                let reveal = SKTransition.crossFadeWithDuration(0.5)
                let level3Size = CGSizeMake(1334, 750)
                let level3Scene = level2(size: level3Size)
                self.view?.presentScene(level3Scene, transition: reveal)
                
            case "level4":
                
                let reveal = SKTransition.crossFadeWithDuration(0.5)
                let level4Size = CGSizeMake(1334, 750)
                let level4 = level2(size: level4Size)
                self.view?.presentScene(level4, transition: reveal)
                
            case "level5":
                
                let reveal = SKTransition.crossFadeWithDuration(0.5)
                let level5Size = CGSizeMake(1334, 750)
                let level5 = level2(size: level5Size)
                self.view?.presentScene(level5, transition: reveal)
                
            case "level6":
                
                let reveal = SKTransition.crossFadeWithDuration(0.5)
                let level6Size = CGSizeMake(1334, 750)
                let level6 = level2(size: level6Size)
                self.view?.presentScene(level6, transition: reveal)
                
            case "level7":
                
                let reveal = SKTransition.crossFadeWithDuration(0.5)
                let level7Size = CGSizeMake(1334, 750)
                let level7 = level2(size: level7Size)
                self.view?.presentScene(level7, transition: reveal)
                
            case "level8":
                
                let reveal = SKTransition.crossFadeWithDuration(0.5)
                let level8Size = CGSizeMake(1334, 750)
                let level8 = level2(size: level8Size)
                self.view?.presentScene(level8, transition: reveal)
                
            case "level9":
                
                let reveal = SKTransition.crossFadeWithDuration(0.5)
                let level9Size = CGSizeMake(1334, 750)
                let level9 = level2(size: level9Size)
                self.view?.presentScene(level9, transition: reveal)
                
            case "level10":
                
                let reveal = SKTransition.crossFadeWithDuration(0.5)
                let level10Size = CGSizeMake(1334, 750)
                let level10 = level2(size: level10Size)
                self.view?.presentScene(level10, transition: reveal)
                
            default :
                return
                
            }
            
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        
        
        if calcOnce {
            decelConst = -releaseVelocity!.x / (self.size.width/2)
            calcOnce = false
            println(decelConst)
        }
        
        if calcBlockedSlide {
            decelConst2 = -releaseVelocity!.x / (self.size.width/80)
            calcBlockedSlide = false
            
        }
        
        
        if hasSlid{
            
            
            currentNode?.physicsBody?.velocity.dx += decelConst
            
            
            if currentNode?.position.x <= -viewer1.size.width {
            
                currentNode?.physicsBody?.velocity = CGVectorMake(0, 0)
                currentNode!.position.x = -viewer1.size.width
                
                hasSlid = false
            }
        
        
            else if currentNode?.position.x >= self.size.width + viewer1.size.width {
                currentNode?.physicsBody?.velocity = CGVectorMake(0, 0)
                currentNode!.position.x = self.size.width + viewer1.size.width
                
                hasSlid = false
            }
            
            
            
            
        
        }
        
        if hasSlidIn {
            
            nextNode?.physicsBody?.velocity.dx += decelConst
            
            if nextNode!.position.x < self.size.width / 2 && nextNode?.physicsBody?.velocity.dx < 0 {
                
                nextNode?.physicsBody?.velocity.dx = 0
                nextNode?.position.x = self.size.width / 2
                
                
            }
            else if nextNode!.position.x > self.size.width / 2 && nextNode?.physicsBody?.velocity.dx > 0 {
                
                nextNode?.physicsBody?.velocity.dx = 0
                nextNode?.position.x = self.size.width / 2
                
            }
            
        }
    
        if blockedSlide {
            
            currentNode?.physicsBody?.velocity.dx += decelConst2
            
            if currentNode?.position.x < self.size.width / 2 && decelConst2 < 0 {
                
                currentNode?.physicsBody?.velocity.dx = 0
                currentNode?.position.x = self.size.width / 2
                
                blockedSlide = false
                
            }
            
            else if currentNode?.position.x > self.size.width / 2 && decelConst2 > 0 {
                
                currentNode?.physicsBody?.velocity.dx = 0
                currentNode?.position.x = self.size.width / 2
                
                blockedSlide = false
                
            }
            
        }
        
        
    }
    
    
    
}
