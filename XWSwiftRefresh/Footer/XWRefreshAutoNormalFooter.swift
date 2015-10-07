//
//  XWRefreshAutoNormalFooter.swift
//  XWSwiftRefresh
//
//  Created by key on 15/10/6.
//  Copyright © 2015年 key. All rights reserved.
//

import UIKit

class XWRefreshAutoNormalFooter: XWRefreshAutoStateFooter {
    
    //MARK: 外部访问
    /** 菊花样式 */
    var activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray {
        
        didSet{
            self.activityView.activityIndicatorViewStyle = activityIndicatorViewStyle
            self.setNeedsLayout()
        }
    }
    
    
    //MARK: 私有
    
    //菊花
    private lazy var activityView:UIActivityIndicatorView = {
        
        [unowned self] in
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: self.activityIndicatorViewStyle)
        activityView.hidesWhenStopped = true
        self.addSubview(activityView)
        
        return activityView
        }()
    
    
    //MARK: 重写
    override func placeSubvies() {
        super.placeSubvies()
        //菊花
        var activityViewCenterX = self.xw_width * 0.5
        if !self.refreshingTitleHidden { activityViewCenterX -=  XWRefreshFooterActivityViewDeviation }
        let activityViewCenterY = self.xw_height * 0.5
        self.activityView.center = CGPointMake(activityViewCenterX, activityViewCenterY)
    }
    
    override var state:XWRefreshState{
        didSet{
            if oldValue == state { return }
                
                
            if  state == XWRefreshState.NoMoreData || state == XWRefreshState.Idle {
                
                self.activityView.stopAnimating()
                
            }else if state == XWRefreshState.Refreshing  {
                
                self.activityView.startAnimating()
            }
        }
    }

    

}
