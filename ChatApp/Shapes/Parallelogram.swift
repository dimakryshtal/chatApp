//
//  Parallelogram.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 21.03.2022.
//

import SwiftUI

struct ParallelogramShape: Shape {
    var wid: CGFloat
    
    init(width: CGFloat) {
        wid = width
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + wid))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - wid))

        
        return path
    }
}

