//
//  MTTypeSetter.swift
//  iosMathExample
//
//  Created by 藤井陽介 on 2018/10/03.
//

import Foundation



// MARK: - Inter Element Spacing

enum MTInterElementSpaceType: Int {
    case invalid = -1
    case none = 0
    case thin
    case nsThin
    case nsMedium
    case nsThick
}

let interElementSpaceArray: [MTInterElementSpaceType]  = [

    // ordinary operator binary relation open close punct fraction
    [.none, .thin, .nsMedium, .nsThick, .none, .none, .none, .nsThin],  // ordinary
    [.thin, .thin, .invalid, .nsThick, .none, .none, .none, .nsThin],    // binary
    [.nsThick, .nsThick, .invalid, .none, .nsThick, .none, .none, .nsThick], // relation
    [.none, .none, .invalid, .none, .none, .none, .none, .none], // open
    [.none, .thin, .nsMedium, .nsThick, .none, .none, .none, .nsThin],  // close
    [.nsThin, .nsThin, .invalid, .nsThin, .nsThin, .nsThin, .nsThin, .nsThin],  // punct
    [.nsThin, .thin, .nsMedium, .nsThick, .nsThin, .none, .nsThin, .nsThin],    // fraction
    [.nsMedium, .nsThin, .nsMedium, .nsThick, .none, .none, .none, .nsThin] // radical

]

func getInterElementSpaceArrayIndex(for type: MTMathAtomType, row: Bool) -> UInt {

    switch type {
    case .color, .ordinary, .placeholder:
        return 0
    case .largeOperator:
        return 1
    case .binaryOperator:
        return 2
    case .relation:
        return 3
    case .open:
        return 4
    case .close:
        return 5
    case .punctuation:
        return 6
    case .fraction, .inner:
        return 7
    case .radical:
        if row {
            return 8
        } else {
            assert(false, "Interelement space undefined for radical on the right. Treat radical as ordinary.")
            return -1
        }
    default:
        assert(false, "Interelement space undefined for type \(String(describing: type))")
        return -1
    }
}

// MARK: - Font styles

// Alphabet, Number or Greek Character
let unicodeGreekLowerStart: UniChar = 0x03B1
let unicodeGreekLowerEnd: UniChar = 0x03C9
let unicodeGreekCapitalStart: UniChar = 0x0391
let unicodeGreekCapitalEnd: UniChar = 0x03A9

let isLowerEn = { (ch: UniChar) -> Bool in return ch >= "a" && ch <= "z" }
let isUpperEn = { (ch: UniChar) -> Bool in return ch >= "A" && ch <= "Z" }
let isNumber = { (ch: UniChar) -> Bool in return ch >= "0" && ch <= "9" }
let isLowerGreek = { (ch: UniChar) -> Bool in return ch >= unicodeGreekLowerStart && ch <= unicodeGreekLowerEnd }
let isCapitalGreek = { (ch: UniChar) -> Bool in return ch >= unicodeGreekCapitalStart && ch <= unicodeGreekCapitalEnd }

func greekSymbolOrder(_ ch: UniChar) -> Int? {
    let greekSymbols: [UniChar] = [0x03F5, 0x03D1, 0x03F0, 0x03D5, 0x03F1, 0x03D6]

    return greekSymbols.firstIndex(of: ch)
}

let isGreekSymbol = { (ch: UniChar) -> Bool in greekSymbolOrder(ch) != nil }

// Italic style
let unicodePlanksConstant: UniChar = 0x210e
let unicodeMathCapitalItalicStart: UTF32Char = 0x1D434
let unicodeMathLowerItalicStart: UTF32Char = 0x1D44E
let unicodeGreekCapitalItalicStart: UTF32Char = 0x1D6E2
let unicodeGreekLowerItalicStart: UTF32Char = 0x1D6FC
let unicodeGreekSymbolItalicStart: UTF32Char = 0x1D716

func getItalicized(_ ch: UniChar) -> UTF32Char {

    var unicode: UTF32Char = ch
    switch ch {
    case "h":
        return unicodePlanksConstant
    }

    if isUpperEn(ch) {
        unicode = unicodeMathCapitalItalicStart + (ch - "A")
    } else if isLowerEn(ch) {
        unicode = unicodeMathLowerItalicStart + (ch - "a")
    } else if isCapitalGreek(ch) {
        unicode = unicodeGreekCapitalItalicStart + (ch - unicodeGreekCapitalStart)
    } else if isLowerGreek(ch) {
        unicode = unicodeGreekLowerItalicStart + (ch - unicodeGreekLowerStart)
    } else if isGreekSymbol(ch) {
        unicode = unicodeGreekSymbolItalicStart + (ch - greekSymbolOrder(ch)!)
    }

    return unicode
}

// Bold style

let unicodeMathCapitalBoldStart: UTF32Char = 0x1D400
let unicodeMathLowerBoldStart: UTF32Char = 0x1D41A

