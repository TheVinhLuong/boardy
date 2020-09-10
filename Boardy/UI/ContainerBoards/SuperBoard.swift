//
//  SuperBoard.swift
//  Boardy
//
//  Created by NGUYEN CHI CONG on 8/27/20.
//

import Foundation

/// A SuperBoard contains an internal sub-motherboard and an internal sub-uimotherboard by default.
open class SuperBoard: ContinuousBoard {
    public let uimotherboard: FlowUIMotherboard

    public init(identifier: BoardID = UUID().uuidString,
                motherboard: FlowMotherboard = Motherboard(),
                uimotherboard: FlowUIMotherboard = UIMotherboard()) {
        self.uimotherboard = uimotherboard
        super.init(identifier: identifier, motherboard: motherboard)

        motherboard.registerGeneralFlow { [weak self] (action: BoardFlowAction) in
            self?.sendFlowAction(action)
        }

        uimotherboard.registerGeneralFlow { [weak self] (action: BoardFlowAction) in
            self?.sendFlowAction(action)
        }
    }

    override open func install(into rootViewController: UIViewController) {
        super.install(into: rootViewController)
        uimotherboard.install(into: rootViewController)
    }
}
