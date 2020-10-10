//
//  ViewController.swift
//  FaceIt
//
//  Created by SHIN YOON AH on 2020/09/08.
//  Copyright © 2020 SHIN YOON AH. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    var expression = FacialExpression(eyes: .closed, eyeBrows: .furrowed, mouth: .smirk) {
        didSet {
            updateUI()
        }
    }

    @IBOutlet weak var faceView: FaceView! {
        didSet{
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.decreaseHappiness)
            )
            sadderSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(recognizer:))
            ))
            
            updateUI()
        }
    }
    
    private var mouthCurvatures = [FacialExpression.Mouth.frown:-1.0, .grin:0.5, .smile:1.0, .smirk:-0.5, .neutral:0.0]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.relaxed:0.5, .furrowed:-0.5, .normal:0.0]
    
    @objc func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    @objc func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    @IBAction func toggleEyes(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            switch expression.eyes {
            case .open: expression.eyes = .closed
            case .closed: expression.eyes = .open
            case .squinting: break
            }
        }
    }
    
    private func updateUI() {
        switch expression.eyes {
        case .open: faceView.eyesOpen = true
        case .closed: faceView.eyesOpen = false
        case .squinting: faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }
}

