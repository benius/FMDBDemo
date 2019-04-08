//
//  Department.swift
//  FMDBDemo
//
//  Created by masonhsieh on 2019/3/23.
//  Copyright © 2019 Frank.Chen. All rights reserved.
//

import Foundation

class Department: NSObject {
    var departmentId: Int
    var departmentEnglishName: String?
    var departmentChineseName: String?
    
    init(departmentId: Int!, departmentEnglishName: String?, departmentChineseName: String?) {
        self.departmentId = departmentId
        self.departmentEnglishName = departmentEnglishName
        self.departmentChineseName = departmentChineseName
    }
}
