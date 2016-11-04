//
//  IngreLikeCell.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/25.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class IngreLikeCell: UITableViewCell {
var jumpClosure:IngreJumpClosure?
    @IBAction func btnClick(sender: UIButton) {
        let index=sender.tag-100
        if index*2<listModel?.widget_data?.count{
            let data=listModel?.widget_data![index*2]
            if data?.link != nil&&jumpClosure != nil{
                jumpClosure!((data?.link)!)
            }
        }
    }
    var listModel:IngreRecommendWidgetList?{
        didSet{
           showData()
        }
    }
    private func showData(){
        if listModel?.widget_data?.count>0{
        for var i in 0..<listModel!.widget_data!.count-1{
            
            let imageData=listModel?.widget_data![i]
            if imageData?.type=="image"{
            
            let imageTag=200+i/2
                let imageView=contentView.viewWithTag(imageTag)
                if imageView?.isKindOfClass(UIImageView)==true{
                    let tmpImageView=imageView as! UIImageView
            
                    tmpImageView.kf_setImageWithURL(NSURL(string: (imageData?.content)!), placeholderImage:  UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    
                    
                }}
                let textData=listModel?.widget_data![i+1]
                if textData?.type=="text"{
                    let label=contentView.viewWithTag(300+i/2)
                    if label?.isKindOfClass(UILabel)==true{
                        let tmplabel=label as! UILabel
                        tmplabel.text=textData?.content
                    }

                
            }
            
            
            
            i+=1
        }
        }
    }
    class func  createLikeCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,listModel:IngreRecommendWidgetList?)->IngreLikeCell{
        let cellId="ingreLikeCellId"
        var cell=tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreLikeCell
        if cell==nil{
            cell=NSBundle.mainBundle().loadNibNamed("IngreLikeCell", owner: nil, options: nil).last as? IngreLikeCell
        }
        cell?.listModel=listModel
        return cell!
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
