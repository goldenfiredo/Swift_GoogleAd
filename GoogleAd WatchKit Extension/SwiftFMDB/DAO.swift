//
//  DAO.swift
//  SwiftFMDBDemo
//
//  Created by Du Limin on 11/15/14.
//  Copyright (c) 2014 GoldenFire.Do. All rights reserved.
//

import Foundation

class DAO {
    var db:FMDatabase
    var tableName:String
    
    init () {
        db = DB.sharedInstance.getDatabase()!
        tableName = DB.tableName
    }
    
    func getRecordSet()->[Entry] {
        
        var result:[Entry] = []
        
        let sql = "SELECT * FROM \(tableName)"
        print("\(sql)")
        
        let rs = db.executeQuery(sql, withArgumentsInArray: nil)
        while (rs.next()) {
            let entry = Entry()
            let id = rs.intForColumn("id")
            let name = rs.stringForColumn("name")
            let desc = rs.stringForColumn("description")
            entry.id = id
            entry.name = name
            entry.description = desc
            
            print("id:\(id), name:\(name), desc:\(desc)")
            
            result.append(entry)
        }
        
        rs.close()
        
        return result
    }
    
    func query(name:String, description:String)->Entry? {
        var result:Entry?
        
        let sql = "SELECT * FROM \(tableName) where name= ? and description = ?"
        let args = [name, description]
        print("\(sql)")
        
        let rs = db.executeQuery(sql, withArgumentsInArray: args)
        if (rs.next()) {
            result = Entry()
            let id = rs.intForColumn("id")
            let name = rs.stringForColumn("name")
            let desc = rs.stringForColumn("description")
            result!.id = id
            result!.name = name
            result!.description = desc
        }
    
        return result
    }
    
    func insert(name:String, description:String)->Bool {
        let sql = "INSERT INTO \(tableName) (name, description) VALUES (?, ?)"
        let args = [name, description]
        print("\(sql)")
        
        db.executeUpdate(sql, withArgumentsInArray: args)
        
        if db.hadError() {
            print("error:\(db.lastErrorMessage())", terminator: "")
            return false
        }
        
        return true
    }
    
    func delete(name:String, description:String)->Bool {
        let sql = "DELETE FROM \(tableName) where name= ? and description = ?"
        let args = [name, description]
        print("\(sql)")
        
        db.executeUpdate(sql, withArgumentsInArray: args)
        
        if db.hadError() {
            print("error:\(db.lastErrorMessage())", terminator: "")
            return false
        }
        
        return true
    }
    
    deinit {
       //DB.sharedInstance.closeDatabase()
    }
}
