//
//  IngreMaterialCell.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/11/2.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class IngreMaterialCell: UITableViewCell {
    var jumpClosure:IngreJumpClosure?
    var cellModel:IngreMaterialType?{
        didSet{
            
            if cellModel != nil{
                for sub in contentView.subviews{
                    sub.removeFromSuperview()
                }
                showData()
            }
        }
    }
    //标题的高度
    class private var titleH:CGFloat{
        return 20
    }
    //间距
    class private var margin:CGFloat{
        return 10
    }
    //按钮的高度
    class private var btnH:CGFloat{
        return 44
    }
    //按钮的宽度
    class private var btnW:CGFloat{return (screenW-margin*CGFloat(column+1))/CGFloat(column)
    }
    //按钮的列数
    class private var column:Int{
        return 5
    }
    func showData(){
        //1.类型标题
        let titleLabel=UILabel.createLabel(cellModel!.text, textAlignment: .Left, font: UIFont.systemFontOfSize(17))
        contentView.addSubview(titleLabel)
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.top.equalTo(IngreMaterialCell.margin)
            make.right.equalTo(-IngreMaterialCell.margin)
            make.height.equalTo(IngreMaterialCell.titleH)
        }
        //2.左边的图片
        let typeImageView=UIImageView()
        let url=NSURL(string: (cellModel?.image!)!)
        typeImageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        contentView.addSubview(typeImageView)
        
        typeImageView.snp_makeConstraints { (make) in
            make.left.equalTo(IngreMaterialCell.margin)
            make.top.equalTo(IngreMaterialCell.margin*2+IngreMaterialCell.titleH)
            make.width.equalTo(IngreMaterialCell.btnW*2+IngreMaterialCell.margin)
            make.height.equalTo(IngreMaterialCell.btnH*2+IngreMaterialCell.margin)
        }
        //3.子类型按钮
        let cnt=cellModel?.data?.count
        if cnt>0{
            for i in 0..<cnt!{
               //3.1显示文字
                let model=cellModel?.data![i]
                let btn=IngreMaterialBtn()
                
                btn.model=model
                btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
                contentView.addSubview(btn)
                
                //3.2设置约束
                if i<6{
                    //3.2.1前面两行的按钮
                    let row=i/(IngreMaterialCell.column-2)
                    let col=i%(IngreMaterialCell.column-2)
                    
                   btn.snp_makeConstraints(closure: { (make) in
                    let x=IngreMaterialCell.btnW*2+IngreMaterialCell.margin*3+(IngreMaterialCell.btnW+IngreMaterialCell.margin)*CGFloat(col)
                    make.left.equalTo(x)
                    let top=IngreMaterialCell.titleH+IngreMaterialCell.margin*2+(IngreMaterialCell.btnH+IngreMaterialCell.margin)*CGFloat(row)
                    make.top.equalTo(top)
                    make.width.equalTo(IngreMaterialCell.btnW)
                    make.height.equalTo(IngreMaterialCell.btnH)
                   })
                }else{
                //3.2.2后面的按钮
                    let row=(i-6)/IngreMaterialCell.column
                    let col=(i-6)%IngreMaterialCell.column
                    btn.snp_makeConstraints(closure: { (make) in
                        let x=IngreMaterialCell.margin+(IngreMaterialCell.btnW+IngreMaterialCell.margin)*CGFloat(col)
                        make.left.equalTo(x)
//                        let top=titleH+margin*2+(btnH+margin)*CGFloat(row)
                        let top=IngreMaterialCell.margin+(IngreMaterialCell.btnH+IngreMaterialCell.margin)*CGFloat(row)
                        make.top.equalTo(typeImageView.snp_bottom).offset(top)
                        make.width.equalTo(IngreMaterialCell.btnW)
                        make.height.equalTo(IngreMaterialCell.btnH)
                    })
 
                }
            }
        }
        
    }
    func clickBtn(btn:IngreMaterialBtn){
        let tmpModel=btn.model
        if tmpModel?.id != nil && jumpClosure != nil{
            let urlString="app://material#\(tmpModel?.id!)#"
            jumpClosure!(urlString)
        }
    }
    //计算cell的方法
    class func heightCellForCellWithModel(typeModel:IngreMaterialType)->CGFloat{
        //子类型只有2行内的盖度
        var h=IngreMaterialCell.margin*2+IngreMaterialCell.titleH+(IngreMaterialCell.btnH+IngreMaterialCell.margin)*2
        //超过两行
        if typeModel.data?.count>6{
           //超过的行数
            var row=((typeModel.data?.count)!-6)/(IngreMaterialCell.column)
            if ((typeModel.data?.count)!-6)%(IngreMaterialCell.column)>0{
                //除不尽的多一行
                row+=1
            }
             let h1=(IngreMaterialCell.margin+IngreMaterialCell.btnH)*CGFloat(row)+IngreMaterialCell.margin*2
            let h2=IngreMaterialCell.titleH+(IngreMaterialCell.btnH+IngreMaterialCell.margin)*2
            h=h1+h2
        }
        
        return h
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
//按钮
class IngreMaterialBtn:UIControl{
    private var titleLabel:UILabel?
    var model:IngreMaterialSubtype?{
        didSet{
            titleLabel?.text=model?.text
        }
    }
    init(){
        super.init(frame: CGRectZero)
        titleLabel=UILabel.createLabel(nil, textAlignment: .Center, font: UIFont.systemFontOfSize(17))
        addSubview(titleLabel!)
        titleLabel?.numberOfLines=0
        
        titleLabel?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(self)
        })
        backgroundColor=UIColor(white: 0.9, alpha: 1.0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}