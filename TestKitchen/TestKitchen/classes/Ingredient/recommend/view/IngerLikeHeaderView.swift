//
//  IngerLikeHeaderView.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/26.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class IngerLikeHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.grayColor()
        
        let textField=UITextField(frame: CGRect(x: 40, y: 4, width: bounds.width-80, height: 36))
    textField.placeholder="请输入菜名或食材搜索"
        textField.borderStyle = .RoundedRect
        addSubview(textField)
        let imagView=UIImageView(image: UIImage(named: "search"))
        textField.leftView=imagView
        textField.leftViewMode = .Always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
