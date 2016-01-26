//
//  Mappable.swift
//  ObjectMapper
//
//  Created by Scott Hoyt on 10/25/15.
//  Copyright © 2015 hearst. All rights reserved.
//

import Foundation
import CoreData

public protocol Mappable {
	init?(_ map: Map)
	var context: NSManagedObjectContext { get }
	mutating func mapping(map: Map)
}

public protocol MappableCluster: Mappable {
	static func objectForMapping(map: Map) -> Mappable?
}

public extension Mappable {
	
	/// Initializes object from a JSON String
	public init?(context: NSManagedObjectContext, JSONString: String) {
		if let obj: Self = Mapper(context: context).map(JSONString) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Initializes object from a JSON Dictionary
	public init?(context: NSManagedObjectContext, JSON: [String : AnyObject]) {
		if let obj: Self = Mapper(context: context).map(JSON) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Returns the JSON Dictionary for the object
	public func toJSON() -> [String: AnyObject] {
		return Mapper(context: self.context).toJSON(self)
	}
	
	/// Returns the JSON String for the object
	public func toJSONString(prettyPrint: Bool = false) -> String? {
		return Mapper(context: self.context).toJSONString(self, prettyPrint: prettyPrint)
	}
}

public extension Array where Element: Mappable {
	
	/// Initialize Array from a JSON String
	public init?(context: NSManagedObjectContext, JSONString: String) {
		if let obj: [Element] = Mapper(context: context).mapArray(JSONString) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Initialize Array from a JSON Array
	public init?(context: NSManagedObjectContext, JSONArray: [[String : AnyObject]]) {
		if let obj: [Element] = Mapper(context: context).mapArray(JSONArray) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Returns the JSON Array
	public func toJSON(context: NSManagedObjectContext) -> [[String : AnyObject]] {
		return Mapper(context: context).toJSONArray(self)
	}
	
	/// Returns the JSON String for the object
	public func toJSONString(context: NSManagedObjectContext, prettyPrint: Bool = false) -> String? {
		return Mapper(context: context).toJSONString(self, prettyPrint: prettyPrint)
	}
}

public extension Set where Element: Mappable {
	
	/// Initializes a set from a JSON String
	public init?(context: NSManagedObjectContext, JSONString: String) {
		if let obj: Set<Element> = Mapper(context: context).mapSet(JSONString) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Initializes a set from JSON
	public init?(context: NSManagedObjectContext, JSONArray: [[String : AnyObject]]) {
		if let obj: Set<Element> = Mapper(context: context).mapSet(JSONArray) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Returns the JSON Set
	public func toJSON(context: NSManagedObjectContext) -> [[String : AnyObject]] {
		return Mapper(context: context).toJSONSet(self)
	}
	
	/// Returns the JSON String for the object
	public func toJSONString(context: NSManagedObjectContext, prettyPrint: Bool = false) -> String? {
		return Mapper(context: context).toJSONString(self, prettyPrint: prettyPrint)
	}
}
