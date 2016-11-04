//
//  KtcDownload.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/24.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
import Alamofire

protocol KTCDownloaderDelegate:NSObjectProtocol {
    //下载失败
    func downloader(downloader:KtcDownloader,didFailWithError error:NSError)
    //下载成功
    func downloader(downloader:KtcDownloader,didFinishWithData data:NSData?)
}
enum KTCDownloadType:Int{
    case Normal=0
    case IngreRecommend    //首页推荐
    case IngreMaterial     //首页食材
    case IngreCategory     //首页分类
    case IngreFoodCourseDetail//食材课程的详情
    case IngreFoodCourseComment//食材课程的评论
}
class KtcDownloader: NSObject {
    weak var delegate:KTCDownloaderDelegate?
    var downloadType:KTCDownloadType = .Normal
    func postWithUrl(urlString:String,params:[String:AnyObject]){
        var tmpDict=NSDictionary(dictionary: params) as! [String:AnyObject]
        //设置所有接口的公共参数
        tmpDict["token"]=""
        tmpDict["user_i"]=""
        tmpDict["version"]="4.5"
//      methodName=MaterialSubtype&token=&user_id=&version=4.32
        
         Alamofire.request(.POST, urlString, parameters: tmpDict, encoding: ParameterEncoding.URL, headers: nil).responseData { (response) in
            switch response.result{
            case .Failure(let error):
                self.delegate?.downloader(self, didFailWithError: error)
            case .Success(let value):
                self.delegate?.downloader(self, didFinishWithData: value)
            }
        }
    }
}
