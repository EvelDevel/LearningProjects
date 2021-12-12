//
//  GameScene.swift
//  11-Pachinko
//
//  Created by Евгений Никитин on 12.12.2021.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        setupBackground()
    }
    
    /// Privates
    private func setupBackground() {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
    }
}
