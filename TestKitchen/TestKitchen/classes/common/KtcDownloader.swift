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

class KtcDownloader: NSObject {
    weak var delegate:KTCDownloaderDelegate?
    func postWithUrl(urlString:String,params:[String:AnyObject]){
        
       
        
         Alamofire.request(.POST, urlString, parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseData { (response) in
            switch response.result{
            case .Failure(let error):
                self.delegate?.downloader(self, didFailWithError: error)
            case .Success(let value):
                self.delegate?.downloader(self, didFinishWithData: value)
            }
        }
    }
}
