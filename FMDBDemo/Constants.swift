//
//  Constants.swift
//  FMDBDemo
//
//  Created by masonhsieh on 2019/3/23.
//  Copyright © 2019 Frank.Chen. All rights reserved.
//

import Foundation

struct Tables {
    static let department = "DEPARTMENT"
}

struct DepartmentColumns {
    static let departmentId = "DEPT_ID"
    static let departmentEnglishName = "DEPT_NAME_EN"
    static let departmentChineseName = "DEPT_NAME_CH"
}

struct DatabaseScript {
    static let createTableDepartment = """
        CREATE TABLE \(Tables.department) (
        \(DepartmentColumns.departmentId) INTEGER PRIMARY KEY AUTOINCREMENT,
        \(DepartmentColumns.departmentEnglishName) NVARCHAR(100),
        \(DepartmentColumns.departmentChineseName) NVARCHAR(100))
    """
    
    static let insertDepartment = """
        INSERT INTO \(Tables.department) (
        \(DepartmentColumns.departmentEnglishName),
        \(DepartmentColumns.departmentChineseName)
        ) VALUES (?, ?)
    """
    
    static let findAllDepartment = """
        SELECT \(DepartmentColumns.departmentId),
               \(DepartmentColumns.departmentEnglishName),
               \(DepartmentColumns.departmentChineseName)
        FROM DEPARTMENT
    """
    
    static let deleteDepartmentById = """
        DELETE FROM DEPARTMENT WHERE \(DepartmentColumns.departmentId) = ?
    """
    
    static let findDepartmentById = """
        SELECT \(DepartmentColumns.departmentId),
               \(DepartmentColumns.departmentEnglishName),
               \(DepartmentColumns.departmentChineseName)
        FROM DEPARTMENT
        WHERE \(DepartmentColumns.departmentId) = ?
    """
}

enum DatabaseError: Error {
    case connectionError
    case executionError
}
