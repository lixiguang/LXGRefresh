# LXGRefresh
Elastic pull to refresh compontent developed in Swift

# Requirements
 * Xcode 7 or higher
 * iOS 8.0 or higher (may work on previous versions, just did not test it)
 * ARC
 * Swift 3.0
# Requirements
 Open and run the LXGRefreshExample project in Xcode to see LXGRefresh in action.
# Installation
# cocoapod
     platform :ios, '9.0' <br>
      target 'test' do <br>
      pod 'LXGRefresh' 

     end
  ## than
      pod install

# Example usage


      tableView.lxg_addRefreshWithActionHandle(true, headerActionHandle: {
             //headeraction
             //do your network request
             //when the data returns please do
              self.tableView.lxg_stopLoading()
            
        }, footerIsOpen: true) {
            //footeraction
            
            }
            
there are two type of loadingview you can choose,you can use this method to change loadingtype
 
     tableView.loadingviewType = LXGRrfreshConstants.loadingType.Circle
