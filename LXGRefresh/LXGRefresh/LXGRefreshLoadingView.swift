//
//  LXGRefreshLoadingView.swift
//  LXGRrefresh
//
//  Created by 黎曦光 on 2018/4/11.
//  Copyright © 2018年 dawn_lxg. All rights reserved.
//

import UIKit

class LXGRefreshLoadingView: UIView {
    
    fileprivate var originalContentInsetTop:CGFloat = 0.0 {
        didSet {
            layoutSubviews()
        }
    }
    fileprivate var originalContentInsetBottom:CGFloat = 0.0 {
        didSet {
            layoutSubviews()
        }
    }
    var isBottomLoading : Bool = false {
        didSet{
            
            layoutSubviews()

        }
    }
    var hasHeader : Bool!
    var hasfooter : Bool!

    
    
    
    var reminderView: LXGRefreshReminderView? {
        willSet {
            reminderView?.removeFromSuperview()
            if let newValue = newValue {
                addSubview(newValue)
            }
        }
    }
    
    var headerActionHandle: (() -> Void)!
    var bottomActionHandle: (() -> Void)!

    
    
    fileprivate func scrollView() -> UIScrollView? {
        return superview as? UIScrollView

    }
    
    fileprivate func loadingViewAppear() {
        
        if !self.observing  {
            return
        }
        
        resetScrollViewContentInset(shouldAddObserverWhenFinished: true, completion: { [weak self] () -> () in self?.currentState = .loadingContinue
            
        })
       
    }


    
    fileprivate var initialState : LXGRefreshState = .stopped
    
    fileprivate(set) var currentState: LXGRefreshState {
        get { return initialState}
        set {
            let previousState = currentState
            initialState = newValue
            
            if previousState == .draggingTouching ,newValue == .loading {
                
                
                reminderView?.startAnimation()
                loadingViewAppear()
              
            }
            else if newValue == .animationWillStop {

                reminderView?.stopAnimation()
                
                resetScrollViewContentInset(shouldAddObserverWhenFinished: true, completion: { [weak self] () -> () in
                    self?.currentState = .stopped

                })


            }else if  newValue == .loadingContinue , headerActionHandle != nil {

                    
                headerActionHandle()
                layoutSubviews()


            }else if newValue == .loadingContinue , bottomActionHandle != nil {
                
                bottomActionHandle()
                layoutSubviews()


                
            }
            else if newValue == .stopped{
                
            }
        
        }
    }
    
    fileprivate func resetScrollViewContentInset(shouldAddObserverWhenFinished: Bool, completion: (() -> ())?) {
        
        guard let scrollView = scrollView() else { return }
        var contentInset = scrollView.contentInset
       
        
        contentInset.top = originalContentInsetTop
        contentInset.bottom = originalContentInsetBottom
        
        print(contentInset.bottom)
        if currentState == .loading  {
            
            if hasfooter {
                
                contentInset.bottom += LXGRrfreshConstants.LoadingContentInset

            }else if hasHeader{
                
                contentInset.top += LXGRrfreshConstants.LoadingContentInset

                
            }
            


        }
       
        scrollView.lxg_removeobserver(self, for: LXGRrfreshConstants.Keypaths.ContentInset)
        
        let animationBlock = {
            
            scrollView.contentInset = contentInset
            
        }
        
        let completionBlock = { () -> Void in
            if shouldAddObserverWhenFinished && self.observing {

                scrollView.lxg_addobserver(self, for: LXGRrfreshConstants.Keypaths.ContentInset)
            }
            completion?()
        }
        
        UIView.animate(withDuration: 0.4, animations: animationBlock, completion: { _ in
            
            completionBlock()
            
            })

        
       
    }
   @objc func applicationWillEnterForeground() {
        if currentState == .loading {
            layoutSubviews()
        }
    }
    
    init() {
        
        super.init(frame: CGRect.zero)
        self.clipsToBounds = true
        NotificationCenter.default.addObserver(self, selector: #selector(LXGRefreshLoadingView.applicationWillEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
    var observing: Bool = false {
        didSet {
            guard let scrollView = scrollView() else { return }
            if observing {
                
                scrollView.lxg_addobserver(self, for: LXGRrfreshConstants.Keypaths.ContentInset)
                scrollView.lxg_addobserver(self, for: LXGRrfreshConstants.Keypaths.ContentOffset)
                scrollView.lxg_addobserver(self, for: LXGRrfreshConstants.Keypaths.Frame)
                scrollView.lxg_addobserver(self, for: LXGRrfreshConstants.Keypaths.PanGestureRecognizerState)
                
               
            } else {
                
                scrollView.lxg_removeobserver(self, for: LXGRrfreshConstants.Keypaths.ContentInset)
                scrollView.lxg_removeobserver(self, for: LXGRrfreshConstants.Keypaths.ContentOffset)
                scrollView.lxg_removeobserver(self, for: LXGRrfreshConstants.Keypaths.Frame)
                scrollView.lxg_removeobserver(self, for: LXGRrfreshConstants.Keypaths.PanGestureRecognizerState)
                
            }
        }
    }
    
    
    private func isRefreshBottom(newContentOffset: CGFloat) -> Bool {
        
        var returnValue : Bool = false

        if let scrollView = scrollView() {
            
            let height = scrollView.contentSize.height - scrollView.frame.size.height
            
            if newContentOffset >= height {
                
                returnValue = true
                
            }else{
                
                returnValue = false
            }
            
        }
        
        return returnValue
    
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == LXGRrfreshConstants.Keypaths.ContentOffset {
            
            if let newContentOffset = change?[NSKeyValueChangeKey.newKey],let scrollView = scrollView() {
                
                let newContentOffsetY = (newContentOffset as AnyObject).cgPointValue.y
               
               
                
                
                  if currentState.iscontainsStates([.loadingContinue, .animationWillStop]) && newContentOffsetY < -scrollView.contentInset.top {
                    
                    
                   } else {
                    
                    scrollViewDidChangeContentOffset(dragging: scrollView.isDragging)
                   }
                
                
                layoutSubviews()
            }
            
        } else if keyPath == LXGRrfreshConstants.Keypaths.ContentInset {
            
            if let newContentInset = change?[NSKeyValueChangeKey.newKey] {
                let newContentInsetTop = (newContentInset as AnyObject).uiEdgeInsetsValue.top
                originalContentInsetTop = newContentInsetTop
                let newContentInsetBottom = (newContentInset as AnyObject).uiEdgeInsetsValue.bottom
                originalContentInsetBottom = newContentInsetBottom
            }
        } else if keyPath == LXGRrfreshConstants.Keypaths.Frame {
            
            layoutSubviews()
            
        } else if keyPath == LXGRrfreshConstants.Keypaths.PanGestureRecognizerState {
            
            if let gestureState = scrollView()?.panGestureRecognizer.state, gestureState.lxg_isContainStates([.ended, .cancelled, .failed]) {
                
                scrollViewDidChangeContentOffset(dragging: false)
            }else{
                
            }
        }
    }
    
    fileprivate func scrollViewDidChangeContentOffset(dragging: Bool) {
        
        let offsetY = actualContentOffsetY()
        
        
        if currentState == .stopped && dragging{
            
            currentState = .draggingTouching
            
        }else if currentState == .draggingTouching && dragging {
            
           //next version
            if offsetY >= LXGRrfreshConstants.ArrowChangeHeight {
                
                 //Mark arrow up
                
            } else {
                
                //Mark arrow down
            }
            
            
        }else if currentState == .draggingTouching && !dragging {
           
            if hasfooter && offsetY<=0.0 {
                
                
                if (bottomOffset()>=LXGRrfreshConstants.bottomAllowLoadingHeight){
                    
                    currentState = .loading
                    
                }else{
                    
                    currentState = .stopped

                    
                }
                
                
            }else if hasHeader{
                
            if offsetY >= LXGRrfreshConstants.ArrowChangeHeight {

                currentState = .loading
            } else {

                currentState = .stopped
            }
            }
            
        }
        

    }
    
    fileprivate func actualContentOffsetY() -> CGFloat {
        guard let scrollView = scrollView() else { return 0.0 }
        return max(-scrollView.contentInset.top - scrollView.contentOffset.y, 0)
    }
    
    fileprivate func layoutLoadingView() {
        
        let width = bounds.width

        let height: CGFloat = bounds.height
        
        let loadingViewSize: CGFloat = LXGRrfreshConstants.LoadingViewSize
        let minOriginY = (LXGRrfreshConstants.LoadingContentInset - loadingViewSize) / 2.0
        
        let originY: CGFloat = max(min((height - loadingViewSize) / 2.0, minOriginY), 0.0)
        
        reminderView?.frame = CGRect(x: (width - loadingViewSize) / 2.0, y: originY, width: loadingViewSize, height: loadingViewSize)


       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let scrollView = scrollView(){
            
            let width = scrollView.bounds.width

            backgroundColor = UIColor(red: 223/250.0, green: 223/250.0, blue: 223/250.0, alpha: 1)
            
            if hasfooter{
                

            frame = CGRect(x: 0.0, y: bottomPostion(), width: width, height: bottomOffset())
                

            }else if hasHeader{
                
            let height = currentHeight()
                
            frame = CGRect(x: 0.0, y: -currentHeight(), width: width, height: height)
            }

        }
        
        
        layoutLoadingView()
        
    }
    fileprivate func isContentSizeSmallerThanFrame() -> Bool {
        
        guard let scrollView = scrollView() else { return false }

        if scrollView.contentSize.height < scrollView.frame.size.height
        {
            return true
        }
        return false
    }
    
    fileprivate func currentHeight() -> CGFloat {
        guard let scrollView = scrollView() else { return 0.0 }
        return max(-originalContentInsetTop - scrollView.contentOffset.y, 0)
    }
    fileprivate func bottomPostion() -> CGFloat {
        guard let scrollView = scrollView() else { return 0.0 }
        return max(scrollView.contentSize.height, 0)
    }
    fileprivate func bottomOffset() -> CGFloat {
        guard let scrollView = scrollView() else { return 0.0 }

        return max(scrollView.contentOffset.y - scrollView.contentSize.height + scrollView.frame.size.height, 0)
    }
    
    
    func stopLoading() {
        
        if currentState == .animationWillStop {
            
            return
        }
        currentState = .animationWillStop
    }
   
    
    

    deinit {
        
        observing = false
        NotificationCenter.default.removeObserver(self)
        
    }

}
