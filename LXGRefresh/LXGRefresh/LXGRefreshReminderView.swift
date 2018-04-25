//
//  LXGRefreshReminderView.swift
//  LXGRrefresh
//
//  Created by 黎曦光 on 2018/4/12.
//  Copyright © 2018年 dawn_lxg. All rights reserved.
//

import UIKit



class LXGRefreshReminderView: UIView {
    
    
   
    
    public override init(frame: CGRect) {
        
        super.init(frame: .zero)
        self.alpha = 0
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    open func setPullDownRefreshView(_ progress: CGFloat){
        
        
      
        
    }
    
    open func refreshViewOverHalf() {
        
        
    }
    open func startAnimation(ArrowView: LXGRefreshLoadingArrowView) {
        
        self.alpha = 1
        ArrowView.alpha = 0
        
        
        
    }
    open func stopAnimation(ArrowView: LXGRefreshLoadingArrowView) {
        
        self.alpha = 0
        ArrowView.alpha = 1


        
        
    }

    

    
  

}
