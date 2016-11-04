//
//  IngreMaterial.swift
//  TestKitchen
//
//  Created by qianfeng on 2016/11/2.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
import SwiftyJSON
class IngreMaterial: NSObject {
    var code:String?
    var data:IngreMaterialData?
    var msg:String?
    var timetamp:NSNumber?
    var version:String?
    class func parseData(data:NSData)->IngreMaterial{
        let json=JSON(data:data)
        let model=IngreMaterial()
        model.code=json["code"].string
        model.data=IngreMaterialData.parse(json["data"])
        model.msg=json["msg"].string
        model.timetamp=json["timetamp"].number
       model.version=json["version"].string
        return model
    }
}
class IngreMaterialData:NSObject{
    var data:[IngreMaterialType]?
    var id:NSNumber?
    var name:String?
    var text:String?
    class func parse(json:JSON)->IngreMaterialData{
       
        let model=IngreMaterialData()
        var array=[IngreMaterialType]()
        for (_,subJson) in json["data"]{
            let typeModel=IngreMaterialType.parse(subJson)
            array.append(typeModel)
        }
        model.data=array
        model.id=json["id"].number
        model.name=json["name"].string
        model.text=json["text"].string
        return model
    }
}
class IngreMaterialType:NSObject{
    var data:[IngreMaterialSubtype]?
    var id:String?
    var image:String?
    var text:String?
    class func parse(json:JSON)->IngreMaterialType{
        let model=IngreMaterialType()
        var array=[IngreMaterialSubtype]()
        for (_,subJson) in json["data"]{
            let model=IngreMaterialSubtype.parse(subJson)
            array.append(model)
        }
        model.data=array
        model.id=json["id"].string
        model.image=json["image"].string
        model.text=json["text"].string
        return model
    }
}
class IngreMaterialSubtype:NSObject{
    var id:String?
    var image:String?
    var text:String?
    class func parse(json:JSON)->IngreMaterialSubtype{
        let model=IngreMaterialSubtype()
        model.id=json["id"].string
        model.image=json["image"].string
        model.text=json["text"].string
        return model
    }
}