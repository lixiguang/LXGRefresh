//
//  LXGRefreshconstants.swift
//  LXGRrefresh
//
//  Created by 黎曦光 on 2018/4/11.
//  Copyright © 2018年 dawn_lxg. All rights reserved.
//

import Foundation
import CoreGraphics

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
    public static var ArrowChangeHeight: CGFloat = 95.0
    public static var bottomAllowLoadingHeight: CGFloat = 50.0

    public static var LoadingContentInset: CGFloat = 50.0
    public static var LoadingViewSize: CGFloat = 30.0
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

