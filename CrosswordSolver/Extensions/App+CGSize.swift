//
//  App+CGSize.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/07/29.
//

import UIKit

extension CGSize {
    static func square(of size: Int) -> CGSize {
        return CGSize(width: size, height: size)
    }
}
