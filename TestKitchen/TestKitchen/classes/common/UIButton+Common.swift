//
//  UIButton+Common.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/21.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import Foundation
import UIKit
extension UIButton{
    class func createBtn(title:String?,bgImageName:String?,highlightImageName:String?,selectImageName:String?,target:AnyObject?,action:Selector?)->UIButton{
        let btn=UIButton(type: .Custom)
        if let tmpTitle=title{
            btn.setTitle(tmpTitle, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
            if let tmpImageName=bgImageName{
                btn.setBackgroundImage(UIImage(named: tmpImageName), forState: .Normal)
            }
            if let tmphighlightImageName=highlightImageName{
                btn.setBackgroundImage(UIImage(named: tmphighlightImageName), forState: .Highlighted)
            }
            if let tmpselectImageName=selectImageName{
                btn.setBackgroundImage(UIImage(named: tmpselectImageName), forState: .Selected)
            }
            if target != nil && action != nil{
                btn.addTarget(target, action: action!, forControlEvents: .TouchUpInside)
            }
            
          return btn
            
        
        
    }
}

