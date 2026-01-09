//
//  SuiHumanReadable.swift
//  SuiSwift
//
//  Created by li shuai on 2026/1/9.
//
import CryptoSwift
import Foundation
public protocol SuiHumanReadable {
    func toHuman() -> Any
}

extension SuiTransactionData: SuiHumanReadable {
    public func toHuman() -> Any {
        switch self {
        case .V1(let suiTransactionDataV1):
            return [
                "V1": suiTransactionDataV1.toHuman()
            ]
        }
    }
}

extension SuiTransactionDataV1: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "kind": self.kind.toHuman(),
            "sender": self.sender.value,
            "gasData": self.gasData.toHuman(),
            "expiration": self.expiration.toHuman()
        ]
    }
}

extension SuiTransactionKind: SuiHumanReadable {
    public func toHuman() -> Any {
        switch self {
        case .ProgrammableTransaction(let suiProgrammableTransaction):
            return [
                "ProgrammableTransaction": suiProgrammableTransaction.toHuman()
            ]
        case .ChangeEpoch:
            return "ChangeEpoch"
        case .Genesis:
            return "Genesis"
        case .ConsensusCommitPrologue:
            return "ConsensusCommitPrologue"
        }
    }
}

extension SuiProgrammableTransaction: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "inputs": self.inputs.map({$0.toHuman()}),
            "transactions": self.transactions.map({$0.toHuman()})
        ]
    }
}

extension SuiTransactionInner: SuiHumanReadable {
    public func toHuman() -> Any {
        switch self {
        case .MoveCall(let suiMoveCallTransaction):
            return suiMoveCallTransaction.toHuman()
        case .TransferObjects(let suiTransferObjectsTransaction):
            return suiTransferObjectsTransaction.toHuman()
        case .SplitCoins(let suiSplitCoinsTransaction):
            return suiSplitCoinsTransaction.toHuman()
        case .MergeCoins(let suiMergeCoinsTransaction):
            return suiMergeCoinsTransaction.toHuman()
        case .Publish(let suiPublishTransaction):
            return suiPublishTransaction.toHuman()
        case .MakeMoveVec(let suiMakeMoveVecTransaction):
            return suiMakeMoveVecTransaction.toHuman()
        case .Upgrade(let suiUpgradeTransaction):
            return suiUpgradeTransaction.toHuman()
        }
    }
}

extension SuiUpgradeTransaction: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "kind": "Upgrade",
            "modules": self.modules.map({Data($0).toHexString()}),
            "dependencies": self.dependencies.map({$0.value}),
            "packageId": self.packageId.value,
            "ticket": self.ticket.toHuman()
        ]
    }
}

extension SuiMakeMoveVecTransaction: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "kind": "MakeMoveVec",
            "type": self.type?.map({$0}) ?? [],
            "objects": self.objects.map({$0.toHuman()})
        ]
    }
}

extension SuiTypeTag: SuiHumanReadable {
    public func toHuman() -> Any {
        switch self {
        case .Bool:
            return "Bool"
        case .UInt8:
            return "UInt8"
        case .UInt64:
            return "UInt64"
        case .UInt128:
            return "UInt128"
        case .Address:
            return "Address"
        case .Signer:
            return "Signer"
        case .Vector(let suiTypeTag):
            return suiTypeTag.toHuman()
        case .Struct(let suiStructTag):
            return suiStructTag.toHuman()
        case .UInt16:
            return "UInt16"
        case .UInt32:
            return "UInt32"
        case .UInt256:
            return "UInt256"
        }
    }
}

extension SuiStructTag: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "address": self.address.value,
            "module": self.module,
            "name": self.name,
            "typeParams": self.typeParams?.map({$0.toHuman()}) ?? []
        ]
    }
}

extension SuiPublishTransaction: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "kind": "Publish",
            "modules": self.modules.map({Data($0).toHexString()}),
            "dependencies": self.dependencies.map({$0.value})
        ]
    }
}

extension SuiMergeCoinsTransaction: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "kind": "MergeCoins",
            "destination": self.destination.toHuman(),
            "sources": self.sources.map({$0.toHuman()})
        ]
    }
}

extension SuiSplitCoinsTransaction: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "kind": "SplitCoins",
            "coin": self.coin.toHuman(),
            "amounts": self.amounts.map({$0.toHuman()})
        ]
    }
}

extension SuiTransferObjectsTransaction: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "kind": "TransferObjects",
            "objects": self.objects.map({$0.toHuman()}),
            "address": self.address.toHuman()
        ]
    }
}

extension SuiMoveCallTransaction: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "kind": "MoveCall",
            "target": self.target,
            "typeArguments": self.typeArguments ?? [],
            "arguments": self.arguments.map({$0.toHuman()})
        ]
    }
}

extension SuiTransactionArgumentType: SuiHumanReadable {
    public func toHuman() -> Any {
        switch self {
        case .GasCoin(_):
            return "GasCoin"
        case .TransactionBlockInput(let suiTransactionBlockInput):
            return suiTransactionBlockInput.toHuman()
        case .Result(let suiResultArgumentType):
            return suiResultArgumentType.toHuman()
        case .NestedResult(let suiNestedResultArgumentType):
            return suiNestedResultArgumentType.toHuman()
        }
    }
}

extension SuiResultArgumentType: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "kind": "Result",
            "index": self.index
        ]
    }
}

extension SuiNestedResultArgumentType: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "kind": "NestedResult",
            "index": self.index,
            "resultIndex": self.resultIndex
        ]
    }
}

extension SuiTransactionBlockInput: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "kind": "Input",
            "index": self.index,
            "value": self.value?.toHuman() ?? "",
            "type": self.type ?? ""
        ]
    }
}

extension SuiJsonValue: SuiHumanReadable {
    public func toHuman() -> Any {
        switch self {
        case .Boolean(let bool):
            return bool
        case .Number(let string):
            return string
        case .Str(let string):
            return string
        case .CallArg(let suiCallArg):
            return suiCallArg.toHuman()
        case .Array(let array):
            return array.map({$0.toHuman()})
        }
    }
}

extension SuiCallArg: SuiHumanReadable {
    public func toHuman() -> Any {
        switch self {
        case .Pure(let array):
            return Data(array).toHexString()
        case .Object(let suiObjectArg):
            return suiObjectArg.toHuman()
        case .ObjVec(let array):
            return array.map({$0.toHuman()})
        }
    }
}

extension SuiObjectArg: SuiHumanReadable {
    public func toHuman() -> Any {
        switch self {
        case .ImmOrOwned(let suiObjectRef):
            return suiObjectRef.toHuman()
        case .Shared(let suiSharedObjectRef):
            return suiSharedObjectRef.toHuman()
        }
    }
}

extension SuiSharedObjectRef: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "objectId": self.objectId.value,
            "initialSharedVersion": self.initialSharedVersion,
            "mutable": self.mutable
        ]
    }
}

extension SuiGasData: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "payment": self.payment.map({$0.toHuman()}),
            "owner": self.owner.value,
            "price": self.price,
            "budget": self.budget
        ]
    }
}

extension SuiObjectRef: SuiHumanReadable {
    public func toHuman() -> Any {
        return [
            "digest": self.digest.value,
            "objectId": self.objectId.value,
            "version": self.version
        ]
    }
}

extension SuiTransactionExpiration: SuiHumanReadable {
    public func toHuman() -> Any {
        switch self {
        case .None:
            return "none"
        case .Epoch(let uInt64):
            return uInt64
        }
    }
}
