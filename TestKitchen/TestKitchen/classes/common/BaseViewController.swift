//
//  BaseViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/21.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
/*视图控制器的公共父类，用来封装一些共有的代码*/
class BaseViewController: UIViewController {
    func addNavBtn(imageName:String,target:AnyObject?,action:Selector,isLeft:Bool){
        let btn=UIButton.createBtn(nil,bgImageName: imageName, highlightImageName: nil, selectImageName: nil, target: target, action: action)
        btn.frame=CGRect(x: 0, y: 0, width: 28, height: 42)
        let barBtn=UIBarButtonItem(customView: btn)
        if isLeft{
            navigationItem.leftBarButtonItem=barBtn
        }else{
            navigationItem.rightBarButtonItem=barBtn
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       view.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
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
