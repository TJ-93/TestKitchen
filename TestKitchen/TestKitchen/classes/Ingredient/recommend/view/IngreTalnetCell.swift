//
//  IngreTalnetCell.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/31.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class IngreTalnetCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var nameLB: UILabel!
    
    @IBOutlet weak var descLB: UILabel!
    
    @IBOutlet weak var fansLB: UILabel!
    
    var cellArray:[IngreRecommendWidgetData]?{
        didSet{
            showData()
        }
    }
    var jumpClosure:IngreJumpClosure?
    override func awakeFromNib() {
        super.awakeFromNib()
        leftImageView.layer.cornerRadius=30
        leftImageView.layer.masksToBounds=true
    }
    func showData(){
//        图片
        if cellArray?.count>0{
            let imageData=cellArray![0]
            if imageData.type=="image"{
                let url=NSURL(string: imageData.content!)
                leftImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        }
        }
//    标题
        if cellArray?.count>1{
            let titleData=cellArray![1]
            if titleData.type=="text"{
            nameLB.text=titleData.content
            }
        }
//        描述文字
        if cellArray?.count>2{
            let descData=cellArray![2]
            if descData.type=="text"{
            descLB.text=descData.content
            }
        }
        
//        粉丝数
        if cellArray?.count>3{
            let fansData=cellArray![3]
            if fansData.type=="text"{
                fansLB.text=fansData.content
            }
        }
        let g=UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(g)
    
    }
    func tapAction(){
        if cellArray?.count>0{
            let imageData=cellArray![0]
            if imageData.link != nil && jumpClosure != nil {
                jumpClosure!(imageData.link!)
            }
        }
    }
    class func createTalentCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,cellArray:[IngreRecommendWidgetData])->IngreTalnetCell{
        let cellId="IngreTalentCellId"
        var cell=tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreTalnetCell
        if cell==nil{
            cell=NSBundle.mainBundle().loadNibNamed("IngreTalnetCell", owner: nil, options: nil).last as? IngreTalnetCell
            
        }
        cell?.cellArray=cellArray
        return cell!
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
