//
//  IngreRedPacketCellTableViewCell.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/26.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
public typealias IngreJumpClosure=(String->Void)
class IngreRedPacketCell: UITableViewCell {
    var jumpClosure:IngreJumpClosure?
    private var containerView:UIView?
    @IBOutlet weak var scrollView: UIScrollView!
    var listModel:IngreRecommendWidgetList?{
        didSet{
            showData()
        }
    }
    
    func showData(){
        if containerView != nil {
            containerView?.removeFromSuperview()
        }

        if listModel?.widget_data?.count>0{
            containerView=UIView.createView()
            
            scrollView.addSubview(containerView!)
            scrollView.showsHorizontalScrollIndicator=false
            scrollView.delegate=self
            containerView!.snp_makeConstraints(closure: { (make) in
                make.edges.height.equalToSuperview()
                
            })
            
            var lastView:UIView?=nil
            let cnt=listModel?.widget_data?.count
            for i in 0..<cnt!{
                let data=listModel?.widget_data![i]
                if data?.type=="image"{
                    let url=NSURL(string: (data?.content)!)
                    let tmpImageView=UIImageView()
                    tmpImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    tmpImageView.userInteractionEnabled=true
                    tmpImageView.tag=300+i
                    let g=UITapGestureRecognizer(target: self, action: #selector(tapImage(_:)))
                    tmpImageView.addGestureRecognizer(g)
                    containerView!.addSubview(tmpImageView)
                    tmpImageView.snp_makeConstraints(closure: { (make) in
                        make.top.bottom.equalToSuperview()
                        make.width.equalTo(210)
                        if i==0{
                             let x=(CGFloat(210*cnt!)-scrollView.bounds.width)/2
                            make.left.equalToSuperview().offset(-x)
                        }else{
                            make.left.equalTo((lastView?.snp_right)!)
                        }
                    })
                    lastView=tmpImageView
                }
             
                
            }
            containerView!.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(lastView!)
            })
            
           
            //将滚动视图居中
//            scrollView.contentOffset=CGPointMake(x, 0)
            
        }
    }
    //点击跳转事件
    func tapImage(g:UIGestureRecognizer){
        let index=(g.view?.tag)!-300
        let data=listModel?.widget_data![index]
        if jumpClosure != nil && data?.link != nil{
            jumpClosure!((data?.link)!)
        }
    }
    class func createRedPacketCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,listModel:IngreRecommendWidgetList)->IngreRedPacketCell{
        let cellId="IngreRedPacketCellId"
        var cell=tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreRedPacketCell
        if cell==nil{
            cell=NSBundle.mainBundle().loadNibNamed("IngreRedPacketCell", owner: nil, options: nil).last as? IngreRedPacketCell
        }
        cell?.listModel=listModel
        return cell!
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

//MARK:Scrollowview的代理
extension IngreRedPacketCell:UIScrollViewDelegate{
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
//        let container=scrollView.viewWithTag(200)
        let firstImageView=containerView!.viewWithTag(300)
        if firstImageView?.isKindOfClass(UIImageView)==true{
            firstImageView?.snp_updateConstraints(closure: { (make) in
                make.left.equalTo(containerView!)
            })
        }
    }
}



