//
//  Level2.swift
//  Revolution
//
//  Created by Cristian Alonso on 11/25/14.
//  Copyright (c) 2014 Ouroboros. All rights reserved.
//

import Foundation
import SpriteKit

class level2 :SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//********************************************Constants and Variables*******************************************************************************
    
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

    
    let sceneWidth:CGFloat = 1334
    let sceneHeight:CGFloat = 750
    let maxTileWidth: CGFloat = 1334
    let maxTileHeight: CGFloat = 750
    let minTileWidth: CGFloat = 334
    let minTileHeight: CGFloat = 188
    let minScale: CGFloat = 0.90
    let maxScale: CGFloat = 1.10
    let numberOfTilesInRow: Int = 4
    let numberOfTilesInColumn: Int = 4
    var centerNode: SKNode?
    var pinchRecognizer: UIPinchGestureRecognizer?
    var panRecognizer: UIPanGestureRecognizer?
    let decellerationConst:CGFloat = 7
    
    var hasBeenStopped = false
    var updateDisp = true
    
    var fullyZoomedIn = true
    
    var oldPosition: CGPoint?

    let gravityField = SKFieldNode.radialGravityField()
    
    // Some variales for the star positioning
    var afterSet = false
    var referenceDistance = CGPointMake(0, 0)
    
    
    //**************Tiled Background Nodes*************************
    
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
    //************************************************************
    
    
    var largePosXMotion = false
    var smallPosXMotion = true
    var largeNegXMotion = false
    var smallNegXMotion = true
    
    var largePosYMotion = false
    var smallPosYMotion = true
    var largeNegYMotion = false
    var smallNegYMotion = true
    
    struct PhysicsCategory {
        static let None : UInt32 = 0
        static let All : UInt32 = UInt32.max
        static let background : UInt32 = 0b1
        static let star : UInt32 = 0b10
        static let planet : UInt32 = 0b11
    }
//***********************************************************************************************************************************************
//***********************************************************************************************************************************************
//***********************************************************************************************************************************************
    
//***********************************************************************************************************************************************
//******************************************PinchGestureRecognizer*******************************************************************************
//***********************************************************************************************************************************************
    func handlePinchGesture(gesture: UIPinchGestureRecognizer){
        let BGNodeArray:Array = [bgTile1, bgTile2, bgTile3, bgTile4, bgTile5, bgTile6, bgTile7, bgTile8, bgTile9, bgTile10, bgTile11, bgTile12, bgTile13, bgTile14, bgTile15, bgTile16]
        // Finds the midpoint location of the pinch gesture
        var gesturePoint = gesture.locationInView(self.view)
        var touchedPoint = convertPointFromView(gesturePoint)
        var centerNodeArray = nodesAtPoint(touchedPoint)
        centerNode = findCenterNode(centerNodeArray)!
        if gesture.state == UIGestureRecognizerState.Began{
            updateDisp = false
            
            
            if gesture.scale < 1 {
                fullyZoomedIn = false
            }
            
            
        }
        
        if gesture.scale < 1 {
            fullyZoomedIn = false
        }
        
        //*******************************************************************************************
        // ***Finding the distance between the touchedPoint and the center of the center Node***
        var xDisp = touchedPoint.x - centerNode!.position.x
        var yDisp = touchedPoint.y - centerNode!.position.y
        
        
        //*******************************************************************************************
        //********************************Correct the Zooming****************************************
        //*******************************************************************************************
        
        limitZooming(bgTile1, gesture, maxTileWidth, minTileWidth, minScale, maxScale)
        
        var scaledXDisp: CGFloat = xDisp * gesture.scale
        var scaledYDisp: CGFloat = yDisp * gesture.scale
        
        //*******************************************************************************************
        //*****************Scaling Functions for the background nodes********************************
        //*******************************************************************************************
        scaleBackgroundNodes(BGNodeArray, gesture)
        
        //*******************************************************************************************
        //**********************************Scaling for Planets and Stars Below**********************
        //*******************************************************************************************
        star1.size = CGSizeMake(star1.size.width * gesture.scale, star1.size.height * gesture.scale)
        
        //**********************************************************************************************************************
        //***********Failsafe : Corrects if the scale function overshoots the scaling for either zoom in or zoom out************
        //**********************************************************************************************************************
        
        //*******************************************************************************************
        // *Weird but only method I could think of for calling the function to center the zoom on a specific node !!! This will fail if the nodes are renamed!!!*
        //*******************************************************************************************
        //*******************************************************************************************
        var centerNodeName = String(centerNode!.name!)
        var miscArray = centerNodeName.componentsSeparatedByString("e")
        var selectedNode = Double(miscArray[1].toInt()!)
        //*******************************************************************************************
        //**************************Zooming Movement for Background Nodes****************************
        //*******************************************************************************************
        zoomCenteredOnTile(selectedNode, BGNodeArray, Double(numberOfTilesInRow), Double(numberOfTilesInColumn), touchedPoint, scaledXDisp, scaledYDisp, fullyZoomedIn)
        
        failsafeZoom(BGNodeArray, minTileWidth, minTileHeight, maxTileWidth, maxTileHeight)
        
        //*******************************************************************************************
        //**************************Zooming Movement for Stars and Planets Below*********************
        //*******************************************************************************************
        referenceDistance = scaleSpriteNodePositionWithPinch(gesture, referenceDistance, bgTile1)
        
        //*******************************************************************************************
        //**************************Zooming Correction for Background Nodes**************************
        //*******************************************************************************************
        
        
        if bgTile1.size.width == maxTileWidth {
            fullyZoomedIn = true
        }
        
        
        gesture.scale = 1
        
        if gesture.state == UIGestureRecognizerState.Ended {
            updateDisp = true
        }
        
        
    }
//***********************************************************************************************************************************************
//***********************************************************************************************************************************************
//***********************************************************************************************************************************************
    
    
//***********************************************************************************************************************************************
//******************************************PanGestureRecognizer*********************************************************************************
//***********************************************************************************************************************************************

    func handlePanGesture(panGesture: UIPanGestureRecognizer){
        let BGNodeArray:Array = [bgTile1, bgTile2, bgTile3, bgTile4, bgTile5, bgTile6, bgTile7, bgTile8, bgTile9, bgTile10, bgTile11, bgTile12, bgTile13, bgTile14, bgTile15, bgTile16]
        if panGesture.state == UIGestureRecognizerState.Began {
            
           setBGPhysicsBodiesToDynamic(BGNodeArray)
            // Add the remaining nodes that need to be moved below
        }
        if panGesture.state == UIGestureRecognizerState.Changed{
            var deltaPointTemp = panRecognizer?.translationInView(self.view!)
            var deltaPoint = deltaPointTemp!
            if bgTile1.position.x + deltaPoint.x > self.size.width / 2 {
                deltaPoint.x = self.size.width / 2 - bgTile1.position.x
            }
            else if bgTile4.position.x + deltaPoint.x < self.size.width / 2 {
                
                deltaPoint.x = self.size.width / 2 - bgTile4.position.x
            }
            //***********************************************************************************************************************************//
            //*************************************Panning Movement for Background***************************************************************//
            //********* I know it's ugly but it's the most responsive because the other method creates arrays and therefore is more intensive*****
            //***********************************************************************************************************************************//
            bgTile1.position = convertPointFromView(CGPointMake(convertPointToView(bgTile1.position).x+deltaPoint.x, convertPointToView(bgTile1.position).y+deltaPoint.y))
            bgTile2.position = convertPointFromView(CGPointMake(convertPointToView(bgTile2.position).x+deltaPoint.x, convertPointToView(bgTile2.position).y+deltaPoint.y))
            bgTile3.position = convertPointFromView(CGPointMake(convertPointToView(bgTile3.position).x+deltaPoint.x, convertPointToView(bgTile3.position).y+deltaPoint.y))
            bgTile4.position = convertPointFromView(CGPointMake(convertPointToView(bgTile4.position).x+deltaPoint.x, convertPointToView(bgTile4.position).y+deltaPoint.y))
            bgTile5.position = convertPointFromView(CGPointMake(convertPointToView(bgTile5.position).x+deltaPoint.x, convertPointToView(bgTile5.position).y+deltaPoint.y))
            bgTile6.position = convertPointFromView(CGPointMake(convertPointToView(bgTile6.position).x+deltaPoint.x, convertPointToView(bgTile6.position).y+deltaPoint.y))
            bgTile7.position = convertPointFromView(CGPointMake(convertPointToView(bgTile7.position).x+deltaPoint.x, convertPointToView(bgTile7.position).y+deltaPoint.y))
            bgTile8.position = convertPointFromView(CGPointMake(convertPointToView(bgTile8.position).x+deltaPoint.x, convertPointToView(bgTile8.position).y+deltaPoint.y))
            bgTile9.position = convertPointFromView(CGPointMake(convertPointToView(bgTile9.position).x+deltaPoint.x, convertPointToView(bgTile9.position).y+deltaPoint.y))
            bgTile10.position = convertPointFromView(CGPointMake(convertPointToView(bgTile10.position).x+deltaPoint.x, convertPointToView(bgTile10.position).y+deltaPoint.y))
            bgTile11.position = convertPointFromView(CGPointMake(convertPointToView(bgTile11.position).x+deltaPoint.x, convertPointToView(bgTile11.position).y+deltaPoint.y))
            bgTile12.position = convertPointFromView(CGPointMake(convertPointToView(bgTile12.position).x+deltaPoint.x, convertPointToView(bgTile12.position).y+deltaPoint.y))
            bgTile13.position = convertPointFromView(CGPointMake(convertPointToView(bgTile13.position).x+deltaPoint.x, convertPointToView(bgTile13.position).y+deltaPoint.y))
            bgTile14.position = convertPointFromView(CGPointMake(convertPointToView(bgTile14.position).x+deltaPoint.x, convertPointToView(bgTile14.position).y+deltaPoint.y))
            bgTile15.position = convertPointFromView(CGPointMake(convertPointToView(bgTile15.position).x+deltaPoint.x, convertPointToView(bgTile15.position).y+deltaPoint.y))
            bgTile16.position = convertPointFromView(CGPointMake(convertPointToView(bgTile16.position).x+deltaPoint.x, convertPointToView(bgTile16.position).y+deltaPoint.y))
            
            
            //***********************************************************************************************************************************//
            //***********************************************************************************************************************************//
            if bgTile1.position.y - deltaPoint.y < self.size.height / 2 {
                deltaPoint.y = self.size.height / 2 - bgTile1.position.y
            }
            else if bgTile13.position.y - deltaPoint.y > self.size.height / 2 {
                deltaPoint.y = self.size.height / 2 - bgTile13.position.y
            }
            panGesture.setTranslation(CGPointZero, inView: self.view)
        }
        
        var finalVelocityStorage:CGPoint = panGesture.velocityInView(self.view)
        
        if panGesture.state == UIGestureRecognizerState.Ended {
            //********Final Velocities Applied to Background********//
            applyFinalVelocities(BGNodeArray, finalVelocityStorage)
            //******************************************************//
           
            hasBeenStopped = false
        }
    }
//***********************************************************************************************************************************************
//***********************************************************************************************************************************************
//***********************************************************************************************************************************************
    
//***********************************************************************************************************************************************
//**********************************************************DidMoveToView************************************************************************
//***********************************************************************************************************************************************
    
    override func didMoveToView(view: SKView) {
        
        
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

        
        
        //***************************Adding the Tiled Background************************************
        let BGNodeArray:Array = [bgTile1, bgTile2, bgTile3, bgTile4, bgTile5, bgTile6, bgTile7, bgTile8, bgTile9, bgTile10, bgTile11, bgTile12, bgTile13, bgTile14, bgTile15, bgTile16]
        setUpBackgroundTiles(BGNodeArray, sceneWidth, sceneHeight)
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
        //******************************************************************************************
        oldPosition = bgTile1.position
        
        
        
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        let radius = star1.size.width / 2
        
        gravityField.enabled = true;
        gravityField.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        gravityField.strength = Float(pow(radius, 2)) * pow(10, -3.3)
        
        //addChild(gravityField)
        
        
        //Star Creation
        
        star1.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        star1.physicsBody = SKPhysicsBody(circleOfRadius: star1.size.width/2)
        star1.physicsBody?.friction = 0
        star1.physicsBody?.linearDamping = 0
        star1.physicsBody?.angularDamping = 0
        star1.zPosition = 1
        star1.physicsBody?.categoryBitMask = PhysicsCategory.star
        star1.physicsBody?.contactTestBitMask = PhysicsCategory.planet
        star1.physicsBody?.collisionBitMask = PhysicsCategory.star
        addChild(star1)
        
        //*********************Variables For Keeping the Star in Place During Zooming and Panning*******
        referenceDistance = CGPointMake(bgTile1.position.x - star1.position.x, bgTile1.position.y - star1.position.y)
        afterSet = true
        //**********************************************************************************************
        
        //Creating the Planet
        
        planet1.physicsBody?.friction = 0
        planet1.position = CGPoint(x: self.size.width / 8,y:size.height / 2)
        planet1.physicsBody?.velocity = CGVectorMake(0, 0)
        planet1.physicsBody?.mass = 0
        planet1.physicsBody?.linearDamping = 0
        planet1.physicsBody?.angularDamping = 0
        planet1.zPosition = 1
        planet1.name = "planet"
        
        //addChild(planet1)
        
        planet2.physicsBody?.friction = 0
        planet2.position = CGPoint(x: 7*(self.size.width / 8),y:size.height / 2)
        planet2.physicsBody?.velocity = CGVectorMake(0, 0)
        planet2.physicsBody?.mass = 0
        planet2.physicsBody?.linearDamping = 0
        planet2.physicsBody?.angularDamping = 0
        planet2.zPosition = 1
        planet2.name = "planet"
        
        //addChild(planet2)
        
        
        
        pinchRecognizer = UIPinchGestureRecognizer(target: self, action: "handlePinchGesture:")
        self.view?.addGestureRecognizer(pinchRecognizer!)
        
        panRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        
        panRecognizer?.minimumNumberOfTouches = 2
        panRecognizer?.maximumNumberOfTouches = 2
        self.view?.addGestureRecognizer(panRecognizer!)
        
        
        
    }
//***********************************************************************************************************************************************
//***********************************************************************************************************************************************
//***********************************************************************************************************************************************
  
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let BGNodeArray:Array = [bgTile1, bgTile2, bgTile3, bgTile4, bgTile5, bgTile6, bgTile7, bgTile8, bgTile9, bgTile10, bgTile11, bgTile12, bgTile13, bgTile14, bgTile15, bgTile16]
        if touches.count == 2 {
           setBGPhysicsBodiesFromDynamic(BGNodeArray)
        }
        
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

    
    override func update(currentTime: CFTimeInterval) {
        let BGNodeArray:Array = [bgTile1, bgTile2, bgTile3, bgTile4, bgTile5, bgTile6, bgTile7, bgTile8, bgTile9, bgTile10, bgTile11, bgTile12, bgTile13, bgTile14, bgTile15, bgTile16]
        
//*************************************************************************************************************************************************
//*************************************************Background Update Functions*********************************************************************
//*************************************************************************************************************************************************
        zoomCorrectNodes(BGNodeArray, sceneWidth, sceneHeight, numberOfTilesInRow, numberOfTilesInColumn)
        
        if bgTile1.physicsBody?.velocity.dx != 0 || bgTile1.physicsBody?.velocity.dy != 0 {
            followTile(BGNodeArray)
        }
        
        if bgTile1.physicsBody?.velocity.dx > decellerationConst {
            decreaseTileXVelocity(BGNodeArray, decellerationConst)
        }
        else if bgTile1.physicsBody?.velocity.dx <= decellerationConst && bgTile1.physicsBody?.velocity.dx > 0 {
            setTileXVelocityToZero(BGNodeArray)
        }
        else if bgTile1.physicsBody?.velocity.dx >= -decellerationConst && bgTile1.physicsBody?.velocity.dx < 0 {
            setTileXVelocityToZero(BGNodeArray)
        }
        else if bgTile1.physicsBody?.velocity.dx < -decellerationConst {
            increaseTileXVelocity(BGNodeArray, decellerationConst)
        }
        
        if bgTile1.physicsBody?.velocity.dy > decellerationConst {
            decreaseTileYVelocity(BGNodeArray, decellerationConst)
        }
        else if bgTile1.physicsBody?.velocity.dy <= decellerationConst && bgTile1.physicsBody?.velocity.dy > 0 {
            setTileYVelocityToZero(BGNodeArray)
        }
        else if bgTile1.physicsBody?.velocity.dy >= -decellerationConst && bgTile1.physicsBody?.velocity.dy < 0 {
            setTileYVelocityToZero(BGNodeArray)
        }
        else if bgTile1.physicsBody?.velocity.dy < -decellerationConst {
            increaseTileYVelocity(BGNodeArray, decellerationConst)
        }
        
        if bgTile1.physicsBody?.velocity.dx == 0 && bgTile1.physicsBody?.velocity.dy == 0 && !hasBeenStopped {
            setBGPhysicsBodiesFromDynamic(BGNodeArray)
            hasBeenStopped = true
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
            
            
            
            setTileTotalVelocityToZero(BGNodeArray)
            
            
        }
        
        if bgTile1.position.y + bgTile1.size.height/2 < sceneHeight {
            
            bgTile1.position.y = sceneHeight - bgTile1.size.height/2
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
            
            
            setTileTotalVelocityToZero(BGNodeArray)
        }
        
        if bgTile16.position.x + bgTile16.size.width/2 < sceneWidth {
            
            bgTile16.position.x = sceneWidth - bgTile16.size.width/2
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
            
            setTileTotalVelocityToZero(BGNodeArray)
            
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
            
            setTileTotalVelocityToZero(BGNodeArray)
        }
        //*******************************************************************************************************
        //*******************************Stars and Planets Update Functions**************************************
        //*******************************************************************************************************
        if updateDisp {
            moveSpriteNodeAfterPan(star1, bgTile1, oldPosition!)
        }
        //***
        oldPosition = bgTile1.position
        //***
        //*******************************************************************************************************
        // This is the function for keeping the star in position during zooming and panning
        if afterSet {
            star1.position.x = bgTile1.position.x - referenceDistance.x
            star1.position.y = bgTile1.position.y - referenceDistance.y
        }
        
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
//***********************************************************************************************************************************************
//***********************************************************************************************************************************************
//***********************************************************************************************************************************************
    
}





