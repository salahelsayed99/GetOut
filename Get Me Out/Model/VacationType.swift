//
//  VacationType.swift
//  Get Me Out
//
//  Created by Salah  on 20/07/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation

// MARK: - VacationType
struct VacationType: Codable {
    let code: Int
    let key: String
    let data: [DatumType]

    enum CodingKeys: String, CodingKey {
        case code, key
        case data = "Data"
    }
}

// MARK: - Datum
struct DatumType: Codable {
    let name: String
}
