//
//  TranslationAPIModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 27.03.2024.
//

import Foundation

struct TranslationResponse: Codable {
    let data: TranslationData
}

struct TranslationData: Codable {
    let translations: Translations
}

struct Translations: Codable {
    let translatedText: String
}
