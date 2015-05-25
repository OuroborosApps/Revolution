//
//  Planet.swift
//  Revolution
//
//  Created by Cristian Alonso on 11/16/14.
//  Copyright (c) 2014 Ouroboros. All rights reserved.
//

import Foundation
import SpriteKit

class planet: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    init(imageNamed: String){
        let imageTexture = SKTexture(imageNamed: imageNamed)
        super.init(texture: imageTexture, color: nil, size: imageTexture.size())
        
        let radius = self.size.width / 2
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2 )
        self.physicsBody?.dynamic = true
        

        
    }

}