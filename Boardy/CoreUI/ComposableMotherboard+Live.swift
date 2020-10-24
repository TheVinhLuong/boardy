//
//  ComposableMotherboard+Live.swift
//  Boardy
//
//  Created by NGUYEN CHI CONG on 10/22/20.
//

import Foundation
import UIKit

public protocol ComposableMotherboardLivable: AnyObject {
    var composableMotherboard: FlowComposableMotherboard { get set }
}

private var composableMotherboardKey: UInt8 = 109

extension ComposableMotherboardLivable where Self: AnyObject {
    private func getAssociatedComposableMotherboard() -> FlowComposableMotherboard? {
        return objc_getAssociatedObject(self, &composableMotherboardKey) as? FlowComposableMotherboard
    }

    private func setAssociatedComposableMotherboard(_ value: FlowComposableMotherboard?) {
        value?.installIntoRoot(self)
        objc_setAssociatedObject(self, &composableMotherboardKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    public var composableMotherboard: FlowComposableMotherboard {
        get {
            if let board = getAssociatedComposableMotherboard() {
                return board
            } else {
                let newBoard = ComposableMotherboard()
                setAssociatedComposableMotherboard(newBoard)
                return newBoard
            }
        }

        set {
            setAssociatedComposableMotherboard(newValue)
        }
    }
}

// MARK: - Utility extensions

extension NSObject: ComposableMotherboardLivable {
    /// Install a board and keep it alive with rootObject's lifecycle.
    public func attachComposableMotheboard(_ motherboard: FlowComposableMotherboard) {
        composableMotherboard = motherboard
        install(board: motherboard)
    }
}

extension ComposableMotherboardType where Self: FlowManageable {
    public func attach(to object: NSObject) {
        object.attachComposableMotheboard(self)
    }
}
