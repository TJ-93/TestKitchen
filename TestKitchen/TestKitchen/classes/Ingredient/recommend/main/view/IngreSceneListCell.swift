//
//  IngreSceneListCell.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/28.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class IngreSceneListCell: UITableViewCell {
    
    var jumpClosure:IngreJumpClosure?
    var listModel:IngreRecommendWidgetList?{
        didSet{
            config((listModel?.title)!)
        }
    }
    @IBOutlet weak var titleLB: UILabel!
    private func config(text:String){
        titleLB.text=text
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //点击手势
        let g=UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(g)
    }
    func tapAction(){
        if jumpClosure != nil && listModel?.title_link != nil{
            jumpClosure!((listModel?.title_link)!)
        }
    }
    class func createSceneListCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,listmodel:IngreRecommendWidgetList?)->IngreSceneListCell{
        let cellId="IngreSceneListCellId"
        var cell=tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreSceneListCell
        if cell==nil{
            cell=NSBundle.mainBundle().loadNibNamed("IngreSceneListCell", owner: nil, options: nil).last as? IngreSceneListCell
            
        }
       cell?.listModel=listmodel
        return cell!
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
