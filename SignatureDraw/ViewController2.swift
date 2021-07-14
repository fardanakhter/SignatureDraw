//
//  ViewController2.swift
//  SignatureDraw
//
//  Created by Fardan Akhter on 7/15/20.
//  Copyright © 2020 Fardan. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    
    var lastpoint: CGPoint = CGPoint.zero
    var isSwiped = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        containerView.layer.cornerRadius = 10.0
        containerView.layer.borderColor = UIColor.green.withAlphaComponent(0.5).cgColor
        containerView.layer.borderWidth = 5.0
        
    }
    
    func draw(from: CGPoint, to: CGPoint){
        UIGraphicsBeginImageContext(self.containerView.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //This continues the drawing from prev context to current context
        tempImageView.image?.draw(in: self.containerView.bounds)
        context.move(to: from)
        context.addLine(to: to)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(2.0)
        
        context.strokePath()
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let first = touches.first else { return }
        isSwiped = false
        lastpoint = first.location(in: containerView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let first = touches.first else { return }
        isSwiped = true
        
        let newpoint = first.location(in: containerView)
        draw(from: lastpoint, to: newpoint)
        lastpoint = newpoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        if !isSwiped{
            draw(from: lastpoint, to: lastpoint)
        }

        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: containerView.bounds, blendMode: .normal, alpha: 1.0)
        tempImageView?.image?.draw(in: containerView.bounds, blendMode: .normal, alpha: 1.0)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        tempImageView.image = nil

    }
    
    @IBAction func back(_ sender: Any) {
        if let image = mainImageView.image {
            if let data = image.pngData(){
                UserDefaults.standard.set(data, forKey: "signature")
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
