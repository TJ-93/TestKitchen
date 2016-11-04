//
//  IngreRecommendView.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/25.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

public enum IngreWidgetType:Int{
    case GuessYouLike=1 //猜你喜欢
    case RedPacket=2  //红包入口
    case TodayNew=5 //今日新品
    case Scene=3 //早餐日记等
    case SceneList=9//全部场景
    case Talent=4 //推荐达人
    case Post=8 //精选作品
    case Topic=7 //专题
}
class IngreRecommendView: UIView {
    var jumpClosure:IngreJumpClosure?
    var model:IngreRecommend?{
        didSet{
           
            tbView?.reloadData()
        }
    }
    private var tbView:UITableView?
    override init(frame:CGRect){
        super.init(frame:frame)
        tbView=UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate=self
        tbView?.dataSource=self
    
        addSubview(tbView!)
        tbView?.snp_makeConstraints(closure: { (make) in
            
            make.edges.equalToSuperview()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
//MARK:UITableview代理
extension IngreRecommendView:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //banner广告部分显示一个分组
//        return 1
        var section=1
        if model?.data?.widgetList?.count>0{
            section += (model?.data?.widgetList?.count)!
        }
        return section
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row=0
        if section==0{
            row=1
        }else{
            let listModel=model?.data?.widgetList![section-1]
            
            if listModel?.widget_type?.integerValue==IngreWidgetType.GuessYouLike.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.RedPacket.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.TodayNew.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.Scene.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.SceneList.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.Post.rawValue{
                //猜你喜欢
                //红包入口
                //今日新品
                //早餐日记等
                //全部场景
                //精选作品
                row=1
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.Talent.rawValue{
                //推荐达人
                row = (listModel?.widget_data?.count)!/4
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.Topic.rawValue{
                row=(listModel?.widget_data?.count)!/3
            }
        }
       return row
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //banner过高的高度为140
        var height:CGFloat=0
        
        if indexPath.section==0{
            height=140
        }else{
            let listModel=model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue==IngreWidgetType.GuessYouLike.rawValue{
                height=70
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.RedPacket.rawValue{
                height=75
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.TodayNew.rawValue{
                height=280
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.Scene.rawValue{
                height=200
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.SceneList.rawValue{
                //全部场景
                height=70
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.Talent.rawValue{
                //推荐达人
                height=80
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.Post.rawValue{
                //精选作品
                height=180
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.Topic.rawValue{
                //专题
                height=120
            }

        }
        return height
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section==0{
            let cell=IngreBannerCell.createBannerCellFor(tableView, atIndexPath: indexPath, bannerArray: model?.data!.bannerArray)
             
            cell.jumpClosure=jumpClosure
            cell.selectionStyle = .None
            return cell
        }else{
           
            let listModel=model?.data?.widgetList![indexPath.section-1]
            
            if listModel?.widget_type?.integerValue==IngreWidgetType.GuessYouLike.rawValue{
                let cell = IngreLikeCell.createLikeCellFor(tableView, atIndexPath: indexPath, listModel: listModel)
                cell.jumpClosure=jumpClosure
                cell.selectionStyle = .None

                return cell
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.RedPacket.rawValue{
                let cell = IngreRedPacketCell.createRedPacketCellFor(tableView, atIndexPath: indexPath, listModel: listModel!)
                cell.jumpClosure=jumpClosure
                cell.selectionStyle = .None

                return cell

            }else if  listModel?.widget_type?.integerValue==IngreWidgetType.TodayNew.rawValue{
                let cell = IngreTodayCell.createTodayCellFor(tableView, atIndexPath: indexPath, listModel: listModel!)
                cell.jumpClosure=jumpClosure
                cell.selectionStyle = .None

                return cell
            }else if  listModel?.widget_type?.integerValue==IngreWidgetType.Scene.rawValue{
                //早餐日记
                let cell = IngreSceneCell.createSceneCellFor(tableView, atIndexPath: indexPath, listModel: listModel!)
                cell.jumpClosure=jumpClosure
                cell.selectionStyle = .None

                return cell
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.SceneList.rawValue {
                //早餐日记等
                let cell = IngreSceneListCell.createSceneListCellFor(tableView, atIndexPath: indexPath, listmodel: listModel)
                //点击事件
                cell.jumpClosure = jumpClosure
                cell.selectionStyle = .None

                cell.listModel = listModel;
                
                return cell
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.Talent.rawValue{
                //推荐达人
                let range=NSMakeRange(indexPath.row*4, 4)
               let array=NSArray(array: (listModel?.widget_data)!).subarrayWithRange(range) as! [IngreRecommendWidgetData]
                
                let cell = IngreTalnetCell.createTalentCellFor(tableView, atIndexPath: indexPath, cellArray: array)
                //点击事件
                cell.jumpClosure = jumpClosure
                
                cell.selectionStyle = .None

                
                return cell

            }else if listModel?.widget_type?.integerValue == IngreWidgetType.Post.rawValue{
             //精选作品
                let cell=IngrePostCell.createPostCellFor(tableView, atIndexPath: indexPath, listModel: listModel!)
                cell.jumpClosure=jumpClosure
                cell.selectionStyle = .None

                return cell
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.Topic.rawValue{
                let range=NSMakeRange(indexPath.row*3, 3)
                let cellArray=NSArray(array: (listModel?.widget_data)!).subarrayWithRange(range) as! [IngreRecommendWidgetData]
                
                
                //专题
                let cell=IngreTopicCell.createTopicCellFor(tableView, atIndexPath: indexPath, cellArray: cellArray)
                cell.jumpClosure=jumpClosure
                cell.selectionStyle = .None

                return cell
            }


           return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            if section>0{
                let listModel=model?.data?.widgetList![section-1]
                if listModel!.widget_type!.integerValue==IngreWidgetType.GuessYouLike.rawValue{
                   let search=IngerLikeHeaderView(frame: CGRect(x: 0, y: 0, width: tbView!.bounds.size.width, height: 44))
                    return search
                }else if listModel?.widget_type?.integerValue==IngreWidgetType.TodayNew.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.Scene.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.Talent.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.Post.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.Topic.rawValue{
                    //今日新品-
                    //早餐日记等-scene
                    //推荐达人-talent
                    //精选作品 -post
                    //专题-topic
                    let headerView=INgreHeaderView(frame: CGRect(x: 0, y: 0, width: screenW, height: 54))
                    headerView.listModel=listModel
                    headerView.jumpClosure=jumpClosure
                    return headerView
                }
        }
        return nil
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        var height:CGFloat=0
        if section>0{
            let listModel=model!.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue==IngreWidgetType.GuessYouLike.rawValue{
                //猜你喜欢
                return 44
            }else if listModel?.widget_type?.integerValue==IngreWidgetType.TodayNew.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.Scene.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.Talent.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.Post.rawValue||listModel?.widget_type?.integerValue==IngreWidgetType.Topic.rawValue{
                //今日新品
                //早餐日记等
                //推荐达人
                //专题-topic
                return 54
            }
        }
        return 0
    }
  
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let h:CGFloat=54
        if scrollView.contentOffset.y>=h{
            scrollView.contentInset=UIEdgeInsetsMake(-h, 0, 0, 0)
        }else if scrollView.contentOffset.y>0{
           scrollView.contentInset=UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        }
    }
    
    
    
    }


    








