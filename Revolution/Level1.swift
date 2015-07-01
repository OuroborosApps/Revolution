//
//  Level 1.swift
//  Revolution
//
//  Created by Aidan Hodge on 11/17/14.
//  Copyright (c) 2014 Ouroboros. All rights reserved.
//

import Foundation
import SpriteKit


class level1 :SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isPause = false
    var grabbedPlanet = false
    var tracer1Path = [CGPoint(x:0, y:0)]
    var tracer2Path = [CGPoint(x:0, y:0)]
    
    let star1 = star(imageNamed: "star")
    let star2 = star(imageNamed: "star")
    let planet1 = planet(imageNamed: "planet")
    let planet2 = planet(imageNamed: "planet")
    let tracer1 = tracer(imageNamed: "tracer")
    let tracer2 = tracer(imageNamed: "tracer")
    let shapeNodePath1 = SKShapeNode()
    let shapeNodePath2 = SKShapeNode()
    
    var tracer1Red = false
    var tracer1Done = false
    var tracer1Flash = false
    var tracer1Count = -1
    var tracer1Turn = false
    var tracer1Speed: (CGFloat) = 0
    
    var flash = UInt32(1)
    let gravityField1 = SKFieldNode.radialGravityField()
    let gravityField2 = SKFieldNode.radialGravityField()
    let gravityField1b = SKFieldNode.radialGravityField()
    var levelName = "Level 1"
    let background = SKSpriteNode(imageNamed: "Space_BG_1b")

    
    let star1Cat = UInt32(1)
    let star2Cat = UInt32(2)
    let planetCat = UInt32(3)
    let tracerCat = UInt32(4)
    
    //smoothening variables
    struct TouchInfo {
        var location: CGPoint
        var time: NSTimeInterval
    }
    var selectedNode: SKSpriteNode?
    var history: [TouchInfo]?
    var spin: CGFloat?
    var tapRecognizer: UITapGestureRecognizer?
    
    override func didMoveToView(view: SKView) {
    
        background.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        background.zPosition = 0
        addChild(background)
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        let radius1 = star1.size.width / 2
        let radius2 = star2.size.width / 2
        
        gravityField1.enabled = true;
        gravityField1.position = CGPoint(x: self.size.width / 3, y: self.size.height / 2)
        gravityField1.strength = Float(pow(radius1, 2)) * pow(10, -3)
        gravityField1.categoryBitMask = star2Cat & planetCat
        
        addChild(gravityField1)
        
        
        gravityField1b.enabled = true;
        gravityField1b.position = CGPoint(x: self.size.width / 3, y: self.size.height / 2)
        //gravityField1b.strength = Float(pow(radius1, 2)) * pow(10, -3) * 100
        gravityField1b.strength = Float(pow(radius1, 2)) * pow(10, -3) * 9
        gravityField1b.categoryBitMask = tracerCat
        
        addChild(gravityField1b)
        
        
        gravityField2.enabled = true;
        gravityField2.position = CGPoint(x: 2*self.size.width / 3, y: self.size.height / 2)
        gravityField2.strength = Float(pow(radius2, 2)) * pow(10, -3)
        gravityField2.categoryBitMask = star1Cat & planetCat
        
        //addChild(gravityField2)
        
        //Star Creation
        
        star1.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        star1.physicsBody?.friction = 0
        star1.physicsBody?.linearDamping = 0
        star1.physicsBody?.angularDamping = 0
        star1.physicsBody?.angularVelocity = 0.2
        star1.physicsBody?.fieldBitMask = star1Cat
        star1.zPosition = 2
        star1.name = "star"
        
        addChild(star1)
        
        star2.position = CGPoint(x: 2*self.size.width / 3, y: self.size.height / 2)
        star2.physicsBody?.friction = 0
        star2.physicsBody?.linearDamping = 0
        star2.physicsBody?.angularDamping = 0
        star2.physicsBody?.angularVelocity = 0.2
        star2.physicsBody?.fieldBitMask = star2Cat
        star2.zPosition = 2
        star2.name = "star"
        
        //addChild(star2)
        
        //Creating the Planet
        
        let planetR = planet1.size.width / 2
        planet1.physicsBody?.friction = 0
        planet1.position = CGPoint(x: self.size.width / 4, y: self.size.height / 2)
        planet1.physicsBody?.velocity = CGVectorMake(0, 200)
        planet1.physicsBody?.linearDamping = 0
        planet1.physicsBody?.angularDamping = 0
        planet1.physicsBody?.angularVelocity = 1

        planet1.physicsBody?.fieldBitMask = planetCat
        planet1.zPosition = 2
        planet1.name = "planet1"
        
        addChild(planet1)
        
        planet2.physicsBody?.friction = 0
        planet2.position = CGPoint(x: 3 * self.size.width / 4, y: self.size.height / 2)
        planet2.physicsBody?.velocity = CGVectorMake(0, -200)
        planet2.physicsBody?.linearDamping = 0
        planet2.physicsBody?.angularVelocity = 1
        planet2.physicsBody?.angularDamping = 0
        
        planet2.physicsBody?.fieldBitMask = planetCat
        planet2.zPosition = 2
        planet2.name = "planet2"
        
        //addChild(planet2)
        
        //Tracer draws future path of the planets
        tracer1.physicsBody?.friction = 0
        tracer1.position = planet1.position
        tracer1.physicsBody?.velocity = CGVectorMake(0, 600)
        tracer1.physicsBody?.linearDamping = 0
        tracer1.physicsBody?.angularDamping = 0
        tracer1.physicsBody?.angularVelocity = 0
        
        tracer1.physicsBody?.fieldBitMask = tracerCat
        tracer1.zPosition = 2
        tracer1.name = "tracer"
        
        addChild(tracer1)
        
        //Tracer draws future path of the planets
        tracer2.physicsBody?.friction = 0
        tracer2.position = planet2.position
        tracer2.physicsBody?.velocity = CGVectorMake(0, -400)
        tracer2.physicsBody?.linearDamping = 0
        tracer2.physicsBody?.angularDamping = 0
        tracer2.physicsBody?.angularVelocity = 0
        
        tracer2.physicsBody?.fieldBitMask = tracerCat
        tracer2.zPosition = 2
        tracer2.name = "tracer2"
        
        //addChild(tracer2)
        
        //prevents stars from being pushed by planets, won't matter when collision ends game
        star1.physicsBody?.mass = 10000
        planet1.physicsBody?.mass = 1
        star2.physicsBody?.mass = 10000
        planet2.physicsBody?.mass = 1
        
        //Tap gesture
        tapRecognizer = UITapGestureRecognizer(target: self, action: "handleThreeFingerTap:")
        tapRecognizer?.numberOfTouchesRequired = 3
        self.view?.addGestureRecognizer(tapRecognizer!)
        
    }
    
    func handleThreeFingerTap(gesture: UITapGestureRecognizer) {
        
        pause()
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        let node = self.nodeAtPoint(location)
        if node.name == "planet1" || node.name == "planet2" {
            grabbedPlanet = true
            selectedNode = node as? SKSpriteNode;
            selectedNode?.physicsBody?.velocity = CGVectorMake(0,0)
            spin = selectedNode?.physicsBody?.angularVelocity
            
            selectedNode?.physicsBody?.dynamic = false
            history = [TouchInfo(location:location, time:touch.timestamp)]
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        if (selectedNode != nil) {
            selectedNode?.position = location
            history?.insert(TouchInfo(location:location, time:touch.timestamp),atIndex:0)
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if grabbedPlanet == true {
            let touch = touches.first as! UITouch
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            var xVelocity: CGFloat = 0.0
            
            var yVelocity: CGFloat = 0.0
            var dx: CGFloat = 0.0
            var dy: CGFloat = 0.0
            var frames = CGFloat(1)
            tracer1Flash = false
        
            if (selectedNode != nil && history!.count > 1) {

                var newFrames = 0
                var previousTouchInfo: TouchInfo?
                // Adjust this value for more smoothening
                let iterations = 3
                
                // Maximum time object can sit still before setting velocity to 0, needs to be tested on real phones
                let maxTime = CGFloat(0.02)
                var numElts: Int = min(history!.count, iterations)
                for index in 0...numElts-1 {
                    let touchInfo = history![numElts-index-1]
                    let location = touchInfo.location
                    
                    if let previousLocation = previousTouchInfo?.location {
                        
                        dx = location.x - previousLocation.x
                        dy = location.y - previousLocation.y
                        let dt = CGFloat(touchInfo.time - previousTouchInfo!.time)
                        xVelocity += dx / dt
                        yVelocity += dy / dt
                        if dt > maxTime {
                            xVelocity = 0
                            yVelocity = 0
                            newFrames = numElts-index-1
                        }
                    }
                    previousTouchInfo = touchInfo
                }
            
                if newFrames != 0 {
                    frames = CGFloat(newFrames)
                } else {
                    frames = CGFloat(numElts-1)
                }
            
            }
        
            if node.name == "planet1" {
                tracer1.removeFromParent()
            
                tracer1.physicsBody?.friction = 0
                tracer1.position = planet1.position
                tracer1.physicsBody?.velocity = CGVectorMake(3 * xVelocity/frames, 3 * yVelocity/frames)
                tracer1.physicsBody?.linearDamping = 0
                tracer1.physicsBody?.angularDamping = 0
                tracer1.physicsBody?.angularVelocity = 0
        
                tracer1.physicsBody?.fieldBitMask = tracerCat
                tracer1.zPosition = 1
                tracer1.name = "tracer"
                tracer1Red = false
                tracer1Done = false
                tracer1Turn = false
                
                addChild(tracer1)
                tracer1Path = [CGPoint(x:0, y:0)]
            }
                
            let velocity = CGVectorMake(xVelocity/frames,yVelocity/frames)
            selectedNode?.physicsBody?.dynamic = true
            selectedNode?.physicsBody?.velocity = velocity
            selectedNode?.physicsBody?.angularVelocity = spin!
            selectedNode = nil
            history = nil
            grabbedPlanet = false
        }
    }

    func pauseGame() {
        
        if isPause == false {
            isPause = true
            scene.self!.paused = true
        } else {
            isPause = false
            scene.self!.paused = false
        }
        
    }
    
    func createOrbitPath1() -> CGPathRef? {

        if tracer1Path.count <= 2 {
            return nil
        }
        
        var orbitPath1 = CGPathCreateMutable()
        
        for var i = 0; i < tracer1Path.count-1; ++i {
            let p = tracer1Path[i]
            
            if i == 0 {
                CGPathMoveToPoint(orbitPath1, nil, p.x, p.y)
            } else {
                CGPathAddLineToPoint(orbitPath1, nil, p.x, p.y)
            }
        }
        
        return orbitPath1
    }
    
    func drawOrbit1() {
        
        enumerateChildNodesWithName("line1", usingBlock: {node, stop in
            node.removeFromParent()
        })
        
        shapeNodePath1.path = self.createOrbitPath1()
        shapeNodePath1.name = "line1"
        
        if self.tracer1Flash == true && self.flash > 5 {
            shapeNodePath1.strokeColor = UIColor.redColor()
        } else if self.tracer1Red == true {
            shapeNodePath1.strokeColor = UIColor.redColor()
        } else if self.tracer1Done == true {
            shapeNodePath1.strokeColor = UIColor.greenColor()
        } else {
            shapeNodePath1.strokeColor = UIColor.whiteColor()
        }

        shapeNodePath1.lineWidth = 4
        shapeNodePath1.zPosition = 1
        
        self.addChild(shapeNodePath1)
        
        //Need condition to start flashing
        if tracer1Flash == false && 1==0 {
            tracer1Flash = true
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        gravityField1.position = star1.position
        gravityField1b.position = star1.position
        gravityField2.position = star2.position
        
        flash++
        if flash > 10 {
            flash = 1;
        }

        if tracer1Count >= 0 {
            
            if tracer1Count == 0 {
                tracer1Done = true;
                tracer1.removeFromParent()
                tracer1Count = -1
                drawOrbit1()
            } else {
                tracer1Path.insert(tracer1.position, atIndex:0)
                tracer1Count -= 1
                drawOrbit1()
            }
            
        } else if !tracer1Done {
            
            tracer1Path.insert(tracer1.position, atIndex:0)
            
            if tracer1Turn == false {
                tracer1Speed = sqrt(tracer1.physicsBody!.velocity.dx*tracer1.physicsBody!.velocity.dx +
                    tracer1.physicsBody!.velocity.dy*tracer1.physicsBody!.velocity.dy)
            }
            
            if tracer1.position.x > self.size.width || tracer1.position.y > self.size.height || tracer1.position.x < 0 || tracer1.position.y < 0 {
                tracer1Red = true
                tracer1Done = true
                tracer1.removeFromParent()
            }
            
            //may need to be adjusted for lager space
            if tracer1Speed < 50 {
                tracer1Turn = true
            }
            
            let distance1star = pow((tracer1.position.x - star1.position.x),2) +
                pow((tracer1.position.y - star1.position.y),2)
            if distance1star < pow(star1.size.width * 0.8,2) {
                tracer1Red = true
                tracer1Done = true
                tracer1.removeFromParent()
            }
            
            let num1 = max(tracer1Path.count, 2)
            let distance1 = pow((tracer1.position.x - tracer1Path[num1 - 2].x),2) +
                pow((tracer1.position.y - tracer1Path[num1 - 2].y),2)
            
            if tracer1Path.count > 20 && distance1 < 400 && tracer1Turn == false {
                tracer1Count = Int(800 / tracer1Speed)
            }
            drawOrbit1()
        
        } else if tracer1Flash == true {
            drawOrbit1()
        }
    }
}

        