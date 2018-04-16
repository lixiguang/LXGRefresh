//
//  LXGRefreshExtension.swift
//  LXGRrefresh
//
//  Created by 黎曦光 on 2018/4/11.
//  Copyright © 2018年 dawn_lxg. All rights reserved.
//

import Foundation
import UIKit
extension NSObject {
    
    fileprivate struct lxg_observerKey{
        
        static var observerAssociateKey = "observers"
        
    }
    
    fileprivate var lxg_observers: [[String : NSObject]] {
        
        get {
            
            if let observers = objc_getAssociatedObject(self, &lxg_observerKey.observerAssociateKey) as? [[String : NSObject]]{
                
                return observers
                
            }else{
                
                let observers = [[String : NSObject]]()
                
                self.lxg_observers = observers
                
                return observers
            
            }
            
            
        }
        
        set {
            
            objc_setAssociatedObject(self, &lxg_observerKey.observerAssociateKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        
        
    }
    
    public func lxg_addobserver(_ observer: NSObject, for keyPath:String) {
        
        let observerinfo = [keyPath : observer]
        
        if lxg_observers.index(where: {$0 == observerinfo}) == nil {
            
            lxg_observers.append(observerinfo)
            addObserver(observer, forKeyPath: keyPath, options: .new, context: nil)
            
        }
        
        
    }
    
    public func lxg_removeobserver(_ observer: NSObject, for keyPath:String) {
        
        let observerinfo = [keyPath : observer]
        
        if let index = lxg_observers.index(where: {$0 == observerinfo}){
            
            lxg_observers.remove(at: index)
            removeObserver(observer, forKeyPath: keyPath)
            
        }
    }
}
extension UIScrollView {
    
    fileprivate struct lxg_RefreshViewKey{
        
        static var headerRefreshView = "headerRefreshView"
        static var footerRefreshView = "footerRefreshView"
        static var loadingtype = "loadingtype"


    }
    
    public var loadingviewType:String{
        
        get {
        if let loadingtype = objc_getAssociatedObject(self, &lxg_RefreshViewKey.loadingtype) as? String{
            
            return loadingtype
            
        }else{
            
            let loadingtype = LXGRrfreshConstants.loadingType.Circle
            
            self.loadingviewType = loadingtype
            
            return loadingtype
            
        }
        }
        
        set {
            
            objc_setAssociatedObject(self, &lxg_RefreshViewKey.loadingtype, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    
    
    fileprivate var headerrefreshView: LXGRefreshLoadingView? {
        
        get {
            

          return objc_getAssociatedObject(self, &lxg_RefreshViewKey.headerRefreshView) as? LXGRefreshLoadingView
        }
        set {

            objc_setAssociatedObject(self, &lxg_RefreshViewKey.headerRefreshView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        
    }
    
    fileprivate var footerrefreshView: LXGRefreshLoadingView? {
        
        get {
            
            
            return objc_getAssociatedObject(self, &lxg_RefreshViewKey.footerRefreshView) as? LXGRefreshLoadingView
        }
        set {
            
            objc_setAssociatedObject(self, &lxg_RefreshViewKey.footerRefreshView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        
    }
    
    public func lxg_addRefreshWithActionHandle(_ headerIsOpen:Bool, headerActionHandle: @escaping () -> Void,footerIsOpen:Bool, bottomRefreshAction bottomActionHandle: @escaping () -> Void) {
        
        
        isMultipleTouchEnabled = false
        panGestureRecognizer.maximumNumberOfTouches = 1
      
        
        

        if headerIsOpen {
        

           
            let headerrefreshView = LXGRefreshLoadingView()

            headerrefreshView.hasHeader = true
            headerrefreshView.hasfooter = false
            headerrefreshView.headerActionHandle = headerActionHandle
            addSubview(headerrefreshView)
            headerrefreshView.observing = true
            self.headerrefreshView = headerrefreshView
        
        }
        if footerIsOpen {

            
            let footerrefreshView = LXGRefreshLoadingView()
            
            footerrefreshView.hasHeader = false
            footerrefreshView.hasfooter = true
            footerrefreshView.bottomActionHandle = bottomActionHandle
            addSubview(footerrefreshView)
            footerrefreshView.observing = true
            self.footerrefreshView = footerrefreshView
        }
        if loadingviewType == LXGRrfreshConstants.loadingType.Circle{
            
            headerrefreshView?.reminderView = LXGRefreshCircleloadingView()
            footerrefreshView?.reminderView = LXGRefreshCircleloadingView()

            
        }else{
            headerrefreshView?.reminderView = LXGRefreshArrowLoadingView()
            footerrefreshView?.reminderView = LXGRefreshArrowLoadingView()
            
        }
        
    }
    
    public func lxg_removeHeaderRefresh() {
        
        headerrefreshView?.observing = false
        headerrefreshView?.removeFromSuperview()
    }
    public func lxg_removeFooterRefresh() {
        
        footerrefreshView?.observing = false
        footerrefreshView?.removeFromSuperview()
    }
    public func lxg_removeRefresh(){
        
        lxg_removeFooterRefresh()
        lxg_removeHeaderRefresh()
        
       
    }
    
    public func lxg_stopLoading(){
        
        headerrefreshView?.stopLoading()
        footerrefreshView?.stopLoading()
        
    }
    
    
}


public extension UIGestureRecognizerState {
    func lxg_isContainStates(_ states: [UIGestureRecognizerState]) -> Bool {
        return states.contains(where: { $0 == self })
    }
}
