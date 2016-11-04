//
//  IngreMaterialView.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/11/1.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class IngreMaterialView: UIView {
    //点击事件
    var jumpClosure:IngreJumpClosure?
    private var tbView:UITableView?
    var model:IngreMaterial?{
        didSet{
            if model != nil{
                tbView?.reloadData()
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
     tbView=UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate=self
        tbView?.dataSource=self
        addSubview(tbView!)
        tbView?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(self)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
extension IngreMaterialView:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row=0
        if model?.data?.data?.count>0{
            row=(model?.data?.data?.count)!
        }
        return row
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let tmpModel=model?.data?.data![indexPath.row]
        return IngreMaterialCell.heightCellForCellWithModel(tmpModel!)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId="IngreMaterialCell"
        var cell=tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreMaterialCell
        if cell==nil{
            cell=IngreMaterialCell(style: .Default, reuseIdentifier: cellId)
        }
        cell?.cellModel=model?.data?.data![indexPath.row]
        cell?.jumpClosure=jumpClosure
        cell?.selectionStyle = .None
        return cell!
    }
}