//
//  IngreSceneCell.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/28.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class IngreSceneCell: UITableViewCell {
    //点击事件
    var jumpClosure:IngreJumpClosure?
//显示数据
    var listModel:IngreRecommendWidgetList?{
        didSet{
            showData()
        }
    }
    func showData(){
       //左边的图片
        if listModel?.widget_data?.count>0{
            let sceneData=listModel?.widget_data![0]
        
        sceneBtn.kf_setBackgroundImageWithURL(NSURL(string: (sceneData?.content)!), forState: .Normal)
            }
        //标题
        if listModel?.widget_data?.count>1{
            let titleData=listModel?.widget_data![1]
            sceneLB.text=titleData?.content
        }
        if listModel?.widget_data?.count>2{
            let titleData=listModel?.widget_data![2]
            sceneNumLB.text=titleData?.content
        }
        //右边
        for i in 0..<4{
            //图片
            if listModel?.widget_data?.count>2*i+3{
                let btnData=listModel?.widget_data![i*2+3]
                if btnData?.type=="image"{
                let tmpView=contentView.viewWithTag(100+i)
                    if ((tmpView?.isKindOfClass(UIImageView)) != nil){
                        let url=NSURL(string: (btnData?.content)!)
                        let btn=tmpView as! UIButton
                        btn.kf_setBackgroundImageWithURL(url, forState: .Normal)
                    }
                }
            }
            //视频
        }
        //下边
        descLB.text=listModel?.desc
    }
    @IBOutlet weak var sceneBtn: UIButton!
    
    @IBAction func clickSceneBtn() {
        if listModel?.widget_data?.count>0{
            let sceneData=listModel?.widget_data![0]
            if sceneData?.link != nil{
                jumpClosure!((sceneData?.link!)!)
            }
        }
    }
    
    
    @IBAction func clickImgBtn(sender: UIButton) {
        let index=sender.tag-100
        //数据对象的序号
        if listModel?.widget_data?.count>index*2+3{
            let data=listModel?.widget_data![index*2+3]
            if data?.link != nil&&jumpClosure != nil{
                jumpClosure!((data?.link)!)
            }
        }
    }
    //播放视频
    @IBAction func ckickPlayBtn(sender: UIButton) {
        let index=sender.tag-200
        if listModel?.widget_data?.count>index*2+4{
            let videoData=listModel?.widget_data![index*2+4]
            if videoData?.content != nil && jumpClosure != nil{
                jumpClosure!((videoData?.content)!)
            }
        }
    }
    
    @IBOutlet weak var sceneLB: UILabel!
    
    @IBOutlet weak var sceneNumLB: UILabel!
    
    @IBOutlet weak var descLB: UILabel!
    
    class func createSceneCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,listModel:IngreRecommendWidgetList)->IngreSceneCell{
        let cellId="ingreSceneCellId"
        var cell=tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreSceneCell
        if cell == nil{
            cell=(NSBundle.mainBundle().loadNibNamed("IngreSceneCell", owner: nil, options: nil).last as? IngreSceneCell)!
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
