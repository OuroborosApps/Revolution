

//
//  LevelSelect.swift
//  Revolution
//
//  Created by Cristian Alonso on 11/21/14.
//  Copyright (c) 2014 Ouroboros. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class levelSelectTrial2 :SKScene, UIGestureRecognizerDelegate, SKSceneDelegate  {
    
    override init(size: CGSize) {
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var panGestureRecognizer: UIPanGestureRecognizer?
    var isSwiping = false
    var rightSwipeRecognizer: UISwipeGestureRecognizer?
    var leftSwipeRecognizer: UISwipeGestureRecognizer?
    
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
    
    var centerPoint: CGPoint?
    var levelIndex:CGFloat = 1
    var currentNode: SKNode?
    var transferPoint: CGPoint?
    
    func doneSwiping() {
        isSwiping = false
    }
    
    
    
    func handlePanGesture(gesture: UIPanGestureRecognizer){
        
       
            
            
            if gesture.state == UIGestureRecognizerState.Began{
                println("reset")
                centerPoint = CGPointMake(self.size.width / 2, self.size.height / 2)
                println(centerPoint)
                currentNode = nodeAtPoint(centerPoint!)
                
            }
            
            
            
            
            var newPointTemp = panGestureRecognizer?.translationInView(self.view!)
            var newPoint = convertPointFromView(newPointTemp!)
            
            transferPoint = CGPointMake(currentNode!.position.x + newPoint.x, 0)
            currentNode!.position.x = transferPoint!.x
            
            
            
            gesture.setTranslation(CGPointZero, inView: self.view)
        }
    
    
    func handleSwipeRight(gesture: UISwipeGestureRecognizer) {
        println("swiped")
        if levelIndex > 1 {
            if !isSwiping{
                isSwiping = true
                --levelIndex
                
                var currentViewerOut = nodeAtPoint(CGPointMake(self.size.width / 2, self.size.height / 2))
                var currentViewerIn = nodeAtPoint(CGPointMake(-viewer1.size.width / 2, self.size.height / 2))
                
                let moveOutRight = SKAction.moveTo(CGPoint(x: self.size.width + viewer1.size.width / 2, y: self.size.height / 2), duration: 0.5)
                let moveInRight = SKAction.moveTo(CGPoint(x: self.size.width / 2, y: self.size.height / 2), duration: 0.5)
                
                
                currentViewerOut.runAction(moveOutRight)
                currentViewerIn.runAction(moveInRight)
                currentViewerOut.zPosition = 12 - levelIndex
                
                
                runAction(SKAction.sequence([SKAction.waitForDuration(0.51),SKAction.runBlock(doneSwiping)] ))
            }
            
        }
    }
    
    
    
    
    
    
    
    
    func handleSwipeLeft(gesture: UISwipeGestureRecognizer) {
        println("swiped")
        if levelIndex < 10{
            if !isSwiping{
                isSwiping = true
                ++levelIndex
                
                var currentViewerOut = nodeAtPoint(CGPointMake(self.size.width / 2, self.size.height / 2))
                var currentViewerIn = nodeAtPoint(CGPointMake(self.size.width + viewer2.size.width / 2, self.size.height / 2))
                
                let moveOutLeft = SKAction.moveTo(CGPoint(x: -viewer1.size.width / 2, y: self.size.height / 2), duration: 0.5)
                let moveInLeft = SKAction.moveTo(CGPoint(x: self.size.width / 2, y: self.size.height / 2), duration: 0.5)
                
                
                currentViewerOut.runAction(moveOutLeft)
                currentViewerIn.runAction(moveInLeft)
                currentViewerIn.zPosition = levelIndex
                
                
                runAction(SKAction.sequence([SKAction.waitForDuration(0.51),SKAction.runBlock(doneSwiping)] ))
            }
            
            
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didMoveToView(view: SKView) {
        
        
        
        
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        
        
        
        
        
        background.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        background.name = "background"
        background.zPosition = 0
        
        addChild(background)
        
        
        
        
        viewer1.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        viewer1.zPosition = 1
        viewer1.name = "level1"
        
        viewer2.position = CGPointMake(self.size.width + viewer2.size.width / 2, self.size.height / 2)
        viewer2.zPosition = 10
        viewer2.name = "level2"
        
        viewer3.position = CGPointMake(self.size.width + viewer3.size.width / 2, self.size.height / 2)
        viewer3.zPosition = 9
        viewer3.name = "level3"
        
        viewer4.position = CGPointMake(self.size.width + viewer4.size.width / 2, self.size.height / 2)
        viewer4.zPosition = 8
        viewer4.name = "level4"
        
        viewer5.position = CGPointMake(self.size.width + viewer5.size.width / 2, self.size.height / 2)
        viewer5.zPosition = 7
        viewer5.name = "level5"
        
        viewer6.position = CGPointMake(self.size.width + viewer6.size.width / 2, self.size.height / 2)
        viewer6.zPosition = 6
        viewer6.name = "level6"
        
        viewer7.position = CGPointMake(self.size.width + viewer7.size.width / 2, self.size.height / 2)
        viewer7.zPosition = 5
        viewer7.name = "level7"
        
        viewer8.position = CGPointMake(self.size.width + viewer8.size.width / 2, self.size.height / 2)
        viewer8.zPosition = 4
        viewer8.name = "level8"
        
        viewer9.position = CGPointMake(self.size.width + viewer9.size.width / 2, self.size.height / 2)
        viewer9.zPosition = 3
        viewer9.name = "level9"
        
        viewer10.position = CGPointMake(self.size.width + viewer10.size.width / 2, self.size.height / 2)
        viewer10.zPosition = 2
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
        
        
        rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipeRight:")
        rightSwipeRecognizer?.direction = UISwipeGestureRecognizerDirection.Right
        rightSwipeRecognizer?.delegate = self
        
        
        
        
        
        
        leftSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipeLeft:")
        leftSwipeRecognizer?.direction = UISwipeGestureRecognizerDirection.Left
        leftSwipeRecognizer?.delegate = self
        
        
        
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        panGestureRecognizer?.delegate = self
        
        
        
        
       rightSwipeRecognizer?.delegate?.gestureRecognizer!(self.rightSwipeRecognizer!, shouldRecognizeSimultaneouslyWithGestureRecognizer: self.panGestureRecognizer!)
        leftSwipeRecognizer?.delegate?.gestureRecognizer!(self.leftSwipeRecognizer!, shouldRecognizeSimultaneouslyWithGestureRecognizer: self.panGestureRecognizer!)
        self.view?.addGestureRecognizer(rightSwipeRecognizer!)
        self.view?.addGestureRecognizer(leftSwipeRecognizer!)
        self.view?.addGestureRecognizer(panGestureRecognizer!)
        
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        
        for touch: AnyObject in touches{
            let touchLocation = touch.locationInNode(self)
            let selectedLevel = nodeAtPoint(touchLocation)
            var testString = String(selectedLevel.name!)
            
            switch testString {
                
            case "level1":
                
                let reveal = SKTransition.crossFadeWithDuration(0.5)
                let level1Size = CGSizeMake(1334, 750)
                self.view?.removeGestureRecognizer(rightSwipeRecognizer!)
                self.view?.removeGestureRecognizer(leftSwipeRecognizer!)
                let level1Scene = level1(size: level1Size)
                self.view?.presentScene(level1Scene, transition: reveal)
                
            case "level2":
                
                let reveal = SKTransition.crossFadeWithDuration(0.5)
                let level2Size = CGSizeMake(1334, 750)
                self.view?.removeGestureRecognizer(rightSwipeRecognizer!)
                self.view?.removeGestureRecognizer(leftSwipeRecognizer!)
                let level2Scene = level2(size: level2Size)
                self.view?.presentScene(level2Scene, transition: reveal)
                
            case "level3":
                
                let reveal = SKTransition.crossFadeWithDuration(0.5)
                //let level3Size = CGSizeMake(1334, 750)
               //let level3Scene = level3(size: level3Size)
                //self.view?.presentScene(level3Scene, transition: reveal)
                
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
    
    
    
    
    
    
    
}



