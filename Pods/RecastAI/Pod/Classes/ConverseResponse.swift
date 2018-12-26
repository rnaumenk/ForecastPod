//
//  ConverseResponse.swift
//
//  Created by Marcus Ataide on 1/23/17.
//  Copyright © 2017 Math. All rights reserved.
//

import UIKit
import ObjectMapper

open class ConverseResponse: Mappable {
    
    public var uuid: String!
    public var source: String!
    public var replies: [String]?
    public var action: [String : Any]?
    public var next_actions: [Any]?
    public var memory: [String : Any]?
    public var entities: [String : Any]?
    public var intents: [Any]?
    public var conversation_token: String!
    public var language: String!
    public var timestamp: String!
    public var version: String!
    public var status: Int!
    
    required convenience public init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    open func mapping(map: Map) {
        uuid <- map["uuid"]
        source <- map["source"]
        replies <- map["replies"]
        action <- map["action"]
        next_actions <- map["next_actions"]
        memory <- map["memory"]
        entities <- map["entities"]
        intents <- map["intents"]
        conversation_token <- map["conversation_token"]
        language <- map["language"]
        timestamp <- map["timestamp"]
        version <- map["version"]
        status <- map["status"]
    }
    
    
}

