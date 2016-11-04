//
//  IngreBannerCell.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/25.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class IngreBannerCell: UITableViewCell {
    var jumpClosure:IngreJumpClosure?
    @IBOutlet weak var scrollowView: UIScrollView!
//    private var containerView:UIView?
    @IBOutlet weak var pageCtrl: UIPageControl!
    var bannerArray:[IngreRecommendBanner]?{
        didSet{
            //显示数据
           
            showData()
        }
    }
    private func showData(){
        
        for sub in scrollowView.subviews {
            sub.removeFromSuperview()
        }
        
        
        let cnt=bannerArray?.count
   
        if bannerArray?.count>0{
            //创建容器视图
             let containerView=UIView.createView()
            scrollowView.addSubview(containerView)
            containerView.snp_makeConstraints(closure: { (make) in
                make.edges.equalToSuperview()
                make.height.equalToSuperview()
            })
            var lastView:UIView?=nil
            for i in 0..<cnt!{
                let model=bannerArray![i]
                let tmpImageView=UIImageView()
                tmpImageView.tag=200+i
                tmpImageView.kf_setImageWithURL(NSURL(string: model.banner_picture!), placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                containerView.addSubview(tmpImageView)
                
                //添加点击事件
                tmpImageView.userInteractionEnabled=true
                let g=UITapGestureRecognizer(target: self, action: #selector(tapImage(_:)))
                tmpImageView.addGestureRecognizer(g)
                
                tmpImageView.snp_makeConstraints(closure: { (make) in
                    make.top.bottom.equalToSuperview()
                    make.width.equalTo(scrollowView)
                    if lastView==nil{
                        make.left.equalToSuperview()
                    }else{
                        make.left.equalTo((lastView?.snp_right)!)
                    }
                })
                lastView=tmpImageView
                
            }
            containerView.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(lastView!)
            })
        pageCtrl.numberOfPages=cnt!
        }
    }
    func tapImage(g:UIGestureRecognizer){
        let index=(g.view?.tag)!-200
        
        //获取点击的事件
        let banner=bannerArray![index]
        if jumpClosure != nil{
            self.jumpClosure!(banner.banner_link!)}
    }
    class func createBannerCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,bannerArray:[IngreRecommendBanner]?)->IngreBannerCell{
        let cellId="ingreBannerCellId"
        var cell=tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreBannerCell
        if cell==nil{
            cell=NSBundle.mainBundle().loadNibNamed("IngreBannerCell", owner: nil, options: nil).last as? IngreBannerCell
          
        
        }
        cell?.bannerArray=bannerArray
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
//MARK:UISCrollowView的代理
extension IngreBannerCell:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index=scrollowView.contentOffset.x/scrollowView.bounds.width
        pageCtrl.currentPage=Int(index)
    }
}