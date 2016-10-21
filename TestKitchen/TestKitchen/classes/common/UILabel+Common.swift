//
//  UILabel+Common.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/21.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import Foundation
import UIKit
extension UILabel{
    class func createLabel(text:String?,textAlignment:NSTextAlignment?,font:UIFont?)->UILabel{
        let label=UILabel()
        if let tmptext=text{
            label.text=tmptext
        }
        if let tmpAlignment=textAlignment{
            label.textAlignment=tmpAlignment
        }
        if let tmpfont=font{
            label.font=tmpfont
        }
        return label
    }
}

