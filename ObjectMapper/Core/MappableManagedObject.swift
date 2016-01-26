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
    
    public required init?(_ map: Map) {
		let ctx = map.context
		let cname = NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!
        let entity = NSEntityDescription.entityForName(cname, inManagedObjectContext: ctx)
        super.init(entity: entity!, insertIntoManagedObjectContext: ctx)
        map.context = context
    }
    
    public func mapping(map: Map) {
        NSException.raise("MappableManagedObjectError", format: "The class %@ needs to override the func mapping(map: Map)", arguments: getVaList([NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!]) )
    }
}