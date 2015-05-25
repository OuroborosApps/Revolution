//
//  Tracer.swift
//  Revolution
//
//  Created by Aidan Hodge on 12/28/14.
//  Copyright (c) 2014 Ouroboros. All rights reserved.
//

import Foundation
import SpriteKit

class tracer: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    init(imageNamed: String){
        let imageTexture = SKTexture(imageNamed: imageNamed)
        super.init(texture: imageTexture, color: nil, size: imageTexture.size())
        
        let radius = self.size.width / 2
        
        self.physicsBody = SKPhysicsBody()
        self.physicsBody?.dynamic = true
        
    }
    
}