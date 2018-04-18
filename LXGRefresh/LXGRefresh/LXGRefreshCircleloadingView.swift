//
//  LXGRefreshCircleAndArrowView.swift
//  LXGRrefresh
//
//  Created by 黎曦光 on 2018/4/12.
//  Copyright © 2018年 dawn_lxg. All rights reserved.
//

import UIKit

public extension CGFloat {
    
    fileprivate func convertToRadians() -> CGFloat{
        
        return self * CGFloat.pi / 180
        
    }
    fileprivate func convertToDegree() -> CGFloat {
        
        return self * 180 / CGFloat.pi
    }

}
class LXGRefreshCircleloadingView: LXGRefreshReminderView {

    fileprivate let animationKeyword = "kRotationAnimation"

    fileprivate let shapeLayer = CAShapeLayer()
    fileprivate lazy var identityTransform : CATransform3D = {
        var transform = CATransform3DIdentity
        transform.m34 = CGFloat(1.0 / 500.0)
        transform = CATransform3DRotate((transform), CGFloat(-90.0).convertToRadians(), 0, 0, 1)
    
        return transform
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        shapeLayer.lineWidth = 1.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = LXGRrfreshConstants.loadingColor.cgColor
        shapeLayer.strokeEnd = 0.9
        shapeLayer.actions = ["strokeEnd" : NSNull(), "transform" : NSNull()]
        shapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        layer.addSublayer(shapeLayer)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    override func setPullDownRefreshView(_ progress: CGFloat) {
        
        super.setPullDownRefreshView(progress)

        if progress > 1.0 {
            let degrees = (progress - 1.0) * 180.0
            shapeLayer.transform = CATransform3DRotate(identityTransform, degrees.convertToRadians(), 0, 0, 1)

        }else{

            shapeLayer.transform = identityTransform
        }
        
    }
    override func startAnimation() {
        
        super.startAnimation()
    
        if shapeLayer.animation(forKey: animationKeyword) != nil {
            return
        }
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = currentDegree() + CGFloat.pi * 2
        rotationAnimation.duration = 0.8
        rotationAnimation.repeatCount = Float.infinity
        rotationAnimation.isRemovedOnCompletion = false
        rotationAnimation.fillMode = kCAFillModeForwards
        shapeLayer.add(rotationAnimation, forKey: animationKeyword)
        
    }
    
    fileprivate func currentDegree() -> CGFloat {
        return shapeLayer.value(forKeyPath: "transform.rotation.z") as! CGFloat
    }
     override func stopAnimation() {
        super.stopAnimation()
        shapeLayer.removeAnimation(forKey: animationKeyword)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.frame = bounds
        let inset = shapeLayer.lineWidth / 2.0
        shapeLayer.path = UIBezierPath(ovalIn: shapeLayer.bounds.insetBy(dx: inset, dy: inset)).cgPath
    }
    
    
    

}
