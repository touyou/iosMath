//
//  MTFont+Internal.swift
//  iosMathExample
//
//  Created by 藤井陽介 on 2018/10/03.
//

import Foundation

extension MTFont {
    init(with name: String, size: CGFloat)

    private(set) var ctFont: CTFontRef
    private(set) var mathTable: MTFontMathTable

    func getGlyphName(_ glyph: CGGlyph) -> String?
    func getGlyph(with name: String) -> CGGlyph
}
