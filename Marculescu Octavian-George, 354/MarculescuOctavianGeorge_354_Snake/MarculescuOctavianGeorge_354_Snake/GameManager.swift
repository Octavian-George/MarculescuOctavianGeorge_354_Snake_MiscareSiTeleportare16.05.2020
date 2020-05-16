//
//  GameManager.swift
//  MarculescuOctavianGeorge_354_Snake
//
//  Created by user169232 on 5/5/20.
//  Copyright © 2020 Marculescu Octavian. All rights reserved.
//

import SpriteKit

class GameManager{
    var scene:GameScene!
    var nextTime: Double?
    var timeExtension: Double = 0.15
    var playerDirection: Int = 4

    init(scene:GameScene){
        self.scene=scene
    }
    
    //pozitia de start a sarpelui
    func initGame() {
        scene.playerPositions.append((10, 10))
        scene.playerPositions.append((10, 11))
        scene.playerPositions.append((10, 12))
        scene.playerPositions.append((10, 13))
        renderChange()
    }
    
    //2
    func update (time: Double) {
        if nextTime == nil {
            nextTime = time + timeExtension
        } else {
            if time >= nextTime! {
                nextTime = time + timeExtension
                updatePlayerPosition()
            }
        }
    }
    
    //culoarea sarpelui
    func renderChange() {
        for (node, x, y) in scene.gameArray {
            if contains(a: scene.playerPositions, v: (x,y)) {
                node.fillColor = SKColor.red
            } else {
                node.fillColor = SKColor.clear
            }
        }
    }
    
    //Verificarea coordonatelor
    func contains(a:[(Int, Int)], v:(Int,Int)) -> Bool {
    let (c1, c2) = v
    for (v1, v2) in a { if v1 == c1 && v2 == c2 { return true } }
    return false
    }
    
    //miscarea sarpelui
    private func updatePlayerPosition() {
        //initializarea directiei de start
        var xChange = -1
        var yChange = 0
        //coordonatele de directie
        switch playerDirection {
             case 1:
                //left
                xChange = -1
                yChange = 0
                break
             case 2:
                //up
                xChange = 0
                yChange = -1
                break
             case 3:
                //right
                xChange = 1
                yChange = 0
                break
             case 4:
                //down
                xChange = 0
                yChange = 1
                break
            default:
                break
        }
        //6
        if scene.playerPositions.count > 0 {
            var start = scene.playerPositions.count - 1
            while start > 0 {
                scene.playerPositions[start] = scene.playerPositions[start - 1]
                start -= 1
            }
            scene.playerPositions[0] = (scene.playerPositions[0].0 + yChange, scene.playerPositions[0].1 + xChange)
        }
        
        

        //teleportarea
        if scene.playerPositions.count > 0 {
            let x = scene.playerPositions[0].1
            let y = scene.playerPositions[0].0
            if y > 41 {
                scene.playerPositions[0].0 = 0
            } else if y < 0 {
                scene.playerPositions[0].0 = 41
            } else if x > 27 {
               scene.playerPositions[0].1 = 0
            } else if x < 0 {
                scene.playerPositions[0].1 = 27
            }
        }
        //7
        renderChange()
    }
    func swipe(ID: Int) {
        if !(ID == 2 && playerDirection == 4) && !(ID == 4 && playerDirection == 2) {
            if !(ID == 1 && playerDirection == 3) && !(ID == 3 && playerDirection == 1) {
                playerDirection = ID
            }
        }
    }
}
