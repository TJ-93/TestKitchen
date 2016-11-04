//
//  FoodCourseService.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/11/3.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class FoodCourseService: NSObject {
    class func handleFoodCourse(courseId:String,onViewController vc:UIViewController){
        let ctrl=FoodCourseController()
        ctrl.courseId=courseId
        vc.navigationController?.pushViewController(ctrl, animated: true)
        
    }
}
