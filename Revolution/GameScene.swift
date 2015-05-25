//
//  GameScene.swift
//  Revolution
//
//  Created by Cristian Alonso on 11/16/14.
//  Copyright (c) 2014 Ouroboros. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    
    
    
    
    
    
    
    override func didMoveToView(view: SKView) {
        
        
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        let titleScreenSize = CGSizeMake(1334, 750)
        let titleScreneScene = title(size: titleScreenSize)
        self.view?.presentScene(titleScreneScene, transition: reveal)
        
        
          }
    
    
    
        
    
   
    override func update(currentTime: CFTimeInterval) {
        
        
        
        /* Called before each frame is rendered */
    }
}