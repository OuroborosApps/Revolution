//
//  TiledBackgroundFunc.swift
//  Revolution
//
//  Created by Cristian Alonso on 5/25/15.
//  Copyright (c) 2015 Ouroboros. All rights reserved.
//

import Foundation
import SpriteKit
//**************************************************************************************************************************************
//**************************************************************************************************************************************
//Below is the function called in the pinchGestureRecognizer to find the centerpoint and centerNode


func findCenterNode (centerNodeArray: NSArray) -> (SKNode)?{
    var centerNodeCounter = 0
    while centerNodeCounter <= (centerNodeArray.count - 1) && centerNodeArray[centerNodeCounter].zPosition != 0 {
        centerNodeCounter++
    }
    if centerNodeCounter > (centerNodeArray.count - 1) {
        var nilNode: SKNode = SKNode()
        nilNode.name = "bgTile6"
        return nilNode
    }
    else {
        return (centerNodeArray[centerNodeCounter] as! SKNode)
    }
    
}
//**************************************************************************************************************************************
//**************************************************************************************************************************************
// Below is the function called to correct for overshooting and adjust large scaling values and minimum and maximum tiles sizes

func limitZooming (referenceTile: SKSpriteNode, gesture: UIPinchGestureRecognizer, maxTileWidth: CGFloat, minTileWidth:CGFloat, minScale:CGFloat, maxScale:CGFloat) -> (){
    //Limits the zoom out size
    if referenceTile.size.width <= minTileWidth && gesture.scale < 1 {
        gesture.scale = 1
    }
    //Limits the zoom in size
    else if referenceTile.size.width >= maxTileWidth && gesture.scale > 1 {
        gesture.scale = 1
    }
    //Correction if scaling gets too big
    if gesture.scale < minScale {
        gesture.scale = minScale
    }
    else if gesture.scale > maxScale {
        gesture.scale = maxScale
    }
    //Correction to prevent overshooting
    if gesture.scale * referenceTile.size.width < minTileWidth {
        gesture.scale = minTileWidth / referenceTile.size.width
    }
    else if gesture.scale * referenceTile.size.width > maxTileWidth {
        gesture.scale = maxTileWidth / referenceTile.size.width
    }
}
//**************************************************************************************************************************************
//**************************************************************************************************************************************

// Below is the function called in the pinchGestureRecognizer that scales the background nodes for the zoom

func scaleBackgroundNodes (BGNodeArray: Array<SKSpriteNode>, gesture:UIPinchGestureRecognizer) -> () {
    for index in 0...(BGNodeArray.count-1) {
        BGNodeArray[index].size = CGSizeMake(BGNodeArray[index].size.width * gesture.scale, BGNodeArray[index].size.height * gesture.scale)
    }
}

// Below is the function called in the pinchGesture Recognizer as a failsafe for overshooting the zoom
func failsafeZoom (BGNodeArray: Array<SKSpriteNode>, minTileWidth: CGFloat, minTileHeight:CGFloat, maxTileWidth: CGFloat, maxTileHeight: CGFloat) -> () {
    if BGNodeArray[0].size.width < minTileWidth {
        for index in 0...(BGNodeArray.count-1) {
            BGNodeArray[index].size = CGSizeMake(minTileWidth, minTileHeight)
        }
    }
    else if BGNodeArray[0].size.width > maxTileWidth {
        for index in 0...(BGNodeArray.count-1) {
            BGNodeArray[index].size = CGSizeMake(maxTileWidth, maxTileHeight)
        }
    }
}
//**************************************************************************************************************************************
//**************************************************************************************************************************************
// Below is the function called in pinchGestureRecognizer that centers the zoom on the selected tile

func zoomCenteredOnTile(nodeSelected: Double, BGNodeArray: Array<SKSpriteNode>, numberOfTilesInRow: Double, numberOfTilesInColumn: Double, touchedPoint: CGPoint, scaledXDisp: CGFloat, scaledYDisp: CGFloat) -> () {
    
    
    var nodeIndex: Double = nodeSelected
    var nodeArrayIndex: Double = nodeIndex-1
    
    
    //set selected tile values
    BGNodeArray[Int(nodeArrayIndex)].position.x = touchedPoint.x - scaledXDisp
    BGNodeArray[Int(nodeArrayIndex)].position.y = touchedPoint.y - scaledYDisp
    
    
    
    //center on selected tile
    var columnIndex = nodeIndex % numberOfTilesInRow
    
    
    //iterate across tiles to the right of selected tile setting x position
    while columnIndex != 0 {
        ++nodeIndex
        ++nodeArrayIndex
        BGNodeArray[Int(nodeArrayIndex)].position.x =  BGNodeArray[Int(nodeArrayIndex-1)].position.x + BGNodeArray[Int(nodeArrayIndex-1)].size.width
        columnIndex = nodeIndex % numberOfTilesInRow
    }
    
    //reset to selected tile
    nodeIndex = nodeSelected
    nodeArrayIndex = nodeIndex-1
    columnIndex = nodeIndex % numberOfTilesInRow
    
    //iterate across tiles to the left of selected tile setting x position
    while columnIndex != 1 {
        --nodeIndex
        --nodeArrayIndex
        BGNodeArray[Int(nodeArrayIndex)].position.x = BGNodeArray[Int(nodeArrayIndex+1)].position.x - BGNodeArray[Int(nodeArrayIndex+1)].size.width
        columnIndex = nodeIndex % numberOfTilesInRow
    }
    var leftMostIndex = nodeIndex
    
    //reset to FIRST SET TILE FROM THE LEFT
    
    var rowIndex = ceil(nodeIndex/numberOfTilesInColumn)
    while rowIndex != 1 {
        nodeIndex -= numberOfTilesInRow
        nodeArrayIndex -= numberOfTilesInRow
        var startIndex = nodeIndex
        BGNodeArray[Int(nodeArrayIndex)].position.x = BGNodeArray[Int(nodeArrayIndex+numberOfTilesInRow)].position.x
        columnIndex = nodeIndex % numberOfTilesInRow
        while columnIndex != 0 {
            ++nodeIndex
            ++nodeArrayIndex
            BGNodeArray[Int(nodeArrayIndex)].position.x =  BGNodeArray[Int(nodeArrayIndex+numberOfTilesInRow)].position.x
            columnIndex = nodeIndex % numberOfTilesInRow
        }
        nodeIndex = startIndex
        nodeArrayIndex = nodeIndex-1
        rowIndex = ceil(nodeIndex/numberOfTilesInColumn)
    }
    nodeIndex = leftMostIndex
    nodeArrayIndex = nodeIndex-1
    columnIndex = nodeIndex % numberOfTilesInRow
    rowIndex = ceil(nodeIndex/numberOfTilesInColumn)
    
    while rowIndex != numberOfTilesInColumn {
        nodeIndex += numberOfTilesInRow
        nodeArrayIndex += numberOfTilesInRow
        var startIndex = nodeIndex
        BGNodeArray[Int(nodeArrayIndex)].position.x = BGNodeArray[Int(nodeArrayIndex-numberOfTilesInRow)].position.x
        columnIndex = nodeIndex % numberOfTilesInRow
        while columnIndex != 0 {
            ++nodeIndex
            ++nodeArrayIndex
            BGNodeArray[Int(nodeArrayIndex)].position.x =  BGNodeArray[Int(nodeArrayIndex-numberOfTilesInRow)].position.x
            columnIndex = nodeIndex % numberOfTilesInRow
        }
        
        nodeIndex = startIndex
        nodeArrayIndex = nodeIndex-1
        rowIndex = ceil(nodeIndex/numberOfTilesInColumn)
    }
    
    
    //reset to selected tile
    nodeIndex = nodeSelected
    nodeArrayIndex = nodeIndex-1
    rowIndex = ceil(nodeIndex/numberOfTilesInColumn)
    
    //iterate to tiles above selected tile setting y position
    
    while rowIndex != numberOfTilesInColumn {
        nodeIndex += numberOfTilesInRow
        nodeArrayIndex += numberOfTilesInRow
        BGNodeArray[Int(nodeArrayIndex)].position.y = BGNodeArray[Int(nodeArrayIndex-numberOfTilesInRow)].position.y - BGNodeArray[Int(nodeArrayIndex-numberOfTilesInRow)].size.height
        rowIndex = ceil(nodeIndex/numberOfTilesInColumn)
    }
    
    nodeIndex = nodeSelected
    nodeArrayIndex = nodeIndex-1
    rowIndex = ceil(nodeIndex/numberOfTilesInColumn)
    
    while rowIndex != 1 {
        nodeIndex -= numberOfTilesInRow
        nodeArrayIndex -= numberOfTilesInRow
        BGNodeArray[Int(nodeArrayIndex)].position.y = BGNodeArray[Int(nodeArrayIndex+numberOfTilesInRow)].position.y + BGNodeArray[Int(nodeArrayIndex+numberOfTilesInRow)].size.height
        rowIndex = ceil(nodeIndex/numberOfTilesInColumn)
    }
    
    var topMostIndex = nodeIndex
    
    columnIndex = nodeIndex % numberOfTilesInRow
    
    while columnIndex != 0 {
        ++nodeIndex
        ++nodeArrayIndex
        var startIndex = nodeIndex
        BGNodeArray[Int(nodeArrayIndex)].position.y = BGNodeArray[Int(nodeArrayIndex-1)].position.y
        rowIndex = ceil(nodeIndex/numberOfTilesInColumn)
        while rowIndex != numberOfTilesInColumn {
            nodeIndex += numberOfTilesInRow
            nodeArrayIndex += numberOfTilesInRow
            BGNodeArray[Int(nodeArrayIndex)].position.y = BGNodeArray[Int(nodeArrayIndex-1)].position.y
            rowIndex = ceil(nodeIndex/numberOfTilesInColumn)
        }
        nodeIndex = startIndex
        nodeArrayIndex = nodeIndex-1
        columnIndex = nodeIndex % numberOfTilesInRow
    }
    
    nodeIndex = topMostIndex
    nodeArrayIndex = nodeIndex - 1
    rowIndex = ceil(nodeIndex/numberOfTilesInColumn)
    columnIndex = nodeIndex % numberOfTilesInRow
    
    while columnIndex != 1 {
        --nodeIndex
        --nodeArrayIndex
        var startIndex = nodeIndex
        BGNodeArray[Int(nodeArrayIndex)].position.y = BGNodeArray[Int(nodeArrayIndex+1)].position.y
        rowIndex = ceil(nodeIndex/numberOfTilesInColumn)
        while rowIndex != numberOfTilesInColumn {
            nodeIndex += numberOfTilesInRow
            nodeArrayIndex += numberOfTilesInRow
            BGNodeArray[Int(nodeArrayIndex)].position.y = BGNodeArray[Int(nodeArrayIndex+1)].position.y
            rowIndex = ceil(nodeIndex/numberOfTilesInColumn)
        }
        nodeIndex = startIndex
        nodeArrayIndex = nodeIndex-1
        columnIndex = nodeIndex % numberOfTilesInRow
    }
    
    
    

}
//**************************************************************************************************************************************
//**************************************************************************************************************************************
// Below is the function called in pinchGestureRecognizer to corrected for over-zooming

func zoomCorrectNodes (BGNodeArray: Array<SKSpriteNode>, sceneWidth: CGFloat, sceneHeight: CGFloat, numberOfTilesInRow: Int, numberOfTilesInColumn: Int) -> CGPoint {
    
    var returnPoint: CGPoint = CGPointMake(0, 0)
    if (BGNodeArray[0].position.x - BGNodeArray[0].size.width/2) > 0 {
        returnPoint.x = BGNodeArray[0].position.x - BGNodeArray[0].size.width/2
        BGNodeArray[0].position.x = BGNodeArray[0].size.width/2
        for index in 1...(numberOfTilesInRow-1) {
            BGNodeArray[index].position.x = BGNodeArray[index-1].position.x + BGNodeArray[index-1].size.width
        }
        for index in numberOfTilesInRow...(BGNodeArray.count-1) {
            BGNodeArray[index].position.x = BGNodeArray[index-numberOfTilesInRow].position.x
        }
        
    }
    if (BGNodeArray[0].position.y + BGNodeArray[0].size.height/2) < sceneHeight {
        returnPoint.y = sceneHeight - (BGNodeArray[0].position.y + BGNodeArray[0].size.height/2)
        BGNodeArray[0].position.y = sceneHeight - BGNodeArray[0].size.height/2
        for index in stride (from: numberOfTilesInRow, through:(numberOfTilesInColumn*(numberOfTilesInRow-1)), by: numberOfTilesInColumn) {
            BGNodeArray[index].position.y = BGNodeArray[index-numberOfTilesInColumn].position.y - BGNodeArray[index-numberOfTilesInColumn].size.height
        }
        for iterationIndex in 0...(numberOfTilesInColumn-1) {
            for index in 1...(numberOfTilesInRow-1) {
                BGNodeArray[index+iterationIndex*numberOfTilesInRow].position.y = BGNodeArray[iterationIndex*numberOfTilesInRow].position.y
            }
        }
        
    }
    if (BGNodeArray[BGNodeArray.count-1].position.x + BGNodeArray[BGNodeArray.count-1].size.width/2) < sceneWidth {
        returnPoint.x = sceneWidth - (BGNodeArray[BGNodeArray.count-1].position.x + BGNodeArray[BGNodeArray.count-1].size.width/2)
        BGNodeArray[BGNodeArray.count-1].position.x = sceneWidth - BGNodeArray[BGNodeArray.count-1].size.width/2
        for index in stride (from:(BGNodeArray.count-2), through: (BGNodeArray.count-numberOfTilesInRow), by: -1) {
            BGNodeArray[index].position.x = BGNodeArray[index+1].position.x - BGNodeArray[index+1].size.width
        }
        for index in stride (from:(BGNodeArray.count-numberOfTilesInRow-1), through: 0, by: -1) {
            BGNodeArray[index].position.x = BGNodeArray[index+numberOfTilesInRow].position.x
        }
        
    }
    if (BGNodeArray[BGNodeArray.count-1].position.y - (BGNodeArray[BGNodeArray.count-1].size.height)/2) > 0 {
        returnPoint.y = BGNodeArray[BGNodeArray.count-1].position.y - (BGNodeArray[BGNodeArray.count-1].size.height)/2
        BGNodeArray[BGNodeArray.count-1].position.y = BGNodeArray[BGNodeArray.count-1].size.height/2
        for index in stride(from: (BGNodeArray.count-1-numberOfTilesInRow), through: (numberOfTilesInRow-1), by: (-1*numberOfTilesInRow)) {
          BGNodeArray[index].position.y = BGNodeArray[index+numberOfTilesInRow].position.y + BGNodeArray[index+numberOfTilesInRow].size.height
            
        }
        for iterationIndex in 0...(numberOfTilesInColumn-1) {
            for index in stride(from: (BGNodeArray.count-2), through: (BGNodeArray.count-numberOfTilesInRow), by: -1) {
                BGNodeArray[index-iterationIndex*numberOfTilesInRow].position.y = BGNodeArray[(BGNodeArray.count-1)-(iterationIndex*numberOfTilesInRow)].position.y
            }
        }
        
        
    }
    return returnPoint
}
//**************************************************************************************************************************************
//**************************************************************************************************************************************
// Below is the function called in the panGestureRecognizer to set the background physics bodies to dynamic

func setBGPhysicsBodiesToDynamic (BGNodeArray: Array<SKSpriteNode>) -> () {
    for index in 0...(BGNodeArray.count-1) {
        BGNodeArray[index].physicsBody?.dynamic = true
    }
}

func setBGPhysicsBodiesFromDynamic (BGNodeArray: Array<SKSpriteNode>) -> () {
    for index in 0...(BGNodeArray.count-1) {
        BGNodeArray[index].physicsBody?.dynamic = true
    }
}
//**************************************************************************************************************************************
//**************************************************************************************************************************************
// Below is the function called in the panGestureRecognizer to set the final velocity to the panned nodes

func applyFinalVelocities (BGNodeArray: Array<SKSpriteNode>, finalVelocityStorage: CGPoint) -> () {
    for index in 0...(BGNodeArray.count-1) {
        BGNodeArray[index].physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
    }
}
//**************************************************************************************************************************************
//**************************************************************************************************************************************
// Below is the function called to set up the background tiles

func setUpBackgroundTiles (BGNodeArray: Array<SKSpriteNode>,  sceneWidth: CGFloat, sceneHeight: CGFloat) -> () {
    var initialPositionArray: Array<CGPoint> = [CGPointMake(-1*sceneWidth, 2*sceneHeight),CGPointMake(0, 2*sceneHeight),CGPointMake(sceneWidth, 2*sceneHeight),CGPointMake(2*sceneWidth, 2*sceneHeight),CGPointMake(-sceneWidth, sceneHeight),CGPointMake(0, sceneHeight), CGPointMake(sceneWidth, sceneHeight), CGPointMake(2*sceneWidth, sceneHeight), CGPointMake(-sceneWidth, 0), CGPointMake(0, 0), CGPointMake(sceneWidth, 0), CGPointMake(2*sceneWidth, 0), CGPointMake(-sceneWidth, -sceneHeight), CGPointMake(0, -sceneHeight), CGPointMake(sceneWidth, -sceneHeight), CGPointMake(2*sceneWidth, -sceneHeight)]
    var nameArray: Array<String> = ["bgTile1", "bgTile2", "bgTile3", "bgTile4", "bgTile5", "bgTile6", "bgTile7", "bgTile8", "bgTile9", "bgTile10", "bgTile11", "bgTile12", "bgTile13", "bgTile14", "bgTile15", "bgTile16",]
    struct PhysicsCategory {
        static let None : UInt32 = 0
        static let All : UInt32 = UInt32.max
        static let background : UInt32 = 0b1
        static let star : UInt32 = 0b10
        static let planet : UInt32 = 0b11
    }
    for index in 0...(BGNodeArray.count-1){
        BGNodeArray[index].physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        BGNodeArray[index].physicsBody?.categoryBitMask = PhysicsCategory.background
        BGNodeArray[index].physicsBody?.contactTestBitMask = PhysicsCategory.None
        BGNodeArray[index].physicsBody?.collisionBitMask = PhysicsCategory.None
        setBGPhysicsBodiesFromDynamic(BGNodeArray)
        BGNodeArray[index].position = initialPositionArray[index]
        BGNodeArray[index].zPosition = 0
        BGNodeArray[index].name = nameArray[index]
        
    }
    
}
//**************************************************************************************************************************************
//**************************************************************************************************************************************
// Below is the function called to make the tiles follow the first tile

func followTile (BGNodeArray: Array<SKSpriteNode>) -> () {
    
    BGNodeArray[1].position.x = BGNodeArray[0].position.x + BGNodeArray[0].size.width
    BGNodeArray[1].position.y = BGNodeArray[0].position.y
    BGNodeArray[2].position.x = BGNodeArray[1].position.x + BGNodeArray[1].size.width
    BGNodeArray[2].position.y = BGNodeArray[0].position.y
    BGNodeArray[3].position.x = BGNodeArray[2].position.x + BGNodeArray[2].size.width
    BGNodeArray[3].position.y = BGNodeArray[0].position.y
    BGNodeArray[4].position.x = BGNodeArray[0].position.x
    BGNodeArray[4].position.y = BGNodeArray[0].position.y - BGNodeArray[0].size.height
    BGNodeArray[5].position.x = BGNodeArray[1].position.x
    BGNodeArray[5].position.y = BGNodeArray[4].position.y
    BGNodeArray[6].position.x = BGNodeArray[2].position.x
    BGNodeArray[6].position.y = BGNodeArray[4].position.y
    BGNodeArray[7].position.x = BGNodeArray[3].position.x
    BGNodeArray[7].position.y = BGNodeArray[4].position.y
    BGNodeArray[8].position.x = BGNodeArray[4].position.x
    BGNodeArray[8].position.y = BGNodeArray[4].position.y - BGNodeArray[4].size.height
    BGNodeArray[9].position.x = BGNodeArray[5].position.x
    BGNodeArray[9].position.y = BGNodeArray[8].position.y
    BGNodeArray[10].position.x = BGNodeArray[6].position.x
    BGNodeArray[10].position.y = BGNodeArray[8].position.y
    BGNodeArray[11].position.x = BGNodeArray[7].position.x
    BGNodeArray[11].position.y = BGNodeArray[8].position.y
    BGNodeArray[12].position.x = BGNodeArray[8].position.x
    BGNodeArray[12].position.y = BGNodeArray[8].position.y - BGNodeArray[8].size.height
    BGNodeArray[13].position.x = BGNodeArray[9].position.x
    BGNodeArray[13].position.y = BGNodeArray[12].position.y
    BGNodeArray[14].position.x = BGNodeArray[10].position.x
    BGNodeArray[14].position.y = BGNodeArray[12].position.y
    BGNodeArray[15].position.x = BGNodeArray[11].position.x
    BGNodeArray[15].position.y = BGNodeArray[12].position.y
}
//**************************************************************************************************************************************
//**************************************************************************************************************************************
// Below is the function called to set the background velocities to 0

func decreaseTileXVelocity (BGNodeArray: Array<SKSpriteNode>, decellerationConst: CGFloat) -> () {
    for index in 0...(BGNodeArray.count-1) {
        BGNodeArray[index].physicsBody?.velocity.dx -= decellerationConst
    }
}

func setTileXVelocityToZero (BGNodeArray: Array<SKSpriteNode>) -> () {
    for index in 0...(BGNodeArray.count-1) {
        BGNodeArray[index].physicsBody?.velocity.dx = 0
    }
}
func increaseTileXVelocity (BGNodeArray: Array<SKSpriteNode>, decellerationConst: CGFloat) -> () {
    for index in 0...(BGNodeArray.count-1) {
        BGNodeArray[index].physicsBody?.velocity.dx += decellerationConst
    }
}

func decreaseTileYVelocity (BGNodeArray: Array<SKSpriteNode>, decellerationConst: CGFloat) -> () {
    for index in 0...(BGNodeArray.count-1) {
        BGNodeArray[index].physicsBody?.velocity.dy -= decellerationConst
    }
}
func setTileYVelocityToZero (BGNodeArray: Array<SKSpriteNode>) -> () {
    for index in 0...(BGNodeArray.count-1) {
        BGNodeArray[index].physicsBody?.velocity.dy = 0
    }
}
func increaseTileYVelocity (BGNodeArray: Array<SKSpriteNode>, decellerationConst: CGFloat) -> () {
    for index in 0...(BGNodeArray.count-1) {
        BGNodeArray[index].physicsBody?.velocity.dy += decellerationConst
    }
}
func setTileTotalVelocityToZero (BGNodeArray: Array<SKSpriteNode>) -> () {
    for index in 0...(BGNodeArray.count-1) {
        BGNodeArray[index].physicsBody?.velocity = CGVectorMake(0, 0)
    }
}

