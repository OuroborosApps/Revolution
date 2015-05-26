//
//  TiledBackgroundFunc.swift
//  Revolution
//
//  Created by Cristian Alonso on 5/25/15.
//  Copyright (c) 2015 Ouroboros. All rights reserved.
//

import Foundation
import SpriteKit

//Below is the function called in the pinchGestureRecognizer to find the centerpoint and centerNode


func findCenterNode (centerNodeArray: NSArray) -> (SKNode)?{
    var centerNodeCounter = 0
    while centerNodeCounter <= (centerNodeArray.count - 1) && centerNodeArray[centerNodeCounter].zPosition != 0 {
        centerNodeCounter++
    }
    if centerNodeCounter > (centerNodeArray.count - 1) {
        return nil
    }
    else {
        return (centerNodeArray[centerNodeCounter] as? SKNode)!
    }
}

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


//Below is the function called in the pinchGestureRecognizer that scales the background nodes for the zoom

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

func zoomCenteredOnTile(nodeSelected: Int, BGNodeArray: Array<SKSpriteNode>, numberOfTilesInRow: Int, numberOfTilesInColumn: Int, touchedPoint: CGPoint, scaledXDisp: CGFloat, scaledYDisp: CGFloat) -> () {
    var nodeIndex = nodeSelected
    var nodeArrayIndex: Int = nodeIndex - 1
    BGNodeArray[nodeArrayIndex].position.x = touchedPoint.x - scaledXDisp
    BGNodeArray[nodeArrayIndex].position.y = touchedPoint.y - scaledYDisp
    
    var rowRem:Int = nodeIndex % numberOfTilesInRow
    var colRem:Int = nodeIndex % numberOfTilesInColumn
    var counter:Int = 0
    var iterationCounter:Int = 0
    
    while rowRem != 1 {
        ++counter
        --nodeIndex
        --nodeArrayIndex
        BGNodeArray[nodeArrayIndex].position.x = BGNodeArray[nodeArrayIndex+1].position.x - BGNodeArray[nodeArrayIndex+1].size.width
        rowRem = nodeIndex % numberOfTilesInRow
    }
    nodeIndex += counter
    nodeArrayIndex += counter
    while rowRem != 0 {
        ++nodeIndex
        ++nodeArrayIndex
        BGNodeArray[nodeArrayIndex].position.x = BGNodeArray[nodeArrayIndex-1].position.x + BGNodeArray[nodeArrayIndex-1].size.width
        rowRem = nodeIndex % numberOfTilesInRow
    }
    counter = 0
    while nodeArrayIndex < BGNodeArray.count {
        ++counter
        ++nodeArrayIndex
        BGNodeArray[nodeArrayIndex].position.x = BGNodeArray[nodeArrayIndex-numberOfTilesInRow].position.x
    }
    nodeArrayIndex -= (counter+numberOfTilesInRow-1)
    while nodeArrayIndex >= 0 {
        --nodeArrayIndex
        BGNodeArray[nodeArrayIndex].position.x = BGNodeArray[nodeArrayIndex+numberOfTilesInRow].position.x
    }
    nodeIndex = nodeSelected
    nodeArrayIndex = nodeIndex - 1
    colRem = nodeIndex % numberOfTilesInColumn
    counter = 0
    while colRem != 1 {
        ++counter
        nodeIndex -= numberOfTilesInRow
        nodeArrayIndex -= numberOfTilesInRow
        BGNodeArray[nodeArrayIndex].position.y = BGNodeArray[nodeArrayIndex+numberOfTilesInRow].position.y + BGNodeArray[nodeArrayIndex+numberOfTilesInRow].size.height
        colRem = nodeIndex % numberOfTilesInColumn
    }
    nodeIndex += (counter*numberOfTilesInRow)
    nodeArrayIndex += (counter*numberOfTilesInRow)
    while colRem != 0 {
        nodeIndex += numberOfTilesInRow
        nodeArrayIndex += numberOfTilesInRow
        BGNodeArray[nodeArrayIndex].position.y = BGNodeArray[nodeArrayIndex-numberOfTilesInRow].position.y - BGNodeArray[nodeArrayIndex-numberOfTilesInRow].size.height
        colRem = nodeIndex % numberOfTilesInColumn
    }
    counter = 0
    nodeArrayIndex -= (numberOfTilesInRow*numberOfTilesInColumn)
    nodeIndex = nodeArrayIndex+1
    
    while iterationCounter < numberOfTilesInColumn {
        ++iterationCounter
        while rowRem != 1 {
            ++counter
            --nodeIndex
            --nodeArrayIndex
            BGNodeArray[nodeArrayIndex].position.y = BGNodeArray[nodeArrayIndex+1].position.y
            rowRem = nodeIndex % numberOfTilesInRow
        }
        nodeIndex += counter
        nodeArrayIndex += counter
        while rowRem != 0 {
            ++counter
            ++nodeIndex
            ++nodeArrayIndex
            BGNodeArray[nodeArrayIndex].position.y = BGNodeArray[nodeArrayIndex-1].position.y
            rowRem = nodeIndex % numberOfTilesInRow
        }
        nodeIndex -= counter
        nodeArrayIndex -= counter
        nodeIndex += numberOfTilesInRow
        nodeArrayIndex += numberOfTilesInRow
    }  
}





