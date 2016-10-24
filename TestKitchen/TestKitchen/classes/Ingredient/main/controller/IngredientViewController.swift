//
//  IngredientViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/21.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class IngredientViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       downloadRecommendData()
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
        let str=NSString(data: data!, encoding: NSUTF8StringEncoding)
        print(str)
    }
    
}






