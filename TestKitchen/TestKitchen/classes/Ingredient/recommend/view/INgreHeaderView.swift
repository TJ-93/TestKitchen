//
//  INgreHeaderView.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/27.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class INgreHeaderView: UIView {
    //点击事件
    var jumpClosure:IngreJumpClosure?
    var listModel:IngreRecommendWidgetList?{
        didSet{
        configText((listModel?.title)!)
        }
    }
    //文字
    private var titleLabel:UILabel?
    //图片
    private var imageView:UIImageView?
    //左右间距
    private var space:CGFloat=40
    //文字和图片的间距
    private var margin:CGFloat=20
    //图片的宽度
    private var iconW:CGFloat=32
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor=UIColor(white: 0.8, alpha: 1.0)
        let bgView=UIView.createView()
        bgView.backgroundColor=UIColor.whiteColor()
        bgView.frame=CGRectMake(0, 10, bounds.size.width, 44)
        addSubview(bgView)
        titleLabel=UILabel.createLabel(nil, textAlignment: .Left, font: UIFont.systemFontOfSize(18))
        bgView.addSubview(titleLabel!)
        
        imageView=UIImageView(image: UIImage(named: "more_icon"))
        bgView.addSubview(imageView!)
        
        //点击事件
        let g=UITapGestureRecognizer(target: self, action: #selector(tapAction))
        bgView.addGestureRecognizer(g)
    }
    @objc private func tapAction(){
        if jumpClosure != nil && listModel?.title_link != nil{
            jumpClosure!((listModel?.title_link)!)
        }
    }
    private func configText(text:String){
        let str=NSString(string: text)
        /*
         参1：文字的最大范围
         参2：文字的显示规范
         参3：文字的属性
         参4：上下文
         */
        let maxW=bounds.size.width-space*2-iconW-margin
        let attr=[NSFontAttributeName:UIFont.systemFontOfSize(18)]
        let w=str.boundingRectWithSize(CGSize(width: maxW, height: 44), options: .UsesLineFragmentOrigin, attributes: attr, context: nil).size.width
        let labelSpaceX=(maxW-w)/2
        titleLabel?.text=text
        //修改label位置
        titleLabel!.frame=CGRectMake(space+labelSpaceX, 0, w, 44)
        
        imageView?.frame=CGRectMake(titleLabel!.frame.origin.x+w+margin, 0, iconW, iconW)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
