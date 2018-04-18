//
//  LXGRefreshLoadingLabel.swift
//  LXGRefresh
//
//  Created by 黎曦光 on 2018/4/18.
//  Copyright © 2018年 dawn_lxg. All rights reserved.
//

import UIKit

class LXGRefreshLoadingLabel: UILabel {
    
    var labelString = LXGRrfreshConstants.loadingLabelString.pullToRefresh {
        didSet {
            
            self.text = labelString
        }
    }
    
    func setMylabelstring() {
    
    
    
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: .zero)
        
        self.textColor = LXGRrfreshConstants.loadingColor
        self.text = labelString
        self.font = LXGRrfreshConstants.labelfont
        self.textAlignment = NSTextAlignment.center
        
        
    }
    
    
    func getLabelWidth(str: String, font: UIFont, height: CGFloat)-> CGFloat {
        
        let statusLabelText: NSString = str as NSString
        
        let size = CGSize(width: CGFloat(MAXFLOAT), height: height)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil).size
        
        return strSize.width
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError()
        
    }
    override func layoutSubviews() {
    
        super.layoutSubviews()
        

        
        
        
    }

   

}
