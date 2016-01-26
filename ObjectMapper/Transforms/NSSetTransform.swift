//
//  NSSetTransform.swift
//  ModuleTesterSwift
//
//  Created by Bruce, Matt R on 1/25/16.
//  Copyright © 2016 Verizon. All rights reserved.
//

import Foundation
import CoreData

public class NSSetTransform<T:MappableManagedObject> : TransformType {
    public typealias Object = NSSet
    public typealias JSON = [AnyObject]
    
    private let mapper: Mapper<T>?
    
    public init(context: NSManagedObjectContext){
        self.mapper = Mapper<T>(context: context)
    }
    
    public func transformFromJSON(value: AnyObject?) -> Object? {
        
        guard let _mapper = self.mapper else {
            NSException.raise("NSSetTransform", format: "The class needs to initialize with the init(context: NSManagedObjectContext)", arguments: getVaList([""]) )
            return nil
        }
        
        var results = [T]()
        if let value = value as? [AnyObject] {
            for json in value {
                if let obj = _mapper.map(json) {
                    results.append(obj)
                }
            }
        }
        return NSSet(array: results)
    }
    
    public func transformToJSON(value: NSSet?) -> JSON? {
        
        guard let _mapper = self.mapper else {
            NSException.raise("NSSetTransform", format: "The class needs to initialize with the init(context: NSManagedObjectContext)", arguments: getVaList([""]) )
            return nil
        }
        
        var results = [AnyObject]()
        if let value = value {
            if let v = value.allObjects as? [T] {
                for obj in v {
                    let json = _mapper.toJSON(obj)
                    results.append(json)
                }
            }
        }
        return results
    }
}
