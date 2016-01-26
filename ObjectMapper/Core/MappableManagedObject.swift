//
//  MappableManagedObject.swift
//  ModuleTesterSwift
//
//  Created by Bruce, Matt R on 1/25/16.
//  Copyright © 2016 Verizon. All rights reserved.
//

import Foundation
import CoreData

public class MappableManagedObject: NSManagedObject, Mappable{
    public var context: NSManagedObjectContext { get { return self.managedObjectContext! }}
    
    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    public required init?(_ map: Map, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName(NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!, inManagedObjectContext: context)
        super.init(entity: entity!, insertIntoManagedObjectContext: context)
        map.context = context
    }
    
    public func mapping(map: Map) {
        NSException.raise("MappableManagedObjectError", format: "The class %@ needs to override the func mapping(map: Map)", arguments: getVaList([NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!]) )
    }
}