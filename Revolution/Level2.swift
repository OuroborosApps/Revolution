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
//********************************************Constants or Variables*******************************************************************************
    
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
    
    let star1 = star(imageNamed: "star")
    let planet1 = planet(imageNamed: "planet")
    let planet2 = planet(imageNamed: "planet")
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
       
        if gesture.state == UIGestureRecognizerState.Began{
            updateDisp = false
            var centerNodeArray = nodesAtPoint(touchedPoint)
            centerNode = findCenterNode(centerNodeArray)!
            
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
        var scaledXDisp: CGFloat = xDisp * gesture.scale
        var scaledYDisp: CGFloat = yDisp * gesture.scale
        //*******************************************************************************************
        //********************************Correct the Zooming****************************************
        //*******************************************************************************************
        limitZooming(bgTile1, gesture, maxTileWidth, minTileWidth, minScale, maxScale)
        
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
        zoomCorrectNodes(BGNodeArray, sceneWidth, sceneHeight, numberOfTilesInRow, numberOfTilesInColumn)
        
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
        
        let planetR = planet1.size.width / 2
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
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        let BGNodeArray:Array = [bgTile1, bgTile2, bgTile3, bgTile4, bgTile5, bgTile6, bgTile7, bgTile8, bgTile9, bgTile10, bgTile11, bgTile12, bgTile13, bgTile14, bgTile15, bgTile16]
        
//*************************************************************************************************************************************************
//*************************************************Background Update Functions*********************************************************************
//*************************************************************************************************************************************************
        
        
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
        
        
        
    }
//***********************************************************************************************************************************************
//***********************************************************************************************************************************************
//***********************************************************************************************************************************************
    
}





