//
//  DatabaseManager.swift
//  FMDBDemo
//
//  Created by masonhsieh on 2019/3/23.
//  Copyright © 2019 Frank.Chen. All rights reserved.
//

import UIKit
import FMDB

class DatabaseManager: NSObject {
    static let shared = DatabaseManager()
    
    let dbFilename: String = "fmdbdemo"
    let dbFilenameType: String = "db"
    
    private var dbFilePath: String = ""
    private var database: FMDatabase!
    
    private override init() {
        super.init()
        
        self.dbFilePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                              FileManager.SearchPathDomainMask.userDomainMask,
                                                              true)[0]
            + "/" + self.dbFilename + "." + self.dbFilenameType
        
        print("Database file path: \(self.dbFilePath)")
        
        copyDbFileFromLocalIfNotExists()
    }
    
    fileprivate func copyDbFileFromLocalIfNotExists() {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: self.dbFilePath) {
            guard let localDbFilePath = Bundle.main.path(forResource: dbFilename, ofType: dbFilenameType) else {
                print("Local db file \(dbFilename + "." + dbFilenameType) not exists.")
                return
            }
            
            do {
                try fileManager.copyItem(atPath: localDbFilePath, toPath: self.dbFilePath)
                print("Copied local db file \"\(dbFilename + "." + dbFilenameType)\" to \"\(self.dbFilePath)\"")
            } catch {
                print("Failed to copy db file!\n\(error)")
            }
        }
    }
    
    func connect() -> FMDatabase? {
        if self.database == nil {
            self.database = FMDatabase(path: self.dbFilePath)
        }
        
        if self.database.open() == false {
            return nil
        }
        
        return self.database
    }

}
