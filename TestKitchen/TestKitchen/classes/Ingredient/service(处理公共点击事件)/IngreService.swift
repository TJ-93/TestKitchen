//
//  IngreService.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/11/3.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
//IngreFactory
class IngreService: NSObject {
    class func handldEvent(urlString:String,onViewController vc:UIViewController){
        if urlString.hasPrefix("app://food_course_series"){
            //食材课程的分集显示
            let array=urlString.componentsSeparatedByString("#")
            if array.count>1{
                let courseId=array[1]
               FoodCourseService.handleFoodCourse(courseId, onViewController: vc)
            }

        }
        
    }
}
