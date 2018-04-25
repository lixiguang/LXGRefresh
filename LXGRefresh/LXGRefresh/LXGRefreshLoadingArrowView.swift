//
//  LXGRefreshLoadingArrowView.swift
//  LXGRefresh
//
//  Created by 黎曦光 on 2018/4/25.
//  Copyright © 2018年 dawn_lxg. All rights reserved.
//

import UIKit
class LXGRefreshLoadingArrowView: UIView {

    fileprivate let mysize:CGFloat = LXGRrfreshConstants.LoadingViewSize
    
   
    fileprivate let animationKeywordStart = "kRotationAnimationStart"
    fileprivate let animationKeywordStop = "kRotationAnimationStop"


    
    fileprivate var arrowlayer = CAShapeLayer()
    
    fileprivate var lineLayer = CAShapeLayer()
    fileprivate var linePath = UIBezierPath()
    fileprivate var shapeLayer = CALayer()
    
    fileprivate lazy var identityTransform : CATransform3D = {
        var transform = CATransform3DIdentity
        transform.m34 = CGFloat(1.0 / 500.0)
        transform = CATransform3DRotate((transform), CGFloat.pi, 0, 0, -1)
        
        return transform
    }()
    fileprivate lazy var identityTransformBack : CATransform3D = {
        
        var transform = CATransform3DIdentity
        transform.m34 = CGFloat(1.0 / 500.0)
        transform = CATransform3DRotate((transform), 0, 0, 0, -1)
        
        
        return transform
    }()
        
    
    
    fileprivate var arrowPath =  UIBezierPath()
        
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        

        arrowlayer.lineWidth = 1.0
        arrowlayer.fillColor = UIColor.clear.cgColor
        arrowlayer.strokeColor = LXGRrfreshConstants.loadingColor.cgColor
        arrowlayer.contentsScale = UIScreen.main.scale
        arrowlayer.lineCap = kCALineCapRound
        
        lineLayer.lineWidth = 1.0
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = LXGRrfreshConstants.loadingColor.cgColor
        lineLayer.contentsScale = UIScreen.main.scale
        lineLayer.lineCap = kCALineCapRound
        

        arrowPath.move(to: CGPoint(x: mysize/2-mysize/6, y: mysize/2-mysize/5))
        arrowPath.addLine(to: CGPoint(x: mysize/2, y: mysize/2-mysize/3))
        arrowPath.addLine(to: CGPoint(x: mysize/2+mysize/6, y: mysize/2-mysize/5))
        
        linePath.move(to: CGPoint(x: mysize/2, y: mysize/2-mysize/3))
        linePath.addLine(to: CGPoint(x: mysize/2, y: mysize-mysize/10))
        
        
        shapeLayer.addSublayer(arrowlayer)
        shapeLayer.addSublayer(lineLayer)
        layer.addSublayer(shapeLayer)
      
       
        

        
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    fileprivate var rotationAnimation = CABasicAnimation()
    
    func starAnimation(){
        

       
        shapeLayer.transform = identityTransform
        
        
        
        
    }
    func stopAnimation(){
        
      
        shapeLayer.transform = identityTransformBack

        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.frame = bounds
        

        arrowlayer.path = arrowPath.cgPath
        lineLayer.path = linePath.cgPath
        
    }

}
