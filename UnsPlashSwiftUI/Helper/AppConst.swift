//
//  AppConst.swift
//  UnsPlashSwiftUI
//
//  Created by Girish Parate on 01/05/22.
//

import Foundation
struct AppConst {
    static let baseurl = "https://api.unsplash.com/"
    static let photoUrl = "photos"
    static let topics = "topics"
    static let clinetid = "jRBzm2zUw2eoIPSHZxLvY_hnSh0P8J91P2THDay4y8w"
    static let search = "search/photos"
}

struct AppKeyBoardType {
    static let `default` = 0 // Default type for the current input method.

    static let asciiCapable = 1 // Displays a keyboard which can enter ASCII characters

    static let numbersAndPunctuation = 2 // Numbers and assorted punctuation.

    static let URL = 3 // A type optimized for URL entry (shows . / .com prominently).

    static let numberPad = 4 // A number pad with locale-appropriate digits (0-9, ۰-۹, ०-९, etc.). Suitable for PIN entry.

    static let phonePad = 5 // A phone pad (1-9, *, 0, #, with letters under the numbers).

    static let namePhonePad = 6 // A type optimized for entering a person's name or phone number.

    static let emailAddress = 7 // A type optimized for multiple email address entry (shows space @ . prominently).

    static let decimalPad = 8 // A number pad with a decimal point.

    static let twitter = 9 // A type optimized for twitter text entry (easy access to @ #)

    static let webSearch = 10 // A default keyboard type with URL-oriented addition (shows space . prominently).

    static let asciiCapableNumberPad = 11 // A number pad (0-9) that will always be ASCII digits.
}

