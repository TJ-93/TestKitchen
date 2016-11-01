//
//  IngredientViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/21.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class IngredientViewController: BaseViewController {
    //滚动视图
    private var scrollView:UIScrollView?
    //推荐视图
    private var recommendView:IngreRecommendView?
    //食材视图
    private var materialView:IngreMaterialView?
    //分类视图
    private var categoryView:IngreMaterialView?
    //点击食材的推荐页面的某一部分，跳转到后面的界面
//    var jumpClosure:IngreJumpClosure?
    override func viewDidLoad() {
        super.viewDidLoad()
automaticallyAdjustsScrollViewInsets=false
       
        createNav()
        createHomePage()
        downloadRecommendData()
    }
    //创建首页视图
    func createHomePage(){
        scrollView=UIScrollView()
        scrollView!.pagingEnabled=true
        view.addSubview(scrollView!)
        scrollView!.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        }
        let containView=UIView.createView()
        scrollView!.addSubview(containView)
        containView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
       
        //添加子视图
        //1.推荐视图
        recommendView=IngreRecommendView()
        containView.addSubview(recommendView!)
        recommendView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.left.equalToSuperview()
        make.width.equalTo(screenW)
            
        })
        //2.食材
        materialView=IngreMaterialView()
        materialView?.backgroundColor=UIColor.blueColor()
        containView.addSubview(materialView!)
        materialView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(screenW)
            make.left.equalTo((recommendView?.snp_right)!)
        })
        //3.分类
        categoryView=IngreMaterialView()
        categoryView?.backgroundColor=UIColor.redColor()
        containView.addSubview(categoryView!)
        categoryView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(screenW)
            make.left.equalTo((materialView?.snp_right)!)
        })
        containView.snp_makeConstraints { (make) in
            make.right.equalTo(categoryView!)
        }
        
    }
    //创建导航条
    func createNav(){
        self.addNavBtn("saoyisao", target: self, action: #selector(scanAction), isLeft: true)
        self.addNavBtn("search", target: self, action: #selector(searchAction), isLeft: false)
        //选择控件
        let segCtrl=KTCSegCtrl(frame: CGRect(x: 80, y: 0, width: screenW-160, height: 44), titleArray: ["推荐","食材","分类"])
        segCtrl.delegate=self
        navigationItem.titleView=segCtrl
    }
    func scanAction(){
       print("扫一扫")
    }
    func searchAction(){
       print("搜索")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func downloadRecommendData(){
     
        let params=["methodName":"SceneHome","token":"","user_id":"","version":"4.5"]
        let downloader=KtcDownloader()
        downloader.delegate=self
        downloader.postWithUrl(kHostUrl, params: params)
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
extension IngredientViewController:KTCDownloaderDelegate{
    func downloader(downloader: KtcDownloader, didFailWithError error: NSError) {
        print(error)
    }
    
    
    func downloader(downloader: KtcDownloader, didFinishWithData data: NSData?) {
//        _=NSString(data: data!, encoding: NSUTF8StringEncoding)
//        print(str)
        if let tmpData=data{
            let recommendModel=IngreRecommend.paraseData(tmpData)
            
            
//            let recommendView=IngreRecommendView(frame: CGRectZero)
            recommendView!.model=recommendModel
//            view.addSubview(recommendView!)
            recommendView!.jumpClosure={
                jumpUrl in
                print(jumpUrl)
            }
//            recommendView!.snp_makeConstraints(closure: { (make) in
//                make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 64, left: 0, bottom: 49, right: 0))
//            })
            
        }
    }
    
}
//MARK:KTCSegCtrl代理
extension IngredientViewController:KTCSegCtrlDelegate{
    func segCtrl(segCtrl: KTCSegCtrl, didClickVtbAtIndex index: Int) {
        scrollView?.setContentOffset(CGPointMake(CGFloat(index)*screenW,0), animated: true)
    }
}





