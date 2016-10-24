//
//  CommunityViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/21.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class CommunityViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor=UIColor.redColor()
//       downloadRecommendData()
    }
    //methodName=SceneHome&token=&user_id=&version=4.5
//    func downloadRecommendData(){
//       var params=["methodName":"SceneHome","token":"","user_id":"","version":"4.5"]
//        let downloader=KtcDownloader()
//        downloader.delegate=self
//        downloader.postWithUrl(<#T##urlString: String##String#>, params: params)
//    }
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
