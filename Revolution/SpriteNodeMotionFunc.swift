//
//  SpriteNodeMotionFunc.swift
//  Revolution
//
//  Created by Cristian Alonso on 5/27/15.
//  Copyright (c) 2015 Ouroboros. All rights reserved.
//

import Foundation
import SpriteKit


// The functions below work well but not perfectly. There can be some unwanted motion in the star node with rapid zooming. For now this method is OK but try to get a method working that relies on absolute positioning. Create a variable that record the star node's position from x and y as a reference and then scale that reference with the gesture scale upon zooming.


func moveSpriteNodeWithPinch(node: SKSpriteNode, touchedPoint: CGPoint, gesture: UIPinchGestureRecognizer) -> () {
    var xDisp: CGFloat = touchedPoint.x - node.position.x
    var yDisp: CGFloat = touchedPoint.y - node.position.y
    var xDispScaled: CGFloat = xDisp * gesture.scale
    var yDispScaled: CGFloat = yDisp * gesture.scale
    node.position.x = touchedPoint.x - xDispScaled
    node.position.y = touchedPoint.y - yDispScaled
}

func moveSpriteNodeWithEdgeCorrection(node: SKSpriteNode, returnPoint: CGPoint) -> () {
    node.position.x -= returnPoint.x
    node.position.y -= returnPoint.y
}

/*
func moveSpriteNodeWithPan(node: SKSpriteNode, level: SKScene, deltaPoint: CGPoint) -> () {
    node.position = level.convertPointFromView(CGPointMake(level.convertPointToView(node.position).x+deltaPoint.x, level.convertPointToView(node.position).y+deltaPoint.y))
}
*/
func moveSpriteNodeAfterPan(node: SKSpriteNode, referenceBackgroundNode: SKSpriteNode, var oldPosition: CGPoint) -> () {
    var translationX = referenceBackgroundNode.position.x - oldPosition.x
    var translationY = referenceBackgroundNode.position.y - oldPosition.y
    node.position.x += translationX
    node.position.y += translationY
}
