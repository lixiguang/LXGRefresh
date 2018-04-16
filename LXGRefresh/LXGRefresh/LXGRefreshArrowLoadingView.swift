//
//  LXGRefreshArrowLoadingView.swift
//  LXGRrefresh
//
//  Created by 黎曦光 on 2018/4/16.
//  Copyright © 2018年 dawn_lxg. All rights reserved.
//

import UIKit

class LXGRefreshArrowLoadingView: LXGRefreshReminderView {
    
    let mysize:CGFloat = LXGRrfreshConstants.LoadingViewSize //
    
    let arrowSize:CGFloat = LXGRrfreshConstants.LoadingViewSize/10+2
    
    fileprivate let animationKeyword = "kRotationAnimation"
    fileprivate let changeanimationKeyword = "circleRotationAnimation"

    
   
    
    fileprivate var parLayer = CAReplicatorLayer()
    
    fileprivate var layerArcone = CAShapeLayer()
    
    fileprivate var layerArrow = CAShapeLayer()
    fileprivate var myPath = UIBezierPath()
    fileprivate var arrowPathStart = UIBezierPath()
    fileprivate var arrowPathEnd = UIBezierPath()
    
    
    fileprivate func addmylayer() {
        
        parLayer.addSublayer(layerArcone)
        parLayer.addSublayer(layerArrow)
        self.layer.addSublayer(parLayer)
        
    }
    fileprivate func addmyPath(){
        
        layerArcone.path = myPath.cgPath

        layerArrow.path = arrowPathStart.cgPath

    }
    
    
    override func layoutSubviews() {
    
        super.layoutSubviews()
        
       
        
        
        
    }
    override func stopAnimation() {
        
        super.stopAnimation()
        parLayer.removeAnimation(forKey: animationKeyword)
        layerArrow.removeAnimation(forKey: changeanimationKeyword)

        
    }
    
    override func startAnimation() {
        
       super.startAnimation()
        
     if parLayer.animation(forKey: animationKeyword) != nil,layerArcone.animation(forKey: changeanimationKeyword) != nil {
            return
     }
        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        basicAnimation.fromValue = CGFloat.pi * 2
        basicAnimation.toValue = 0
        basicAnimation.duration = 2
        basicAnimation.repeatCount = Float.infinity
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = kCAFillModeForwards
        parLayer.add(basicAnimation, forKey: animationKeyword)
        
        let basicAniChangePath = CAKeyframeAnimation(keyPath: "path")

        basicAniChangePath.values = [arrowPathStart.cgPath,arrowPathEnd.cgPath,arrowPathEnd.cgPath]
        basicAniChangePath.keyTimes = [0.45,0.7,0.95]
        basicAniChangePath.autoreverses = true
        basicAniChangePath.duration = 1
        basicAniChangePath.repeatCount = Float.infinity
        layerArrow.add(basicAniChangePath, forKey: changeanimationKeyword)

        
        
    }
    
    
    

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        
        parLayer.instanceCount = 2
        parLayer.frame = CGRect(x: 0.0, y: 0.0, width:mysize, height: mysize)
        parLayer.instanceTransform = CATransform3DMakeRotation(CGFloat.pi, 0, 0, 1)
        
        layerArcone.fillColor = UIColor.clear.cgColor
        layerArcone.strokeColor = UIColor(red: 189/255.0, green: 189/255.0, blue: 189/255.0, alpha: 1).cgColor
        layerArcone.lineWidth = 1.0
        layerArcone.contentsScale = UIScreen.main.scale
        layerArcone.lineCap = kCALineCapRound
        
        layerArrow.fillColor = UIColor.clear.cgColor
        layerArrow.strokeColor = UIColor(red: 189/255.0, green: 189/255.0, blue: 189/255.0, alpha: 1).cgColor
        layerArrow.lineWidth = 1.0
        layerArrow.contentsScale = UIScreen.main.scale
        layerArrow.lineCap = kCALineCapRound
        
        myPath.addArc(withCenter: CGPoint(x: mysize/2, y: mysize/2), radius: mysize/2-3, startAngle:0 , endAngle: CGFloat.pi*7/8, clockwise: true)
        
        arrowPathStart.move(to: CGPoint(x: mysize-3-arrowSize/2-0.5, y: mysize/2+arrowSize/2-0.5))
        arrowPathStart.addLine(to: CGPoint(x: mysize-3, y: mysize/2))
        arrowPathStart.addLine(to: CGPoint(x: mysize-3+arrowSize/2, y: mysize/2+arrowSize/2-0.5))
        
        arrowPathEnd.move(to: CGPoint(x: mysize-3-arrowSize/2-0.5, y: mysize/2-arrowSize/2-0.5))
        arrowPathEnd.addLine(to: CGPoint(x: mysize-3, y: mysize/2))
        arrowPathEnd.addLine(to: CGPoint(x: mysize-3+arrowSize/2, y: mysize/2-arrowSize/2-0.5))
        
        

        addmylayer()
        addmyPath()


        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
   

}
