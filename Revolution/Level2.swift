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
    
    func handlePinchGesture(gesture: UIPinchGestureRecognizer){
        
        // Finds the midpoint location of the pinch gesture
        var gesturePoint = gesture.locationInView(self.view)
        var touchedPoint = convertPointFromView(gesturePoint)
        
        
        
        
        
        if gesture.state == UIGestureRecognizerState.Began{
            
            //Finds the node at the midpoint
            
            //First finds all nodes at that point then searches for the one with 0 z position
            var centerNodeArray = nodesAtPoint(touchedPoint)
            var centerNodeCounter = 0
            while centerNodeCounter <= (centerNodeArray.count - 1) && centerNodeArray[centerNodeCounter].zPosition != 0 {
                centerNodeCounter++
            }
            if centerNodeCounter > (centerNodeArray.count - 1) {
                return
            
            }
            else {
                centerNode = centerNodeArray[centerNodeCounter] as? SKNode
            }
            
            
        }
        
        
        //Error correction
        if centerNode!.name == nil {
            centerNode!.name = "bgTile6"
        }
        
        // Finding the distance between the touchedPoint and the center of the center Node
        var xDisp = touchedPoint.x - centerNode!.position.x
        var yDisp = touchedPoint.y - centerNode!.position.y
        
        
        
        //Limits the zoom out size
        if bgTile1.size.width <= 334 && gesture.scale < 1 {
            
            gesture.scale = 1
            
        }
        // limits the zoom in size
        else if bgTile1.size.width >= 1334 && gesture.scale > 1 {
            
            gesture.scale = 1
        }
        
        
        //Correction if scaling gets too big
        if gesture.scale < 0.75 {
            gesture.scale = 0.75
        }
        else if gesture.scale > 1.25 {
            gesture.scale = 1.25
        }
        
        //Correction to prevent overshooting
        if gesture.scale * bgTile1.size.width < 334 {
            gesture.scale = 334 / bgTile1.size.width
        }
        else if gesture.scale * bgTile1.size.width > 1334 {
            gesture.scale = 1334 / bgTile1.size.width
        }
        
        
        
        
        
        //Scaling Functions for the background nodes (all the planet nodes need to be added)
        bgTile1.size = CGSizeMake(bgTile1.size.width * gesture.scale, bgTile1.size.height * gesture.scale)
        bgTile2.size = CGSizeMake(bgTile2.size.width * gesture.scale, bgTile2.size.height * gesture.scale)
        bgTile3.size = CGSizeMake(bgTile3.size.width * gesture.scale, bgTile3.size.height * gesture.scale)
        bgTile4.size = CGSizeMake(bgTile4.size.width * gesture.scale, bgTile4.size.height * gesture.scale)
        bgTile5.size = CGSizeMake(bgTile5.size.width * gesture.scale, bgTile5.size.height * gesture.scale)
        bgTile6.size = CGSizeMake(bgTile6.size.width * gesture.scale, bgTile6.size.height * gesture.scale)
        bgTile7.size = CGSizeMake(bgTile7.size.width * gesture.scale, bgTile7.size.height * gesture.scale)
        bgTile8.size = CGSizeMake(bgTile8.size.width * gesture.scale, bgTile8.size.height * gesture.scale)
        bgTile9.size = CGSizeMake(bgTile9.size.width * gesture.scale, bgTile9.size.height * gesture.scale)
        bgTile10.size = CGSizeMake(bgTile10.size.width * gesture.scale, bgTile10.size.height * gesture.scale)
        bgTile11.size = CGSizeMake(bgTile11.size.width * gesture.scale, bgTile11.size.height * gesture.scale)
        bgTile12.size = CGSizeMake(bgTile12.size.width * gesture.scale, bgTile12.size.height * gesture.scale)
        bgTile13.size = CGSizeMake(bgTile13.size.width * gesture.scale, bgTile13.size.height * gesture.scale)
        bgTile14.size = CGSizeMake(bgTile14.size.width * gesture.scale, bgTile14.size.height * gesture.scale)
        bgTile15.size = CGSizeMake(bgTile15.size.width * gesture.scale, bgTile15.size.height * gesture.scale)
        bgTile16.size = CGSizeMake(bgTile16.size.width * gesture.scale, bgTile16.size.height * gesture.scale)
        
        //Additional nodes present in the scene also need to be scaled below
        
        star1.size = CGSizeMake(star1.size.width * gesture.scale, star1.size.height * gesture.scale)
        
       
        var scaledXDisp = xDisp * gesture.scale
        var scaledYDisp = yDisp * gesture.scale
        
        
        //Failsafe : Corrects if the scale function overshoots the scaling for either zoom in or zoom out
        if bgTile1.size.width < 334 {
            
            bgTile1.size = CGSizeMake(334, 188)
            bgTile2.size = CGSizeMake(334, 188)
            bgTile3.size = CGSizeMake(334, 188)
            bgTile4.size = CGSizeMake(334, 188)
            bgTile5.size = CGSizeMake(334, 188)
            bgTile6.size = CGSizeMake(334, 188)
            bgTile7.size = CGSizeMake(334, 188)
            bgTile8.size = CGSizeMake(334, 188)
            bgTile9.size = CGSizeMake(334, 188)
            bgTile10.size = CGSizeMake(334, 188)
            bgTile11.size = CGSizeMake(334, 188)
            bgTile12.size = CGSizeMake(334, 188)
            bgTile13.size = CGSizeMake(334, 188)
            bgTile14.size = CGSizeMake(334, 188)
            bgTile15.size = CGSizeMake(334, 188)
            bgTile16.size = CGSizeMake(334, 188)
        }
        else if bgTile1.size.width > 1334 {
            
            bgTile1.size = CGSizeMake(1334, 750)
            bgTile2.size = CGSizeMake(1334, 750)
            bgTile3.size = CGSizeMake(1334, 750)
            bgTile4.size = CGSizeMake(1334, 750)
            bgTile5.size = CGSizeMake(1334, 750)
            bgTile6.size = CGSizeMake(1334, 750)
            bgTile7.size = CGSizeMake(1334, 750)
            bgTile8.size = CGSizeMake(1334, 750)
            bgTile9.size = CGSizeMake(1334, 750)
            bgTile10.size = CGSizeMake(1334, 750)
            bgTile11.size = CGSizeMake(1334, 750)
            bgTile12.size = CGSizeMake(1334, 750)
            bgTile13.size = CGSizeMake(1334, 750)
            bgTile14.size = CGSizeMake(1334, 750)
            bgTile15.size = CGSizeMake(1334, 750)
            bgTile16.size = CGSizeMake(1334, 750)
        }
        
        
        
        
        // Creates cases for each node that is being zoomed into, to allow that node to be the center of the zooming. 
        var centerNodeName = String(centerNode!.name!)
        
            switch centerNodeName {
            
            case "bgTile1":
                
               bgTile1.position.x = touchedPoint.x - scaledXDisp
               bgTile1.position.y = touchedPoint.y - scaledYDisp
                
            bgTile2.position.x = bgTile1.position.x + bgTile1.size.width
            bgTile2.position.y = bgTile1.position.y
            bgTile3.position.x = bgTile2.position.x + bgTile2.size.width
            bgTile3.position.y = bgTile1.position.y
            bgTile4.position.x = bgTile3.position.x + bgTile3.size.width
            bgTile4.position.y = bgTile1.position.y
            bgTile5.position.x = bgTile1.position.x
            bgTile5.position.y = bgTile1.position.y - bgTile1.size.height
            bgTile6.position.x = bgTile2.position.x
            bgTile6.position.y = bgTile5.position.y
            bgTile7.position.x = bgTile3.position.x
            bgTile7.position.y = bgTile5.position.y
            bgTile8.position.x = bgTile4.position.x
            bgTile8.position.y = bgTile5.position.y
            bgTile9.position.x = bgTile5.position.x
            bgTile9.position.y = bgTile5.position.y - bgTile5.size.height
            bgTile10.position.x = bgTile6.position.x
            bgTile10.position.y = bgTile9.position.y
            bgTile11.position.x = bgTile7.position.x
            bgTile11.position.y = bgTile9.position.y
            bgTile12.position.x = bgTile8.position.x
            bgTile12.position.y = bgTile9.position.y
            bgTile13.position.x = bgTile9.position.x
            bgTile13.position.y = bgTile9.position.y - bgTile9.size.height
            bgTile14.position.x = bgTile10.position.x
            bgTile14.position.y = bgTile13.position.y
            bgTile15.position.x = bgTile11.position.x
            bgTile15.position.y = bgTile13.position.y
            bgTile16.position.x = bgTile12.position.x
            bgTile16.position.y = bgTile13.position.y
                
            case "bgTile2":
                
               bgTile2.position.x = touchedPoint.x - scaledXDisp
               bgTile2.position.y = touchedPoint.y - scaledYDisp
                
                bgTile1.position.x = bgTile2.position.x - bgTile2.size.width
                bgTile1.position.y = bgTile2.position.y
                bgTile3.position.x = bgTile2.position.x + bgTile2.size.width
                bgTile3.position.y = bgTile1.position.y
                bgTile4.position.x = bgTile3.position.x + bgTile3.size.width
               bgTile4.position.y = bgTile1.position.y
               bgTile5.position.x = bgTile1.position.x
                bgTile5.position.y = bgTile1.position.y - bgTile1.size.height
                bgTile6.position.x = bgTile2.position.x
                bgTile6.position.y = bgTile5.position.y
                bgTile7.position.x = bgTile3.position.x
                bgTile7.position.y = bgTile5.position.y
                bgTile8.position.x = bgTile4.position.x
                bgTile8.position.y = bgTile5.position.y
                bgTile9.position.x = bgTile5.position.x
                bgTile9.position.y = bgTile5.position.y - bgTile5.size.height
                bgTile10.position.x = bgTile6.position.x
                bgTile10.position.y = bgTile9.position.y
                bgTile11.position.x = bgTile7.position.x
                bgTile11.position.y = bgTile9.position.y
                bgTile12.position.x = bgTile8.position.x
                bgTile12.position.y = bgTile9.position.y
                bgTile13.position.x = bgTile9.position.x
                bgTile13.position.y = bgTile9.position.y - bgTile9.size.height
                bgTile14.position.x = bgTile10.position.x
                bgTile14.position.y = bgTile13.position.y
                bgTile15.position.x = bgTile11.position.x
                bgTile15.position.y = bgTile13.position.y
                bgTile16.position.x = bgTile12.position.x
                bgTile16.position.y = bgTile13.position.y
                
            case "bgTile3":
                
              bgTile3.position.x = touchedPoint.x - scaledXDisp
                bgTile3.position.y = touchedPoint.y - scaledYDisp
                
                bgTile2.position.x = bgTile3.position.x - bgTile3.size.width
                bgTile2.position.y = bgTile3.position.y
                bgTile1.position.x = bgTile2.position.x - bgTile2.size.width
                bgTile1.position.y = bgTile2.position.y
                bgTile4.position.x = bgTile3.position.x + bgTile3.size.width
                bgTile4.position.y = bgTile1.position.y
                bgTile5.position.x = bgTile1.position.x
                bgTile5.position.y = bgTile1.position.y - bgTile1.size.height
                bgTile6.position.x = bgTile2.position.x
                bgTile6.position.y = bgTile5.position.y
                bgTile7.position.x = bgTile3.position.x
                bgTile7.position.y = bgTile5.position.y
                bgTile8.position.x = bgTile4.position.x
                bgTile8.position.y = bgTile5.position.y
                bgTile9.position.x = bgTile5.position.x
                bgTile9.position.y = bgTile5.position.y - bgTile5.size.height
                bgTile10.position.x = bgTile6.position.x
                bgTile10.position.y = bgTile9.position.y
                bgTile11.position.x = bgTile7.position.x
                bgTile11.position.y = bgTile9.position.y
                bgTile12.position.x = bgTile8.position.x
                bgTile12.position.y = bgTile9.position.y
                bgTile13.position.x = bgTile9.position.x
                bgTile13.position.y = bgTile9.position.y - bgTile9.size.height
                bgTile14.position.x = bgTile10.position.x
                bgTile14.position.y = bgTile13.position.y
                bgTile15.position.x = bgTile11.position.x
                bgTile15.position.y = bgTile13.position.y
                bgTile16.position.x = bgTile12.position.x
                bgTile16.position.y = bgTile13.position.y
                
            case "bgTile4":
                
               bgTile4.position.x = touchedPoint.x - scaledXDisp
                bgTile4.position.y = touchedPoint.y - scaledYDisp
                
                bgTile3.position.x = bgTile4.position.x - bgTile4.size.width
                bgTile3.position.y = bgTile4.position.y
                bgTile2.position.x = bgTile3.position.x - bgTile3.size.width
                bgTile2.position.y = bgTile4.position.y
                bgTile1.position.x = bgTile2.position.x - bgTile2.size.width
                bgTile1.position.y = bgTile4.position.y
                bgTile5.position.x = bgTile1.position.x
                bgTile5.position.y = bgTile1.position.y - bgTile1.size.height
                bgTile6.position.x = bgTile2.position.x
                bgTile6.position.y = bgTile5.position.y
                bgTile7.position.x = bgTile3.position.x
                bgTile7.position.y = bgTile5.position.y
                bgTile8.position.x = bgTile4.position.x
                bgTile8.position.y = bgTile5.position.y
                bgTile9.position.x = bgTile5.position.x
                bgTile9.position.y = bgTile5.position.y - bgTile5.size.height
                bgTile10.position.x = bgTile6.position.x
                bgTile10.position.y = bgTile9.position.y
                bgTile11.position.x = bgTile7.position.x
                bgTile11.position.y = bgTile9.position.y
                bgTile12.position.x = bgTile8.position.x
                bgTile12.position.y = bgTile9.position.y
                bgTile13.position.x = bgTile9.position.x
                bgTile13.position.y = bgTile9.position.y - bgTile9.size.height
                bgTile14.position.x = bgTile10.position.x
                bgTile14.position.y = bgTile13.position.y
                bgTile15.position.x = bgTile11.position.x
                bgTile15.position.y = bgTile13.position.y
                bgTile16.position.x = bgTile12.position.x
                bgTile16.position.y = bgTile13.position.y
                
            case "bgTile5":
                
                bgTile5.position.x = touchedPoint.x - scaledXDisp
                bgTile5.position.y = touchedPoint.y - scaledYDisp
                
                bgTile1.position.x = bgTile5.position.x
                bgTile1.position.y = bgTile5.position.y + bgTile5.size.height
                bgTile2.position.x = bgTile1.position.x + bgTile1.size.width
                bgTile2.position.y = bgTile1.position.y
                bgTile3.position.x = bgTile2.position.x + bgTile2.size.width
                bgTile3.position.y = bgTile1.position.y
                bgTile4.position.x = bgTile3.position.x + bgTile3.size.width
                bgTile4.position.y = bgTile1.position.y
                bgTile6.position.x = bgTile2.position.x
                bgTile6.position.y = bgTile5.position.y
                bgTile7.position.x = bgTile3.position.x
                bgTile7.position.y = bgTile5.position.y
                bgTile8.position.x = bgTile4.position.x
                bgTile8.position.y = bgTile5.position.y
                bgTile9.position.x = bgTile5.position.x
                bgTile9.position.y = bgTile5.position.y - bgTile5.size.height
                bgTile10.position.x = bgTile6.position.x
                bgTile10.position.y = bgTile9.position.y
                bgTile11.position.x = bgTile7.position.x
                bgTile11.position.y = bgTile9.position.y
                bgTile12.position.x = bgTile8.position.x
                bgTile12.position.y = bgTile9.position.y
                bgTile13.position.x = bgTile9.position.x
                bgTile13.position.y = bgTile9.position.y - bgTile9.size.height
                bgTile14.position.x = bgTile10.position.x
                bgTile14.position.y = bgTile13.position.y
                bgTile15.position.x = bgTile11.position.x
                bgTile15.position.y = bgTile13.position.y
                bgTile16.position.x = bgTile12.position.x
                bgTile16.position.y = bgTile13.position.y
                
            case "bgTile6":
                
                bgTile6.position.x = touchedPoint.x - scaledXDisp
                bgTile6.position.y = touchedPoint.y - scaledYDisp
                
                bgTile1.position.x = bgTile6.position.x - bgTile6.size.width
                bgTile1.position.y = bgTile6.position.y + bgTile6.size.height
                bgTile2.position.x = bgTile6.position.x
                bgTile2.position.y = bgTile1.position.y
                bgTile3.position.x = bgTile2.position.x + bgTile2.size.width
                bgTile3.position.y = bgTile1.position.y
                bgTile4.position.x = bgTile3.position.x + bgTile3.size.width
                bgTile4.position.y = bgTile1.position.y
                bgTile5.position.x = bgTile1.position.x
                bgTile5.position.y = bgTile6.position.y
                bgTile7.position.x = bgTile3.position.x
                bgTile7.position.y = bgTile5.position.y
                bgTile8.position.x = bgTile4.position.x
                bgTile8.position.y = bgTile5.position.y
                bgTile9.position.x = bgTile5.position.x
                bgTile9.position.y = bgTile5.position.y - bgTile5.size.height
                bgTile10.position.x = bgTile6.position.x
                bgTile10.position.y = bgTile9.position.y
                bgTile11.position.x = bgTile7.position.x
                bgTile11.position.y = bgTile9.position.y
                bgTile12.position.x = bgTile8.position.x
                bgTile12.position.y = bgTile9.position.y
                bgTile13.position.x = bgTile9.position.x
                bgTile13.position.y = bgTile9.position.y - bgTile9.size.height
                bgTile14.position.x = bgTile10.position.x
                bgTile14.position.y = bgTile13.position.y
                bgTile15.position.x = bgTile11.position.x
                bgTile15.position.y = bgTile13.position.y
                bgTile16.position.x = bgTile12.position.x
                bgTile16.position.y = bgTile13.position.y

                
                
            case "bgTile7":
                
                bgTile7.position.x = touchedPoint.x - scaledXDisp
                bgTile7.position.y = touchedPoint.y - scaledYDisp
                
                bgTile3.position.x = bgTile7.position.x
                bgTile3.position.y = bgTile7.position.y + bgTile7.size.height
                bgTile2.position.x = bgTile3.position.x - bgTile3.size.width
                bgTile2.position.y = bgTile3.position.y
                bgTile1.position.x = bgTile2.position.x - bgTile2.size.width
                bgTile1.position.y = bgTile2.position.y
                bgTile4.position.x = bgTile3.position.x + bgTile3.size.width
                bgTile4.position.y = bgTile3.position.y
                bgTile5.position.x = bgTile1.position.x
                bgTile5.position.y = bgTile7.position.y
                bgTile6.position.x = bgTile2.position.x
                bgTile6.position.y = bgTile5.position.y
                bgTile8.position.x = bgTile4.position.x
                bgTile8.position.y = bgTile5.position.y
                bgTile9.position.x = bgTile1.position.x
                bgTile9.position.y = bgTile5.position.y - bgTile5.size.height
                bgTile10.position.x = bgTile2.position.x
                bgTile10.position.y = bgTile9.position.y
                bgTile11.position.x = bgTile3.position.x
                bgTile11.position.y = bgTile9.position.y
                bgTile12.position.x = bgTile4.position.x
                bgTile12.position.y = bgTile9.position.y
                bgTile13.position.x = bgTile1.position.x
                bgTile13.position.y = bgTile9.position.y - bgTile9.size.height
                bgTile14.position.x = bgTile2.position.x
                bgTile14.position.y = bgTile13.position.y
                bgTile15.position.x = bgTile3.position.x
                bgTile15.position.y = bgTile13.position.y
                bgTile16.position.x = bgTile4.position.x
                bgTile16.position.y = bgTile13.position.y
                
                
            case "bgTile8":
                
                bgTile8.position.x = touchedPoint.x - scaledXDisp
                bgTile8.position.y = touchedPoint.y - scaledYDisp
                
                bgTile4.position.x = bgTile8.position.x
                bgTile4.position.y = bgTile8.position.y + bgTile8.size.height
                bgTile3.position.x = bgTile4.position.x - bgTile4.size.width
                bgTile3.position.y = bgTile4.position.y
                bgTile2.position.x = bgTile3.position.x - bgTile3.size.width
                bgTile2.position.y = bgTile3.position.y
                bgTile1.position.x = bgTile2.position.x - bgTile2.size.width
                bgTile5.position.x = bgTile1.position.x
                bgTile5.position.y = bgTile8.position.y
                bgTile6.position.x = bgTile2.position.x
                bgTile6.position.y = bgTile5.position.y
                bgTile7.position.x = bgTile3.position.x
                bgTile7.position.y = bgTile5.position.y
                bgTile9.position.x = bgTile1.position.x
                bgTile9.position.y = bgTile8.position.y - bgTile8.size.height
                bgTile10.position.x = bgTile2.position.x
                bgTile10.position.y = bgTile9.position.y
                bgTile11.position.x = bgTile3.position.x
                bgTile11.position.y = bgTile9.position.y
                bgTile12.position.x = bgTile4.position.x
                bgTile12.position.y = bgTile9.position.y
                bgTile13.position.x = bgTile1.position.x
                bgTile13.position.y = bgTile9.position.y - bgTile9.size.height
                bgTile14.position.x = bgTile2.position.x
                bgTile14.position.y = bgTile13.position.y
                bgTile15.position.x = bgTile3.position.x
                bgTile15.position.y = bgTile13.position.y
                bgTile16.position.x = bgTile4.position.x
                bgTile16.position.y = bgTile13.position.y
                
                
                
                
            case "bgTile9":
                
                bgTile9.position.x = touchedPoint.x - scaledXDisp
                bgTile9.position.y = touchedPoint.y - scaledYDisp
                
                bgTile5.position.x = bgTile9.position.x
                bgTile5.position.y = bgTile9.position.y + bgTile9.size.height
                bgTile1.position.x = bgTile5.position.x
                bgTile1.position.y = bgTile5.position.y + bgTile5.size.height
                bgTile2.position.x = bgTile1.position.x + bgTile1.size.width
                bgTile2.position.y = bgTile1.position.y
                bgTile3.position.x = bgTile2.position.x + bgTile2.size.width
                bgTile3.position.y = bgTile1.position.y
                bgTile4.position.x = bgTile3.position.x + bgTile3.size.width
                bgTile4.position.y = bgTile1.position.y
                bgTile6.position.x = bgTile2.position.x
                bgTile6.position.y = bgTile5.position.y
                bgTile7.position.x = bgTile3.position.x
                bgTile7.position.y = bgTile5.position.y
                bgTile8.position.x = bgTile4.position.x
                bgTile8.position.y = bgTile5.position.y
                bgTile10.position.x = bgTile2.position.x
                bgTile10.position.y = bgTile9.position.y
                bgTile11.position.x = bgTile3.position.x
                bgTile11.position.y = bgTile9.position.y
                bgTile12.position.x = bgTile4.position.x
                bgTile12.position.y = bgTile9.position.y
                bgTile13.position.x = bgTile1.position.x
                bgTile13.position.y = bgTile9.position.y - bgTile9.size.height
                bgTile14.position.x = bgTile2.position.x
                bgTile14.position.y = bgTile13.position.y
                bgTile15.position.x = bgTile3.position.x
                bgTile15.position.y = bgTile13.position.y
                bgTile16.position.x = bgTile4.position.x
                bgTile16.position.y = bgTile13.position.y
                
            case "bgTile10":
                
                bgTile10.position.x = touchedPoint.x - scaledXDisp
                bgTile10.position.y = touchedPoint.y - scaledYDisp
                
                
                bgTile6.position.x = bgTile10.position.x
                bgTile6.position.y = bgTile10.position.y + bgTile10.size.height
                bgTile2.position.x = bgTile6.position.x
                bgTile2.position.y = bgTile6.position.y + bgTile6.size.height
                bgTile1.position.x = bgTile2.position.x - bgTile2.size.width
                bgTile1.position.y = bgTile2.position.y
                bgTile3.position.x = bgTile2.position.x + bgTile2.size.width
                bgTile3.position.y = bgTile1.position.y
                bgTile4.position.x = bgTile3.position.x + bgTile3.size.width
                bgTile4.position.y = bgTile1.position.y
                bgTile5.position.x = bgTile1.position.x
                bgTile5.position.y = bgTile6.position.y
                bgTile7.position.x = bgTile3.position.x
                bgTile7.position.y = bgTile5.position.y
                bgTile8.position.x = bgTile4.position.x
                bgTile8.position.y = bgTile5.position.y
                bgTile9.position.x = bgTile1.position.x
                bgTile9.position.y = bgTile5.position.y - bgTile5.size.height
                bgTile11.position.x = bgTile3.position.x
                bgTile11.position.y = bgTile9.position.y
                bgTile12.position.x = bgTile4.position.x
                bgTile12.position.y = bgTile9.position.y
                bgTile13.position.x = bgTile1.position.x
                bgTile13.position.y = bgTile9.position.y - bgTile9.size.height
                bgTile14.position.x = bgTile2.position.x
                bgTile14.position.y = bgTile13.position.y
                bgTile15.position.x = bgTile3.position.x
                bgTile15.position.y = bgTile13.position.y
                bgTile16.position.x = bgTile4.position.x
                bgTile16.position.y = bgTile13.position.y
                
            case "bgTile11":
                
                bgTile11.position.x = touchedPoint.x - scaledXDisp
                bgTile11.position.y = touchedPoint.y - scaledYDisp
                
                bgTile7.position.x = bgTile11.position.x
                bgTile7.position.y = bgTile11.position.y + bgTile11.size.height
                bgTile3.position.x = bgTile7.position.x
                bgTile3.position.y = bgTile7.position.y + bgTile7.size.height
                bgTile2.position.x = bgTile3.position.x - bgTile3.size.width
                bgTile2.position.y = bgTile3.position.y
                bgTile1.position.x = bgTile2.position.x - bgTile2.size.width
                bgTile1.position.y = bgTile2.position.y
                bgTile4.position.x = bgTile3.position.x + bgTile3.size.width
                bgTile4.position.y = bgTile1.position.y
                bgTile5.position.x = bgTile1.position.x
                bgTile5.position.y = bgTile7.position.y
                bgTile6.position.x = bgTile2.position.x
                bgTile6.position.y = bgTile5.position.y
                bgTile8.position.x = bgTile4.position.x
                bgTile8.position.y = bgTile5.position.y
                bgTile9.position.x = bgTile1.position.x
                bgTile9.position.y = bgTile11.position.y
                bgTile10.position.x = bgTile2.position.x
                bgTile10.position.y = bgTile9.position.y
                bgTile12.position.x = bgTile4.position.x
                bgTile12.position.y = bgTile9.position.y
                bgTile13.position.x = bgTile1.position.x
                bgTile13.position.y = bgTile9.position.y - bgTile9.size.height
                bgTile14.position.x = bgTile2.position.x
                bgTile14.position.y = bgTile13.position.y
                bgTile15.position.x = bgTile3.position.x
                bgTile15.position.y = bgTile13.position.y
                bgTile16.position.x = bgTile4.position.x
                bgTile16.position.y = bgTile13.position.y
                
            case "bgTile12":
                
                bgTile12.position.x = touchedPoint.x - scaledXDisp
                bgTile12.position.y = touchedPoint.y - scaledYDisp
                
                bgTile8.position.x = bgTile12.position.x
                bgTile8.position.y = bgTile12.position.y + bgTile12.size.height
                bgTile4.position.x = bgTile4.position.x
                bgTile4.position.y = bgTile8.position.y + bgTile8.size.height
                bgTile3.position.x = bgTile4.position.x - bgTile3.size.width
                bgTile3.position.y = bgTile4.position.y
                bgTile2.position.x = bgTile3.position.x - bgTile3.size.width
                bgTile2.position.y = bgTile3.position.y
                bgTile1.position.x = bgTile2.position.x - bgTile2.size.width
                bgTile1.position.y = bgTile2.position.y
                bgTile5.position.x = bgTile1.position.x
                bgTile5.position.y = bgTile8.position.y
                bgTile6.position.x = bgTile2.position.x
                bgTile6.position.y = bgTile5.position.y
                bgTile7.position.x = bgTile3.position.x
                bgTile7.position.y = bgTile5.position.y
                bgTile9.position.x = bgTile1.position.x
                bgTile9.position.y = bgTile12.position.y
                bgTile10.position.x = bgTile2.position.x
                bgTile10.position.y = bgTile9.position.y
                bgTile11.position.x = bgTile3.position.x
                bgTile11.position.y = bgTile9.position.y
                bgTile13.position.x = bgTile1.position.x
                bgTile13.position.y = bgTile12.position.y - bgTile12.size.height
                bgTile14.position.x = bgTile2.position.x
                bgTile14.position.y = bgTile13.position.y
                bgTile15.position.x = bgTile3.position.x
                bgTile15.position.y = bgTile13.position.y
                bgTile16.position.x = bgTile4.position.x
                bgTile16.position.y = bgTile13.position.y

                
            case "bgTile13":
                
                bgTile13.position.x = touchedPoint.x - scaledXDisp
                bgTile13.position.y = touchedPoint.y - scaledYDisp
                
                bgTile9.position.x = bgTile13.position.x
                bgTile9.position.y = bgTile13.position.y + bgTile13.size.height
                bgTile5.position.x = bgTile9.position.x
                bgTile5.position.y = bgTile9.position.y + bgTile9.size.height
                bgTile1.position.x = bgTile5.position.x
                bgTile1.position.y = bgTile5.position.y + bgTile5.size.height
                bgTile2.position.x = bgTile1.position.x + bgTile1.size.width
                bgTile2.position.y = bgTile1.position.y
                bgTile3.position.x = bgTile2.position.x + bgTile2.size.width
                bgTile3.position.y = bgTile1.position.y
                bgTile4.position.x = bgTile3.position.x + bgTile3.size.width
                bgTile6.position.x = bgTile2.position.x
                bgTile6.position.y = bgTile5.position.y
                bgTile7.position.x = bgTile3.position.x
                bgTile7.position.y = bgTile5.position.y
                bgTile8.position.x = bgTile4.position.x
                bgTile8.position.y = bgTile5.position.y
                bgTile10.position.x = bgTile2.position.x
                bgTile10.position.y = bgTile9.position.y
                bgTile11.position.x = bgTile3.position.x
                bgTile11.position.y = bgTile9.position.y
                bgTile12.position.x = bgTile4.position.x
                bgTile12.position.y = bgTile9.position.y
                bgTile14.position.x = bgTile2.position.x
                bgTile14.position.y = bgTile13.position.y
                bgTile15.position.x = bgTile3.position.x
                bgTile15.position.y = bgTile13.position.y
                bgTile16.position.x = bgTile4.position.x
                bgTile16.position.y = bgTile13.position.y
                
                
            case "bgTile14":
                
                bgTile14.position.x = touchedPoint.x - scaledXDisp
                bgTile14.position.y = touchedPoint.y - scaledYDisp
                
                bgTile10.position.x = bgTile14.position.x
                bgTile10.position.y = bgTile14.position.y + bgTile14.size.height
                bgTile6.position.x = bgTile10.position.x
                bgTile6.position.y = bgTile10.position.y + bgTile10.size.height
                bgTile2.position.x = bgTile6.position.x
                bgTile2.position.y = bgTile6.position.y + bgTile6.size.height
                bgTile1.position.x = bgTile2.position.x - bgTile2.size.width
                bgTile1.position.y = bgTile2.position.y
                bgTile3.position.x = bgTile2.position.x + bgTile2.size.width
                bgTile3.position.y = bgTile1.position.y
                bgTile4.position.x = bgTile3.position.x + bgTile3.size.width
                bgTile4.position.y = bgTile1.position.y
                bgTile5.position.x = bgTile1.position.x
                bgTile5.position.y = bgTile6.position.y
                bgTile7.position.x = bgTile3.position.x
                bgTile7.position.y = bgTile5.position.y
                bgTile8.position.x = bgTile4.position.x
                bgTile8.position.y = bgTile5.position.y
                bgTile9.position.x = bgTile1.position.x
                bgTile9.position.y = bgTile10.position.y
                bgTile11.position.x = bgTile3.position.x
                bgTile11.position.y = bgTile9.position.y
                bgTile12.position.x = bgTile4.position.x
                bgTile12.position.y = bgTile9.position.y
                bgTile13.position.x = bgTile1.position.x
                bgTile13.position.y = bgTile14.position.y
                bgTile15.position.x = bgTile3.position.x
                bgTile15.position.y = bgTile13.position.y
                bgTile16.position.x = bgTile4.position.x
                bgTile16.position.y = bgTile13.position.y
                
            case "bgTile15":
                
                bgTile15.position.x = touchedPoint.x - scaledXDisp
                bgTile15.position.y = touchedPoint.y - scaledYDisp
                
                bgTile11.position.x = bgTile15.position.x
                bgTile11.position.y = bgTile15.position.y + bgTile15.size.height
                bgTile7.position.x = bgTile11.position.x
                bgTile7.position.y = bgTile11.position.y + bgTile11.size.height
                bgTile3.position.x = bgTile7.position.x
                bgTile3.position.y = bgTile7.position.y + bgTile7.size.height
                bgTile2.position.x = bgTile3.position.x - bgTile3.size.width
                bgTile2.position.y = bgTile3.position.y
                bgTile1.position.x = bgTile2.position.x - bgTile2.size.width
                bgTile1.position.y = bgTile2.position.y
                bgTile4.position.x = bgTile3.position.x + bgTile3.size.width
                bgTile4.position.y = bgTile1.position.y
                bgTile5.position.x = bgTile1.position.x
                bgTile5.position.y = bgTile6.position.y
                bgTile7.position.x = bgTile3.position.x
                bgTile7.position.y = bgTile5.position.y
                bgTile8.position.x = bgTile4.position.x
                bgTile8.position.y = bgTile5.position.y
                bgTile9.position.x = bgTile1.position.x
                bgTile9.position.y = bgTile10.position.y
                bgTile11.position.x = bgTile3.position.x
                bgTile11.position.y = bgTile9.position.y
                bgTile12.position.x = bgTile4.position.x
                bgTile12.position.y = bgTile9.position.y
                bgTile13.position.x = bgTile1.position.x
                bgTile13.position.y = bgTile14.position.y
                bgTile14.position.x = bgTile2.position.x
                bgTile14.position.y = bgTile13.position.y
                bgTile16.position.x = bgTile4.position.x
                bgTile16.position.y = bgTile13.position.y
                
            
            case "bgTile16":
                
                bgTile16.position.x = touchedPoint.x - scaledXDisp
                bgTile16.position.y = touchedPoint.y - scaledYDisp
                
                bgTile12.position.x = bgTile16.position.x
                bgTile12.position.y = bgTile16.position.y + bgTile16.size.height
                bgTile8.position.x = bgTile12.position.x
                bgTile8.position.y = bgTile12.position.y + bgTile12.size.height
                bgTile4.position.x = bgTile8.position.x
                bgTile4.position.y = bgTile8.position.y + bgTile8.size.height
                bgTile3.position.x = bgTile4.position.x - bgTile4.size.width
                bgTile3.position.y = bgTile4.position.y
                bgTile2.position.x = bgTile3.position.x - bgTile3.size.width
                bgTile2.position.y = bgTile3.position.y
                bgTile1.position.x = bgTile2.position.x - bgTile2.size.width
                bgTile5.position.x = bgTile1.position.x
                bgTile5.position.y = bgTile8.position.y
                bgTile6.position.x = bgTile2.position.x
                bgTile6.position.y = bgTile5.position.y
                bgTile7.position.x = bgTile3.position.x
                bgTile7.position.y = bgTile5.position.y
                bgTile9.position.x = bgTile1.position.x
                bgTile9.position.y = bgTile12.position.y
                bgTile10.position.x = bgTile2.position.x
                bgTile10.position.y = bgTile9.position.y
                bgTile11.position.x = bgTile3.position.x
                bgTile11.position.y = bgTile9.position.y
                bgTile13.position.x = bgTile1.position.x
                bgTile13.position.y = bgTile16.position.y
                bgTile14.position.x = bgTile2.position.x
                bgTile14.position.y = bgTile13.position.y
                bgTile15.position.x = bgTile3.position.x
                bgTile15.position.y = bgTile13.position.y
                
                
                
                
            default:
                return
            
            
            
        }
        
        
        
        // If statements correcting for if the zoom would cause the nodes to zoom out of scene
        
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
        }
        
        if bgTile1.position.y + bgTile1.size.height/2 < 750 {
        
        bgTile1.position.y = 750 - bgTile1.size.height/2
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
        }
        
        if bgTile16.position.x + bgTile16.size.width/2 < 1334 {
        
            bgTile16.position.x = 1334 - bgTile16.size.width/2
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
        }
        
        gesture.scale = 1
    }
    
    
    
    func handlePanGesture(panGesture: UIPanGestureRecognizer){
        
        
        
        
        
        if panGesture.state == UIGestureRecognizerState.Began {
            
            bgTile1.physicsBody?.dynamic = true
            bgTile2.physicsBody?.dynamic = true
            bgTile3.physicsBody?.dynamic = true
            bgTile4.physicsBody?.dynamic = true
            bgTile5.physicsBody?.dynamic = true
            bgTile6.physicsBody?.dynamic = true
            bgTile7.physicsBody?.dynamic = true
            bgTile8.physicsBody?.dynamic = true
            bgTile9.physicsBody?.dynamic = true
            bgTile10.physicsBody?.dynamic = true
            bgTile11.physicsBody?.dynamic = true
            bgTile12.physicsBody?.dynamic = true
            bgTile13.physicsBody?.dynamic = true
            bgTile14.physicsBody?.dynamic = true
            bgTile15.physicsBody?.dynamic = true
            bgTile16.physicsBody?.dynamic = true
            
            
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
            
            var tempConvbgTile1pos = convertPointToView(bgTile1.position)
            var tempConvbgTile2pos = convertPointToView(bgTile2.position)
            var tempConvbgTile3pos = convertPointToView(bgTile3.position)
            var tempConvbgTile4pos = convertPointToView(bgTile4.position)
            var tempConvbgTile5pos = convertPointToView(bgTile5.position)
            var tempConvbgTile6pos = convertPointToView(bgTile6.position)
            var tempConvbgTile7pos = convertPointToView(bgTile7.position)
            var tempConvbgTile8pos = convertPointToView(bgTile8.position)
            var tempConvbgTile9pos = convertPointToView(bgTile9.position)
            var tempConvbgTile10pos = convertPointToView(bgTile10.position)
            var tempConvbgTile11pos = convertPointToView(bgTile11.position)
            var tempConvbgTile12pos = convertPointToView(bgTile12.position)
            var tempConvbgTile13pos = convertPointToView(bgTile13.position)
            var tempConvbgTile14pos = convertPointToView(bgTile14.position)
            var tempConvbgTile15pos = convertPointToView(bgTile15.position)
            var tempConvbgTile16pos = convertPointToView(bgTile16.position)
            
            tempConvbgTile1pos.x = tempConvbgTile1pos.x + deltaPoint.x
            tempConvbgTile2pos.x = tempConvbgTile2pos.x + deltaPoint.x
            tempConvbgTile3pos.x = tempConvbgTile3pos.x + deltaPoint.x
            tempConvbgTile4pos.x = tempConvbgTile4pos.x + deltaPoint.x
            tempConvbgTile5pos.x = tempConvbgTile5pos.x + deltaPoint.x
            tempConvbgTile6pos.x = tempConvbgTile6pos.x + deltaPoint.x
            tempConvbgTile7pos.x = tempConvbgTile7pos.x + deltaPoint.x
            tempConvbgTile8pos.x = tempConvbgTile8pos.x + deltaPoint.x
            tempConvbgTile9pos.x = tempConvbgTile9pos.x + deltaPoint.x
            tempConvbgTile10pos.x = tempConvbgTile10pos.x + deltaPoint.x
            tempConvbgTile11pos.x = tempConvbgTile11pos.x + deltaPoint.x
            tempConvbgTile12pos.x = tempConvbgTile12pos.x + deltaPoint.x
            tempConvbgTile13pos.x = tempConvbgTile13pos.x + deltaPoint.x
            tempConvbgTile14pos.x = tempConvbgTile14pos.x + deltaPoint.x
            tempConvbgTile15pos.x = tempConvbgTile15pos.x + deltaPoint.x
            tempConvbgTile16pos.x = tempConvbgTile16pos.x + deltaPoint.x
            
            
            tempConvbgTile1pos.y = tempConvbgTile1pos.y - deltaPoint.y
            tempConvbgTile2pos.y = tempConvbgTile2pos.y - deltaPoint.y
            tempConvbgTile3pos.y = tempConvbgTile3pos.y - deltaPoint.y
            tempConvbgTile4pos.y = tempConvbgTile4pos.y - deltaPoint.y
            tempConvbgTile5pos.y = tempConvbgTile5pos.y - deltaPoint.y
            tempConvbgTile6pos.y = tempConvbgTile6pos.y - deltaPoint.y
            tempConvbgTile7pos.y = tempConvbgTile7pos.y - deltaPoint.y
            tempConvbgTile8pos.y = tempConvbgTile8pos.y - deltaPoint.y
            tempConvbgTile9pos.y = tempConvbgTile9pos.y - deltaPoint.y
            tempConvbgTile10pos.y = tempConvbgTile10pos.y - deltaPoint.y
            tempConvbgTile11pos.y = tempConvbgTile11pos.y - deltaPoint.y
            tempConvbgTile12pos.y = tempConvbgTile12pos.y - deltaPoint.y
            tempConvbgTile13pos.y = tempConvbgTile13pos.y - deltaPoint.y
            tempConvbgTile14pos.y = tempConvbgTile14pos.y - deltaPoint.y
            tempConvbgTile15pos.y = tempConvbgTile15pos.y - deltaPoint.y
            tempConvbgTile16pos.y = tempConvbgTile16pos.y - deltaPoint.y
            
            bgTile1.position = convertPointFromView(tempConvbgTile1pos)
            bgTile2.position = convertPointFromView(tempConvbgTile2pos)
            bgTile3.position = convertPointFromView(tempConvbgTile3pos)
            bgTile4.position = convertPointFromView(tempConvbgTile4pos)
            bgTile5.position = convertPointFromView(tempConvbgTile5pos)
            bgTile6.position = convertPointFromView(tempConvbgTile6pos)
            bgTile7.position = convertPointFromView(tempConvbgTile7pos)
            bgTile8.position = convertPointFromView(tempConvbgTile8pos)
            bgTile9.position = convertPointFromView(tempConvbgTile9pos)
            bgTile10.position = convertPointFromView(tempConvbgTile10pos)
            bgTile11.position = convertPointFromView(tempConvbgTile11pos)
            bgTile12.position = convertPointFromView(tempConvbgTile12pos)
            bgTile13.position = convertPointFromView(tempConvbgTile13pos)
            bgTile14.position = convertPointFromView(tempConvbgTile14pos)
            bgTile15.position = convertPointFromView(tempConvbgTile15pos)
            bgTile16.position = convertPointFromView(tempConvbgTile16pos)

            
            if bgTile1.position.y - deltaPoint.y < self.size.height / 2 {
                
                deltaPoint.y = self.size.height / 2 - bgTile1.position.y
                
            }
                
            else if bgTile13.position.y - deltaPoint.y > self.size.height / 2 {
                deltaPoint.y = self.size.height / 2 - bgTile13.position.y
            }
            
            
            
            
            
            
            panGesture.setTranslation(CGPointZero, inView: self.view)
            
        }
        
        var finalVelocityStorage = panGesture.velocityInView(self.view)
        
        if panGesture.state == UIGestureRecognizerState.Ended {
            
            
            
            bgTile1.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile2.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile3.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile4.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile5.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile6.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile7.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile8.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile9.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile10.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile11.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile12.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile13.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile14.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile15.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            bgTile16.physicsBody?.velocity = CGVectorMake(finalVelocityStorage.x, -finalVelocityStorage.y)
            
            
            hasBeenStopped = false
            
            
            
        }
        
        

    }
    
    
    
    var pinchRecognizer: UIPinchGestureRecognizer?
    var panRecognizer: UIPanGestureRecognizer?
    
    var hasBeenStopped = false
    
    
    var centerNode: SKNode?
    
    
    let star1 = star(imageNamed: "star")
    let planet1 = planet(imageNamed: "planet")
    let planet2 = planet(imageNamed: "planet")
    let gravityField = SKFieldNode.radialGravityField()
    
    
    //Creating the Tiled Background Nodes
    
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
    

    
    override func didMoveToView(view: SKView) {
        
        
        
        //Adding the Tiled Background
        
        
        bgTile1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile3.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile4.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile5.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile6.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile7.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile8.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile9.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile10.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile11.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile12.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile13.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile14.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile15.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        bgTile16.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
        
        
        bgTile1.physicsBody?.categoryBitMask = PhysicsCategory.background
        bgTile2.physicsBody?.categoryBitMask = PhysicsCategory.background
        bgTile3.physicsBody?.categoryBitMask = PhysicsCategory.background
        bgTile4.physicsBody?.categoryBitMask = PhysicsCategory.background
        bgTile5.physicsBody?.categoryBitMask = PhysicsCategory.background
        bgTile6.physicsBody?.categoryBitMask = PhysicsCategory.background
        bgTile7.physicsBody?.categoryBitMask = PhysicsCategory.background
        bgTile8.physicsBody?.categoryBitMask = PhysicsCategory.background
        bgTile9.physicsBody?.categoryBitMask = PhysicsCategory.background
        bgTile10.physicsBody?.categoryBitMask = PhysicsCategory.background
        bgTile11.physicsBody?.categoryBitMask = PhysicsCategory.background
        bgTile12.physicsBody?.categoryBitMask = PhysicsCategory.background
        bgTile13.physicsBody?.categoryBitMask = PhysicsCategory.background
        bgTile14.physicsBody?.categoryBitMask = PhysicsCategory.background
        bgTile15.physicsBody?.categoryBitMask = PhysicsCategory.background
        bgTile16.physicsBody?.categoryBitMask = PhysicsCategory.background
        
        bgTile1.physicsBody?.contactTestBitMask = PhysicsCategory.None
        bgTile2.physicsBody?.contactTestBitMask = PhysicsCategory.None
        bgTile3.physicsBody?.contactTestBitMask = PhysicsCategory.None
        bgTile4.physicsBody?.contactTestBitMask = PhysicsCategory.None
        bgTile5.physicsBody?.contactTestBitMask = PhysicsCategory.None
        bgTile6.physicsBody?.contactTestBitMask = PhysicsCategory.None
        bgTile7.physicsBody?.contactTestBitMask = PhysicsCategory.None
        bgTile8.physicsBody?.contactTestBitMask = PhysicsCategory.None
        bgTile9.physicsBody?.contactTestBitMask = PhysicsCategory.None
        bgTile10.physicsBody?.contactTestBitMask = PhysicsCategory.None
        bgTile11.physicsBody?.contactTestBitMask = PhysicsCategory.None
        bgTile12.physicsBody?.contactTestBitMask = PhysicsCategory.None
        bgTile13.physicsBody?.contactTestBitMask = PhysicsCategory.None
        bgTile14.physicsBody?.contactTestBitMask = PhysicsCategory.None
        bgTile15.physicsBody?.contactTestBitMask = PhysicsCategory.None
        bgTile16.physicsBody?.contactTestBitMask = PhysicsCategory.None
        
        bgTile1.physicsBody?.collisionBitMask = PhysicsCategory.None
        bgTile2.physicsBody?.collisionBitMask = PhysicsCategory.None
        bgTile3.physicsBody?.collisionBitMask = PhysicsCategory.None
        bgTile4.physicsBody?.collisionBitMask = PhysicsCategory.None
        bgTile5.physicsBody?.collisionBitMask = PhysicsCategory.None
        bgTile6.physicsBody?.collisionBitMask = PhysicsCategory.None
        bgTile7.physicsBody?.collisionBitMask = PhysicsCategory.None
        bgTile8.physicsBody?.collisionBitMask = PhysicsCategory.None
        bgTile9.physicsBody?.collisionBitMask = PhysicsCategory.None
        bgTile10.physicsBody?.collisionBitMask = PhysicsCategory.None
        bgTile11.physicsBody?.collisionBitMask = PhysicsCategory.None
        bgTile12.physicsBody?.collisionBitMask = PhysicsCategory.None
        bgTile13.physicsBody?.collisionBitMask = PhysicsCategory.None
        bgTile14.physicsBody?.collisionBitMask = PhysicsCategory.None
        bgTile15.physicsBody?.collisionBitMask = PhysicsCategory.None
        bgTile16.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        
        bgTile1.physicsBody?.dynamic = false
        bgTile2.physicsBody?.dynamic = false
        bgTile3.physicsBody?.dynamic = false
        bgTile4.physicsBody?.dynamic = false
        bgTile5.physicsBody?.dynamic = false
        bgTile6.physicsBody?.dynamic = false
        bgTile7.physicsBody?.dynamic = false
        bgTile8.physicsBody?.dynamic = false
        bgTile9.physicsBody?.dynamic = false
        bgTile10.physicsBody?.dynamic = false
        bgTile11.physicsBody?.dynamic = false
        bgTile12.physicsBody?.dynamic = false
        bgTile13.physicsBody?.dynamic = false
        bgTile14.physicsBody?.dynamic = false
        bgTile15.physicsBody?.dynamic = false
        bgTile16.physicsBody?.dynamic = false
        

        
        
        bgTile1.position = CGPointMake(-1334, 1500)
        bgTile2.position = CGPointMake(0, 1500)
        bgTile3.position = CGPointMake(1334, 1500)
        bgTile4.position = CGPointMake(2668, 1500)
        bgTile5.position = CGPointMake(-1334, 750)
        bgTile6.position = CGPointMake(0, 750)
        bgTile7.position = CGPointMake(1334, 750)
        bgTile8.position = CGPointMake(2668, 750)
        bgTile9.position = CGPointMake(-1334, 0)
        bgTile10.position = CGPointMake(0, 0)
        bgTile11.position = CGPointMake(1334, 0)
        bgTile12.position = CGPointMake(2668, 0)
        bgTile13.position = CGPointMake(-1334, -750)
        bgTile14.position = CGPointMake(0, -750)
        bgTile15.position = CGPointMake(1334, -750)
        bgTile16.position = CGPointMake(2668, -750)

        
        
        bgTile1.zPosition = 0
        bgTile2.zPosition = 0
        bgTile3.zPosition = 0
        bgTile4.zPosition = 0
        bgTile5.zPosition = 0
        bgTile6.zPosition = 0
        bgTile7.zPosition = 0
        bgTile8.zPosition = 0
        bgTile9.zPosition = 0
        bgTile10.zPosition = 0
        bgTile11.zPosition = 0
        bgTile12.zPosition = 0
        bgTile13.zPosition = 0
        bgTile14.zPosition = 0
        bgTile15.zPosition = 0
        bgTile16.zPosition = 0
        
        bgTile1.name = "bgTile1"
        bgTile2.name = "bgTile2"
        bgTile3.name = "bgTile3"
        bgTile4.name = "bgTile4"
        bgTile5.name = "bgTile5"
        bgTile6.name = "bgTile6"
        bgTile7.name = "bgTile7"
        bgTile8.name = "bgTile8"
        bgTile9.name = "bgTile9"
        bgTile10.name = "bgTile10"
        bgTile11.name = "bgTile11"
        bgTile12.name = "bgTile12"
        bgTile13.name = "bgTile13"
        bgTile14.name = "bgTile14"
        bgTile15.name = "bgTile15"
        bgTile16.name = "bgTile16"
        
        
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
        
        
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        let radius = star1.size.width / 2
        
        gravityField.enabled = true;
        gravityField.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        gravityField.strength = Float(pow(radius, 2)) * pow(10, -3.3)
        
        //addChild(gravityField)
        
        
        //Star Creation
        
        star1.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        star1.physicsBody?.friction = 0
        star1.physicsBody?.linearDamping = 0
        star1.physicsBody?.angularDamping = 0
        star1.zPosition = 1
        star1.physicsBody?.categoryBitMask = PhysicsCategory.star
        star1.physicsBody?.contactTestBitMask = PhysicsCategory.planet
        star1.physicsBody?.collisionBitMask = PhysicsCategory.star
        addChild(star1)
        
        
        
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

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if touches.count == 2 {
            
            bgTile1.physicsBody?.dynamic = false
            bgTile2.physicsBody?.dynamic = false
            bgTile3.physicsBody?.dynamic = false
            bgTile4.physicsBody?.dynamic = false
            bgTile5.physicsBody?.dynamic = false
            bgTile6.physicsBody?.dynamic = false
            bgTile7.physicsBody?.dynamic = false
            bgTile8.physicsBody?.dynamic = false
            bgTile9.physicsBody?.dynamic = false
            bgTile10.physicsBody?.dynamic = false
            bgTile11.physicsBody?.dynamic = false
            bgTile12.physicsBody?.dynamic = false
            bgTile13.physicsBody?.dynamic = false
            bgTile14.physicsBody?.dynamic = false
            bgTile15.physicsBody?.dynamic = false
            bgTile16.physicsBody?.dynamic = false
            
        }
        
    }

    
    

    override func update(currentTime: CFTimeInterval) {
        
        var decellerationConst:CGFloat = 7
        
        
        
        
        
        
        
       
        
        
        if bgTile1.physicsBody?.velocity.dx != 0 || bgTile1.physicsBody?.velocity.dy != 0 {
        
        bgTile2.position.x = bgTile1.position.x + bgTile1.size.width
        bgTile2.position.y = bgTile1.position.y
        bgTile3.position.x = bgTile2.position.x + bgTile2.size.width
        bgTile3.position.y = bgTile1.position.y
        bgTile4.position.x = bgTile3.position.x + bgTile3.size.width
        bgTile4.position.y = bgTile1.position.y
        bgTile5.position.x = bgTile1.position.x
        bgTile5.position.y = bgTile1.position.y - bgTile1.size.height
        bgTile6.position.x = bgTile2.position.x
        bgTile6.position.y = bgTile5.position.y
        bgTile7.position.x = bgTile3.position.x
        bgTile7.position.y = bgTile5.position.y
        bgTile8.position.x = bgTile4.position.x
        bgTile8.position.y = bgTile5.position.y
        bgTile9.position.x = bgTile5.position.x
        bgTile9.position.y = bgTile5.position.y - bgTile5.size.height
        bgTile10.position.x = bgTile6.position.x
        bgTile10.position.y = bgTile9.position.y
        bgTile11.position.x = bgTile7.position.x
        bgTile11.position.y = bgTile9.position.y
        bgTile12.position.x = bgTile8.position.x
        bgTile12.position.y = bgTile9.position.y
        bgTile13.position.x = bgTile9.position.x
        bgTile13.position.y = bgTile9.position.y - bgTile9.size.height
        bgTile14.position.x = bgTile10.position.x
        bgTile14.position.y = bgTile13.position.y
        bgTile15.position.x = bgTile11.position.x
        bgTile15.position.y = bgTile13.position.y
        bgTile16.position.x = bgTile12.position.x
        bgTile16.position.y = bgTile13.position.y
        
        
        }
        
        
        
        
        
        
        
        if bgTile1.physicsBody?.velocity.dx > decellerationConst {
            
            bgTile1.physicsBody?.velocity.dx -= decellerationConst
            bgTile2.physicsBody?.velocity.dx -= decellerationConst
            bgTile3.physicsBody?.velocity.dx -= decellerationConst
            bgTile4.physicsBody?.velocity.dx -= decellerationConst
            bgTile5.physicsBody?.velocity.dx -= decellerationConst
            bgTile6.physicsBody?.velocity.dx -= decellerationConst
            bgTile7.physicsBody?.velocity.dx -= decellerationConst
            bgTile8.physicsBody?.velocity.dx -= decellerationConst
            bgTile9.physicsBody?.velocity.dx -= decellerationConst
            bgTile10.physicsBody?.velocity.dx -= decellerationConst
            bgTile11.physicsBody?.velocity.dx -= decellerationConst
            bgTile12.physicsBody?.velocity.dx -= decellerationConst
            bgTile13.physicsBody?.velocity.dx -= decellerationConst
            bgTile14.physicsBody?.velocity.dx -= decellerationConst
            bgTile15.physicsBody?.velocity.dx -= decellerationConst
            bgTile16.physicsBody?.velocity.dx -= decellerationConst
        }
        else if bgTile1.physicsBody?.velocity.dx <= decellerationConst && bgTile1.physicsBody?.velocity.dx > 0 {
            bgTile1.physicsBody?.velocity.dx = 0
            bgTile2.physicsBody?.velocity.dx = 0
            bgTile3.physicsBody?.velocity.dx = 0
            bgTile4.physicsBody?.velocity.dx = 0
            bgTile5.physicsBody?.velocity.dx = 0
            bgTile6.physicsBody?.velocity.dx = 0
            bgTile7.physicsBody?.velocity.dx = 0
            bgTile8.physicsBody?.velocity.dx = 0
            bgTile9.physicsBody?.velocity.dx = 0
            bgTile10.physicsBody?.velocity.dx = 0
            bgTile11.physicsBody?.velocity.dx = 0
            bgTile12.physicsBody?.velocity.dx = 0
            bgTile13.physicsBody?.velocity.dx = 0
            bgTile14.physicsBody?.velocity.dx = 0
            bgTile15.physicsBody?.velocity.dx = 0
            bgTile16.physicsBody?.velocity.dx = 0
            
        }
        else if bgTile1.physicsBody?.velocity.dx >= -decellerationConst && bgTile1.physicsBody?.velocity.dx < 0 {
            bgTile1.physicsBody?.velocity.dx = 0
            bgTile2.physicsBody?.velocity.dx = 0
            bgTile3.physicsBody?.velocity.dx = 0
            bgTile4.physicsBody?.velocity.dx = 0
            bgTile5.physicsBody?.velocity.dx = 0
            bgTile6.physicsBody?.velocity.dx = 0
            bgTile7.physicsBody?.velocity.dx = 0
            bgTile8.physicsBody?.velocity.dx = 0
            bgTile9.physicsBody?.velocity.dx = 0
            bgTile10.physicsBody?.velocity.dx = 0
            bgTile11.physicsBody?.velocity.dx = 0
            bgTile12.physicsBody?.velocity.dx = 0
            bgTile13.physicsBody?.velocity.dx = 0
            bgTile14.physicsBody?.velocity.dx = 0
            bgTile15.physicsBody?.velocity.dx = 0
            bgTile16.physicsBody?.velocity.dx = 0
        }
        else if bgTile1.physicsBody?.velocity.dx < -decellerationConst {
            bgTile1.physicsBody?.velocity.dx += decellerationConst
            bgTile2.physicsBody?.velocity.dx += decellerationConst
            bgTile3.physicsBody?.velocity.dx += decellerationConst
            bgTile4.physicsBody?.velocity.dx += decellerationConst
            bgTile5.physicsBody?.velocity.dx += decellerationConst
            bgTile6.physicsBody?.velocity.dx += decellerationConst
            bgTile7.physicsBody?.velocity.dx += decellerationConst
            bgTile8.physicsBody?.velocity.dx += decellerationConst
            bgTile9.physicsBody?.velocity.dx += decellerationConst
            bgTile10.physicsBody?.velocity.dx += decellerationConst
            bgTile11.physicsBody?.velocity.dx += decellerationConst
            bgTile12.physicsBody?.velocity.dx += decellerationConst
            bgTile13.physicsBody?.velocity.dx += decellerationConst
            bgTile14.physicsBody?.velocity.dx += decellerationConst
            bgTile15.physicsBody?.velocity.dx += decellerationConst
            bgTile16.physicsBody?.velocity.dx += decellerationConst
        }
        
        if bgTile1.physicsBody?.velocity.dy > decellerationConst {
            
            bgTile1.physicsBody?.velocity.dy -= decellerationConst
            bgTile2.physicsBody?.velocity.dy -= decellerationConst
            bgTile3.physicsBody?.velocity.dy -= decellerationConst
            bgTile4.physicsBody?.velocity.dy -= decellerationConst
            bgTile5.physicsBody?.velocity.dy -= decellerationConst
            bgTile6.physicsBody?.velocity.dy -= decellerationConst
            bgTile7.physicsBody?.velocity.dy -= decellerationConst
            bgTile8.physicsBody?.velocity.dy -= decellerationConst
            bgTile9.physicsBody?.velocity.dy -= decellerationConst
            bgTile10.physicsBody?.velocity.dy -= decellerationConst
            bgTile11.physicsBody?.velocity.dy -= decellerationConst
            bgTile12.physicsBody?.velocity.dy -= decellerationConst
            bgTile13.physicsBody?.velocity.dy -= decellerationConst
            bgTile14.physicsBody?.velocity.dy -= decellerationConst
            bgTile15.physicsBody?.velocity.dy -= decellerationConst
            bgTile16.physicsBody?.velocity.dy -= decellerationConst
        }
        else if bgTile1.physicsBody?.velocity.dy <= decellerationConst && bgTile1.physicsBody?.velocity.dy > 0 {
            bgTile1.physicsBody?.velocity.dy = 0
            bgTile2.physicsBody?.velocity.dy = 0
            bgTile3.physicsBody?.velocity.dy = 0
            bgTile4.physicsBody?.velocity.dy = 0
            bgTile5.physicsBody?.velocity.dy = 0
            bgTile6.physicsBody?.velocity.dy = 0
            bgTile7.physicsBody?.velocity.dy = 0
            bgTile8.physicsBody?.velocity.dy = 0
            bgTile9.physicsBody?.velocity.dy = 0
            bgTile10.physicsBody?.velocity.dy = 0
            bgTile11.physicsBody?.velocity.dy = 0
            bgTile12.physicsBody?.velocity.dy = 0
            bgTile13.physicsBody?.velocity.dy = 0
            bgTile14.physicsBody?.velocity.dy = 0
            bgTile15.physicsBody?.velocity.dy = 0
            bgTile16.physicsBody?.velocity.dy = 0
            
        }
        else if bgTile1.physicsBody?.velocity.dy >= -decellerationConst && bgTile1.physicsBody?.velocity.dy < 0 {
            bgTile1.physicsBody?.velocity.dy = 0
            bgTile2.physicsBody?.velocity.dy = 0
            bgTile3.physicsBody?.velocity.dy = 0
            bgTile4.physicsBody?.velocity.dy = 0
            bgTile5.physicsBody?.velocity.dy = 0
            bgTile6.physicsBody?.velocity.dy = 0
            bgTile7.physicsBody?.velocity.dy = 0
            bgTile8.physicsBody?.velocity.dy = 0
            bgTile9.physicsBody?.velocity.dy = 0
            bgTile10.physicsBody?.velocity.dy = 0
            bgTile11.physicsBody?.velocity.dy = 0
            bgTile12.physicsBody?.velocity.dy = 0
            bgTile13.physicsBody?.velocity.dy = 0
            bgTile14.physicsBody?.velocity.dy = 0
            bgTile15.physicsBody?.velocity.dy = 0
            bgTile16.physicsBody?.velocity.dy = 0
        }
        else if bgTile1.physicsBody?.velocity.dy < -decellerationConst {
            bgTile1.physicsBody?.velocity.dy += decellerationConst
            bgTile2.physicsBody?.velocity.dy += decellerationConst
            bgTile3.physicsBody?.velocity.dy += decellerationConst
            bgTile4.physicsBody?.velocity.dy += decellerationConst
            bgTile5.physicsBody?.velocity.dy += decellerationConst
            bgTile6.physicsBody?.velocity.dy += decellerationConst
            bgTile7.physicsBody?.velocity.dy += decellerationConst
            bgTile8.physicsBody?.velocity.dy += decellerationConst
            bgTile9.physicsBody?.velocity.dy += decellerationConst
            bgTile10.physicsBody?.velocity.dy += decellerationConst
            bgTile11.physicsBody?.velocity.dy += decellerationConst
            bgTile12.physicsBody?.velocity.dy += decellerationConst
            bgTile13.physicsBody?.velocity.dy += decellerationConst
            bgTile14.physicsBody?.velocity.dy += decellerationConst
            bgTile15.physicsBody?.velocity.dy += decellerationConst
            bgTile16.physicsBody?.velocity.dy += decellerationConst
        }
        
        
        if bgTile1.physicsBody?.velocity.dx == 0 && bgTile1.physicsBody?.velocity.dy == 0 && !hasBeenStopped {
            
            bgTile1.physicsBody?.dynamic = false
            bgTile2.physicsBody?.dynamic = false
            bgTile3.physicsBody?.dynamic = false
            bgTile4.physicsBody?.dynamic = false
            bgTile5.physicsBody?.dynamic = false
            bgTile6.physicsBody?.dynamic = false
            bgTile7.physicsBody?.dynamic = false
            bgTile8.physicsBody?.dynamic = false
            bgTile9.physicsBody?.dynamic = false
            bgTile10.physicsBody?.dynamic = false
            bgTile11.physicsBody?.dynamic = false
            bgTile12.physicsBody?.dynamic = false
            bgTile13.physicsBody?.dynamic = false
            bgTile14.physicsBody?.dynamic = false
            bgTile15.physicsBody?.dynamic = false
            bgTile16.physicsBody?.dynamic = false
            
            
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
            
            
            
            bgTile1.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile2.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile3.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile4.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile5.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile6.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile7.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile8.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile9.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile10.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile11.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile12.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile13.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile14.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile15.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile16.physicsBody?.velocity = CGVectorMake(0, 0)
            
            
        }
        
        if bgTile1.position.y + bgTile1.size.height/2 < 750 {
            
            bgTile1.position.y = 750 - bgTile1.size.height/2
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
            
            
            
            bgTile1.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile2.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile3.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile4.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile5.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile6.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile7.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile8.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile9.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile10.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile11.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile12.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile13.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile14.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile15.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile16.physicsBody?.velocity = CGVectorMake(0, 0)
        }
        
        if bgTile16.position.x + bgTile16.size.width/2 < 1334 {
            
            bgTile16.position.x = 1334 - bgTile16.size.width/2
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
            
            
            
            
            bgTile1.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile2.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile3.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile4.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile5.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile6.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile7.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile8.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile9.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile10.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile11.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile12.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile13.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile14.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile15.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile16.physicsBody?.velocity = CGVectorMake(0, 0)
            
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
            
            
            
            bgTile1.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile2.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile3.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile4.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile5.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile6.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile7.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile8.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile9.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile10.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile11.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile12.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile13.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile14.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile15.physicsBody?.velocity = CGVectorMake(0, 0)
            bgTile16.physicsBody?.velocity = CGVectorMake(0, 0)
        }
        
        
        
        
        
    }

        
        
    

    
    
    
        
    }


    


