//
//  FoodCourseController.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/11/3.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class FoodCourseController: BaseViewController {
    var courseId:String?
    var tbView:UITableView?
    private var detailData:FoodCourseDetail?
    
    //创建表格
    func createTableView(){
        automaticallyAdjustsScrollViewInsets=false
        tbView=UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate=self
        tbView?.dataSource=self
        view.addSubview(tbView!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
          //下载详情数据
        downloadDetailData()
    }
    func downloadDetailData(){
        let downloader=KtcDownloader()
        if courseId != nil{
            downloader.delegate=self
            let params=["methodName":"CourseSeriesView","series_id":"\(courseId!)"]
            downloader.downloadType = .IngreFoodCourseDetail
            downloader.postWithUrl(kHostUrl, params: params)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension FoodCourseController:KTCDownloaderDelegate{
    func downloader(downloader: KtcDownloader, didFinishWithData data: NSData?) {
        if downloader.downloadType == .IngreFoodCourseDetail{
            //详情
            let str=NSString(data:data!,encoding: NSUTF8StringEncoding)
            print(str)
            if let tmpData=data{
                detailData=FoodCourseDetail.parse(tmpData)
            }
        }else if downloader.downloadType == .IngreFoodCourseComment{
            //评论
        }
    }
    func downloader(downloader: KtcDownloader, didFailWithError error: NSError) {
        print(error)
    }
    
}
//MARK:UITableView代理
extension FoodCourseController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0{
            return 3
        }else if section==1{
            return 0
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}




