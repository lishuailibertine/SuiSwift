//
//  Borsh.swift
//  
//
//  Created by li shuai on 2022/12/20.
//

import Foundation

public typealias BorshCodable = BorshSerializable & BorshDeserializable

public struct UVarInt {
    public let value: UInt32
    public init<T: FixedWidthInteger>(_ value: T) {
        self.value = UInt32(value)
    }
}

public struct VarData {
    public let data: Data
    public init(_ data: Data) {
        self.data = data
    }
}

public struct Base64String{
    public let value: String
    public init(value: String) {
        self.value = value
    }
}

public struct Base58String{
    public let value: String
    public init(value: String) {
        self.value = value
    }
}
public struct ASCIIString{
    public let value: String
    public init(value: String) {
        self.value = value
    }
}
