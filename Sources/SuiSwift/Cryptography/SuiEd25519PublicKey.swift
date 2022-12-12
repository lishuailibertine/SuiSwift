//
//  File.swift
//  
//
//  Created by li shuai on 2022/10/26.
//

import Foundation
import CryptoSwift

public struct SuiEd25519PublicKey: SuiPublicKey{
    public var publicKey: Data
    private static let PUBLIC_KEY_SIZE = 32
    public init(publicKey: Data) throws {
        guard publicKey.count == SuiEd25519PublicKey.PUBLIC_KEY_SIZE else{
            throw SuiError.KeypairError.InvalidPublicKey
        }
        self.publicKey = publicKey
    }
    public func toBase64() throws -> String {
        return publicKey.bytes.toBase64()
    }
    public func toSuiAddress() throws -> SuiAddress {
        var tmp = [UInt8]()
        tmp.append(SuiSignatureScheme.ED25519.rawValue)
        publicKey.forEach{tmp.append($0)}
        let address = Data(tmp).sha3(.sha256)[0..<20].toHexString()
        return try SuiAddress(value: address.addHexPrefix())
    }
}
