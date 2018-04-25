//
//  LXGRefreshconstants.swift
//  LXGRrefresh
//
//  Created by 黎曦光 on 2018/4/11.
//  Copyright © 2018年 dawn_lxg. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

public struct LXGRrfreshConstants {
    
    struct Keypaths {
        static let ContentOffset = "contentOffset"
        static let Frame = "frame"
        static let ContentInset = "contentInset"
        static let PanGestureRecognizerState = "panGestureRecognizer.state"
    }
    struct loadingType {
        static let Circle = "circle"
        static let Arrow = "arrow"
  
    }
    struct loadingLabelString {
        static let pullToRefresh =    " 下拉刷新 " //" pull refresh "
        static let ReleaseToRefresh = " 松开更新 " //"Release update"
        static let Loading =          " 加载中..." //"  loading.... "

    }
    
    
    public static var labelfont: UIFont = UIFont.systemFont(ofSize: 16)
    public static var loadingColor: UIColor = UIColor(red: 189/255.0, green: 189/255.0, blue: 189/255.0, alpha: 1)

    public static var ArrowChangeHeight: CGFloat = 95.0
    public static var bottomAllowLoadingHeight: CGFloat = 50.0

    public static var LoadingContentInset: CGFloat = 50.0
    public static var LoadingContentInterval: CGFloat = 10.0

    public static var LoadingViewSize: CGFloat = 25.0
    public static var bottomLoadingContentInset: CGFloat = 50.0

}

enum LXGRefreshState {
    
    case stopped
    case animationWillStop
    case draggingTouching
    case loadingContinue
    case loading
    
    func iscontainsStates(_ states:[LXGRefreshState]) -> Bool {
        
        return states.contains(where: {$0 == self} )
        
    }
}

