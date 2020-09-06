//
//  MotherboardLivable.swift
//  Boardy
//
//  Created by NGUYEN CHI CONG on 9/6/20.
//

import Foundation
import UIKit

public protocol MotherboardLivable: AnyObject {
    var motherboard: FlowMotherboard { get set }
}

private var motherboardKey: UInt8 = 105

extension MotherboardLivable where Self: UIViewController {
    func getAssociatedMotherboard() -> FlowMotherboard? {
        return objc_getAssociatedObject(self, &motherboardKey) as? FlowMotherboard
    }

    func setAssociatedMotherboard(_ value: FlowMotherboard?) {
        objc_setAssociatedObject(self, &motherboardKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    public var motherboard: FlowMotherboard {
        get {
            if let board = getAssociatedMotherboard() {
                return board
            } else {
                let newBoard = Motherboard()
                setAssociatedMotherboard(newBoard)
                return newBoard
            }
        }

        set {
            newValue.install(into: self)
            setAssociatedMotherboard(newValue)
        }
    }
}

// MARK: - Utility extensions

extension UIViewController: MotherboardLivable {
    /// Install a board and keep it alive with view controller's lifecycle.

    public func attachMotheboard(_ board: FlowMotherboard) {
        motherboard = board
        install(board: board)
    }
}
