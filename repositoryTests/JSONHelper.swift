//
//  MockRepositoryService.swift
//  BucketListTests
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation
@testable import Repository

final class JSONHelper  {
    class func readJson(_ fromTarget: AnyClass, fromFile: String) -> Data? {
        guard let pathString = Bundle(for: fromTarget).path(forResource: fromFile, ofType: "json") else { return nil }
        guard let pathJson = try? String(contentsOfFile: pathString) else { return nil }
        let data = pathJson.data(using: .utf8)
        return data
    }
}
