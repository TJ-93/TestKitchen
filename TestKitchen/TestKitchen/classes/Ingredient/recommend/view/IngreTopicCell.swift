//
//  IngreTopicCell.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/11/1.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class IngreTopicCell: UITableViewCell {
    @IBOutlet weak var topicImageView: UIImageView!

    @IBOutlet weak var nameLB: UILabel!
    
    @IBOutlet weak var descLB: UILabel!
    var cellArray:[IngreRecommendWidgetData]?{
        didSet{
            showData()
        }
    }
    var jumpClosure:IngreJumpClosure?
    func showData(){
        //图片
        if cellArray?.count>0{
            let imageData=cellArray![0]
            if imageData.type=="image"{
            let url=NSURL(string: imageData.content!)
                topicImageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        //标题
        if cellArray?.count>1{
            let titleData=cellArray![1]
            if titleData.type=="text"{
            nameLB.text=titleData.content
            }
        }
        //描述文字
        if cellArray?.count>2{
            let descData=cellArray![2]
            if descData.type=="text"{
            descLB.text=descData.content
            }
        }
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
       //点击事件
        let g=UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(g)
    }
    //创建cell的方法
    class func createTopicCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,cellArray:[IngreRecommendWidgetData]?)->IngreTopicCell{
        let cellId="IngreTopicCellId"
        var cell=tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreTopicCell
        if cell==nil{
            cell=NSBundle.mainBundle().loadNibNamed("IngreTopicCell", owner: nil, options: nil).last as? IngreTopicCell
            
            
        }
        cell?.cellArray=cellArray
        return cell!
    }
    
    func tapAction(){
        if cellArray!.count>0{
            let imageData=cellArray![0]
            if imageData.link != nil && jumpClosure != nil{
                jumpClosure!(imageData.link!)
            }
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
