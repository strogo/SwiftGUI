//
// Copyright (c) 2020, Erick Jung.
// All rights reserved.
//
// This source code is licensed under the MIT-style license found in the
// LICENSE file in the root directory of this source tree.
//

import Foundation

public class Tree: GuiNode,
                   ActiveColorModifier,
                   HoveredColorModifier {

    public var activeColor: GuiColor?
    public var hoveredColor: GuiColor?

    public var text: String
    public var options: GuiTreeConfig

    private let child: GuiView

    public init(_ text: String,
                options: GuiTreeConfig = .none,
                @GuiBuilder child: () -> GuiView) {

        self.text = text
        self.options = options
        self.child = child()
    }

    public override func drawComponent() {

        if let color = self.activeColor {
            ImGuiWrapper.pushStyleColor(GuiColorProperty.headerActive.rawValue, colorRef: color.cgColor)
        }

        if let color = self.hoveredColor {
            ImGuiWrapper.pushStyleColor(GuiColorProperty.headerHovered.rawValue, colorRef: color.cgColor)
        }

        if ImGuiWrapper.treeNodeEx(self.text, flags: self.options.rawValue) {

            self.child.render()
            ImGuiWrapper.treePop()
        }

        if self.activeColor != nil {
            ImGuiWrapper.popStyleColor(1)
        }

        if self.hoveredColor != nil {
            ImGuiWrapper.popStyleColor(1)
        }
    }
}
