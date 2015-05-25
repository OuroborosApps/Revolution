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
    var tracer2Red = false
    var tracer1Done = false
    var tracer2Done = false
    var tracer1Flash = false
    var tracer2Flash = false
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
        gravityField1b.strength = Float(pow(radius1, 2)) * pow(10, -3) * 4
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
        
        addChild(planet2)
        
        //Tracer draws future path of the planets
        tracer1.physicsBody?.friction = 0
        tracer1.position = planet1.position
        //tracer1.physicsBody?.velocity = CGVectorMake(0, 2000)
        tracer1.physicsBody?.velocity = CGVectorMake(0, 400)
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
        //tracer2.physicsBody?.velocity = CGVectorMake(0, 2000)
        tracer2.physicsBody?.velocity = CGVectorMake(0, -400)
        tracer2.physicsBody?.linearDamping = 0
        tracer2.physicsBody?.angularDamping = 0
        tracer2.physicsBody?.angularVelocity = 0
        
        tracer2.physicsBody?.fieldBitMask = tracerCat
        tracer2.zPosition = 2
        tracer2.name = "tracer2"
        
        addChild(tracer2)
        
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
            tracer2Flash = false
        
            if (selectedNode != nil && history!.count > 1) {

                var newFrames = 0
                var previousTouchInfo: TouchInfo?
                // Adjust this value for more smoothening
                let iterations = 3
                // Maximum time object can sit still before setting velocity to 0
                let maxTime = CGFloat(0.035)
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
                tracer1.physicsBody?.velocity = CGVectorMake(2 * xVelocity/frames, 2 * yVelocity/frames)
                tracer1.physicsBody?.linearDamping = 0
                tracer1.physicsBody?.angularDamping = 0
                tracer1.physicsBody?.angularVelocity = 0
        
                tracer1.physicsBody?.fieldBitMask = tracerCat
                tracer1.zPosition = 1
                tracer1.name = "tracer"
                tracer1Red = false
                tracer1Done = false
                
                addChild(tracer1)
                tracer1Path = [CGPoint(x:0, y:0)]
            }
            
            if node.name == "planet2" {
                tracer2.removeFromParent()
                
                tracer2.physicsBody?.friction = 0
                tracer2.position = planet2.position
                tracer2.physicsBody?.velocity = CGVectorMake(2 * xVelocity/frames, 2 * yVelocity/frames)
                tracer2.physicsBody?.linearDamping = 0
                tracer2.physicsBody?.angularDamping = 0
                tracer2.physicsBody?.angularVelocity = 0
                
                tracer2.physicsBody?.fieldBitMask = tracerCat
                tracer2.zPosition = 1
                tracer2.name = "tracer"
                tracer2Red = false
                tracer2Done = false
                
                addChild(tracer2)
                tracer2Path = [CGPoint(x:0, y:0)]
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
    
    func createOrbitPath2() -> CGPathRef? {
        
        if tracer2Path.count <= 2 {
            return nil
        }
        
        var orbitPath2 = CGPathCreateMutable()
        
        for var i = 0; i < tracer2Path.count-1; ++i {
            let p = tracer2Path[i]
            
            if i == 0 {
                CGPathMoveToPoint(orbitPath2, nil, p.x, p.y)
            } else {
                CGPathAddLineToPoint(orbitPath2, nil, p.x, p.y)
            }
        }
        
        return orbitPath2
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
        
        if tracer1Flash == false && 1==0 {
            tracer1Flash = true
            tracer2Flash = true
        }
    }
    
    func drawOrbit2() {
        
        enumerateChildNodesWithName("line2", usingBlock: {node, stop in
            node.removeFromParent()
        })

        shapeNodePath2.path = self.createOrbitPath2()
        shapeNodePath2.name = "line2"
        if self.tracer2Flash == true && self.flash > 5 {
            shapeNodePath2.strokeColor = UIColor.redColor()
        } else if self.tracer2Red == true {
            shapeNodePath2.strokeColor = UIColor.redColor()
        } else if self.tracer2Done == true {
            shapeNodePath2.strokeColor = UIColor.greenColor()
        } else {
            shapeNodePath2.strokeColor = UIColor.whiteColor()
        }
        shapeNodePath2.lineWidth = 4
        shapeNodePath2.zPosition = 1
            
        self.addChild(shapeNodePath2)
        
        if tracer2Flash == false && 1==0 {
            tracer1Flash = true
            tracer2Flash = true
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

        if !tracer1Done {
            
            tracer1Path.insert(tracer1.position, atIndex:0)
            
            if tracer1.position.x > self.size.width || tracer1.position.y > self.size.height || tracer1.position.x < 0 || tracer1.position.y < 0 {
                tracer1Red = true
                tracer1Done = true
                tracer1.removeFromParent()
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
            
            if tracer1Path.count > 10 && distance1 < 200 {
                tracer1Done = true
                tracer1.removeFromParent()
            }
            drawOrbit1()
        
        } else if tracer1Flash == true {
            drawOrbit1()
        }
        
        if !tracer2Done {
            
            tracer2Path.insert(tracer2.position, atIndex:0)
            
            if tracer2.position.x > self.size.width || tracer2.position.y > self.size.height || tracer2.position.x < 0 || tracer2.position.y < 0 {
                tracer2Red = true
                tracer2Done = true
                tracer2.removeFromParent()
            }
            
            let distance2star = pow((tracer2.position.x - star1.position.x),2) +
                pow((tracer2.position.y - star1.position.y),2)
            if distance2star < pow(star1.size.width * 0.8,2) {
                tracer2Red = true
                tracer2Done = true
                tracer2.removeFromParent()
            }
            
            let num2 = max(tracer2Path.count, 2)
            let distance2 = pow((tracer2.position.x - tracer2Path[num2 - 2].x),2) +
                pow((tracer2.position.y - tracer2Path[num2 - 2].y),2)
            
            if tracer2Path.count > 10 && distance2 < 200 {
                tracer2Done = true
                tracer2.removeFromParent()
            }
            drawOrbit2()

        } else if tracer2Flash == true {
            drawOrbit2()
        }
    }
}

        