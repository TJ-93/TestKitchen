//
//  KTCSegCtrl.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/11/1.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
protocol KTCSegCtrlDelegate:NSObjectProtocol {
    func segCtrl(segCtrl:KTCSegCtrl,didClickVtbAtIndex index:Int)
}
class KTCSegCtrl: UIView {
    weak var delegate:KTCSegCtrlDelegate?
    //下划线
    private var lineView:UIImageView?
    var selectIndex:Int=0{
        didSet{
            //取消之前的选中状态
            let lastBtn=viewWithTag(300+oldValue)
            if lastBtn?.isKindOfClass(KTCSegBtn)==true{
                let tmpBtn=lastBtn as! KTCSegBtn
                tmpBtn.clicked=false
                tmpBtn.userInteractionEnabled=true
            }
            //选中当前点击的按钮
            let curBtn=viewWithTag(300+selectIndex)
            if curBtn?.isKindOfClass(KTCSegBtn)==true{
                let tmpBtn=curBtn as! KTCSegBtn
                tmpBtn.clicked=true
                tmpBtn.userInteractionEnabled=false
            }
            lineView?.frame.origin.x=(lineView?.frame.width)!*CGFloat(selectIndex)
        }
    }
     init(frame: CGRect,titleArray:[String]) {
        super.init(frame:frame)
        //创建按钮
        if titleArray.count>0{
        createBtns(titleArray)
        }
       
    }
    
    func createBtns(titleArray:[String]){
       let w=bounds.width/CGFloat(titleArray.count)
        for i in 0..<titleArray.count{
            let frame=CGRectMake(w*CGFloat(i), 0, w, bounds.height)
            let btn=KTCSegBtn(frame: frame)
            btn.config(titleArray[i])
            btn.tag=300+i
            
            if i==0{
                btn.clicked=true
            }else{
                btn.clicked=false
            }
            btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
            
            addSubview(btn)
            
        }
        lineView=UIImageView(frame: CGRectMake(0, 42, w, 2))
        lineView?.backgroundColor=UIColor.redColor()
        addSubview(lineView!)
    }
    func clickBtn(btn:KTCSegBtn){
    let index=btn.tag-300
        selectIndex=index
        delegate?.segCtrl(self, didClickVtbAtIndex: index)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
//自定制按钮
class KTCSegBtn:UIControl{
    private var titleLabel:UILabel?
    
    //设置选中状态
    var clicked:Bool=false{
        didSet{
            if clicked==true{
                //选中
                titleLabel?.textColor=UIColor.blackColor()
            }else{
                //取消选中
                titleLabel?.textColor=UIColor.grayColor()
            }
        }
    }
    func config(title:String?){
        titleLabel?.text=title
    }
    override init(frame:CGRect){
        super.init(frame:frame)
        
        titleLabel=UILabel.createLabel(nil, textAlignment: .Center, font: UIFont.systemFontOfSize(20))
        titleLabel?.frame=bounds
        addSubview(titleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
