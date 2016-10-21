//
//  MainTabBarViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/10/21.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
class MainTabBarViewController: UITabBarController {
//tabbar的背景
    private var bgView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
createViewControllers()  // Do any additional setup after loading the view.
        tabBar.hidden=true
      createTabBar()
      
    }
    
    //自定制 TabBar
    func createTabBar(){
        bgView=UIView.createView()
        bgView?.backgroundColor=UIColor(white: 0.9, alpha: 1.0)

        view.addSubview(bgView!)
        bgView?.snp_makeConstraints(closure: { [unowned self](make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(49)
        })
        let imageNames=["home","community","shop","shike","mine"]
        let titles=["食材","社区","商城","食客","我的"]
        
let width=screenW/CGFloat(imageNames.count)
        for i in 0..<imageNames.count{
            let imageName=imageNames[i]+"_normal"
            let selectName=imageNames[i]+"_select"
            let btn=UIButton.createBtn(nil, bgImageName: imageName, highlightImageName: nil, selectImageName: selectName, target: self, action: #selector(btnClick(_:)))
            btn.tag=300+i
            bgView!.addSubview(btn)
            btn.snp_makeConstraints(closure: { (make) in
                make.width.equalTo(width)
                make.top.bottom.equalTo(bgView!)
                make.left.equalTo(CGPoint(x: 0+CGFloat(i)*width, y: 0))
                if i==0{
                    btn.selected=true
                }
                
            })
            let titleLabel=UILabel.createLabel(titles[i], textAlignment: .Center, font: UIFont.systemFontOfSize(10))
            btn.addSubview(titleLabel)
            
            titleLabel.snp_makeConstraints(closure: { (make) in
                make.left.right.bottom.equalTo(btn)
                make.height.equalTo(20)
            })
        }
   
    }
    func btnClick(curbtn:UIButton){
       let index=curbtn.tag-300
        //1.1取消之前的按钮
        let lastBtn=bgView?.viewWithTag(300+selectedIndex) as! UIButton
        lastBtn.userInteractionEnabled=true
        lastBtn.selected=false
        //1.2选中当前的按钮
        curbtn.selected=true
        curbtn.userInteractionEnabled=false
        //1.3切换视图控制器
        selectedIndex=index
        
    }
//创建视图控制器
    func createViewControllers(){
        let nameArray=["TestKitchen.IngredientViewController","TestKitchen.CommunityViewController","TestKitchen.MallViewController","TestKitchen.FoodClassViewController","TestKitchen.MineViewController"]
        let imageNames=["home","community","shop","shike","mine"]
        let titles=["食材","社区","商城","食客","我的"]
        var ctrlArray=[UINavigationController]()
        for i in 0..<nameArray.count{
            //使用类名创建类的对象
            let ctrl=NSClassFromString(nameArray[i]) as! UIViewController.Type
            
            let vc=ctrl.init()
            vc.tabBarItem.title=titles[i]
            let selectName=imageNames[i]+"_select"
            vc.tabBarItem.selectedImage=UIImage(named: selectName)
            let imageName=imageNames[i]+"_normal"
            vc.tabBarItem.image=UIImage(named: imageName)
            let navCtrl=UINavigationController(rootViewController: vc)
            ctrlArray.append(navCtrl)
        }
        viewControllers=ctrlArray
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
