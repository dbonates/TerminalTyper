//
//  NSView+.swift
//  Terminal Typer
//
//  Created by Daniel Bonates on 19/03/2018.
//  Copyright © 2018 Daniel Bonates. All rights reserved.
//

import Cocoa

extension NSView {

    // unsafeDowncast still performs a check in debug builds
    class func baby<T>() -> T where T: NSView {
        let v = T(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }


    func fillParent(_ constant: CGFloat = 0, considerSafeMargins: Bool = false) {

        translatesAutoresizingMaskIntoConstraints = false
        guard let sv = superview else {
            return
        }

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: sv.topAnchor, constant: constant),
            leftAnchor.constraint(equalTo: sv.leftAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: sv.bottomAnchor, constant: -constant),
            rightAnchor.constraint(equalTo: sv.rightAnchor, constant: -constant)
            ])
    }

    func anchorOnTop() {
        guard let sv = superview else { return }
        let constant: CGFloat = 20
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: sv.topAnchor, constant: constant),
            self.leftAnchor.constraint(equalTo: sv.leftAnchor, constant: constant),
            self.rightAnchor.constraint(equalTo: sv.rightAnchor, constant: -constant),
            self.heightAnchor.constraint(equalToConstant: self.bounds.height)
            ])
    }

    func anchorBelow(_ referenceView: NSView, constant: CGFloat = 20) {
        guard let sv = superview else { return }
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: referenceView.bottomAnchor, constant: constant),
            self.leftAnchor.constraint(equalTo: sv.leftAnchor, constant: constant),
            self.rightAnchor.constraint(equalTo: sv.rightAnchor, constant: -constant),
            self.heightAnchor.constraint(equalToConstant: self.bounds.height)
            ])
    }

    func anchorBelow(_ referenceView: NSView, topConstant: CGFloat = 20, margin: CGFloat = 20) {
        guard let sv = superview else { return }
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: referenceView.bottomAnchor, constant: topConstant),
            self.leftAnchor.constraint(equalTo: sv.leftAnchor, constant: margin),
            self.rightAnchor.constraint(equalTo: sv.rightAnchor, constant: -margin),
            self.heightAnchor.constraint(equalToConstant: self.bounds.height)
            ])
    }

    func anchorBelow(_ referenceView: NSView, topConstant: CGFloat = 20, margin: CGFloat = 20, fixedHeight: CGFloat) {
        guard let sv = superview else { return }
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: referenceView.bottomAnchor, constant: topConstant),
            self.leftAnchor.constraint(equalTo: sv.leftAnchor, constant: margin),
            self.rightAnchor.constraint(equalTo: sv.rightAnchor, constant: -margin),
            self.heightAnchor.constraint(equalToConstant: fixedHeight)
            ])
    }
}
