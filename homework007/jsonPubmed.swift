//
//  jsonPubmed.swift
//  homework008
//
//  Created by FISH on 2018/12/8.
//  Copyright © 2018年 FISH. All rights reserved.
//

import Foundation

struct pubmedSearch: Codable {
    var esearchresult: searchResult
}

struct searchResult: Codable {
    var idlist: [String]
}
