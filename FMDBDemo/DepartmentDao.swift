//
//  DepartmentDao.swift
//  FMDBDemo
//
//  Created by masonhsieh on 2019/3/23.
//  Copyright © 2019 Frank.Chen. All rights reserved.
//

import UIKit
import FMDB

class DepartmentDao: NSObject {
    private let connectionFailureMessage = "Failed to get database connection"
    
    private var database: FMDatabase?
    
    func prepareDatabase() {
        if database == nil || !database!.isOpen {
            database = DatabaseManager.shared.connect()
            
            print("建立資料庫連線")
        }
    }
    
    deinit {
        print("DepartmentDao:deinit")
        
        if database != nil && database!.isOpen {
            database!.close()
            
            print("資料庫連線關閉")
        }
    }
    
    func createTable() throws {
        prepareDatabase()
        
        if !database!.executeStatements(DatabaseScript.createTableDepartment) {
            throw DatabaseError.executionError
        }
    }
    
    func createDepartment(withEnglishName englishName: String, andChineseName chineseName: String) throws {
        prepareDatabase()
        
        if !database!.executeUpdate(DatabaseScript.insertDepartment, withArgumentsIn: [englishName, chineseName]) {
            throw DatabaseError.executionError
        }
    }
    
    func findAllDepartments() throws -> [Department] {
        prepareDatabase()
        
        let result = database!.executeQuery(DatabaseScript.findAllDepartment, withArgumentsIn: [])
        
        var foundDepartments: [Department] = [Department]()
        
        guard let result2 = result else {
            return foundDepartments
        }
        
        while result2.next() {
            foundDepartments.append(
                Department(departmentId: result2.long(forColumn: DepartmentColumns.departmentId),
                           departmentEnglishName: result2.string(forColumn: DepartmentColumns.departmentEnglishName),
                           departmentChineseName: result2.string(forColumn: DepartmentColumns.departmentChineseName)))
        }
        
        return foundDepartments
    }
    
    func findDepartment(withDepartmentId departmentId: Int) throws -> Department? {
        prepareDatabase()
        
        let result = database!.executeQuery(DatabaseScript.findDepartmentById, withArgumentsIn: [departmentId])
        
        guard let result2 = result, result2.next() else {
            return nil
        }
        
        return Department(departmentId: result2.long(forColumn: DepartmentColumns.departmentId),
                          departmentEnglishName: result2.string(forColumn: DepartmentColumns.departmentEnglishName),
                          departmentChineseName: result2.string(forColumn: DepartmentColumns.departmentChineseName))
    }
    
    func deleteDepartment(withDepartmentId departmentId: Int) throws {
        prepareDatabase()
        
        database!.executeUpdate(DatabaseScript.deleteDepartmentById, withArgumentsIn: [departmentId])
    }
    
}
