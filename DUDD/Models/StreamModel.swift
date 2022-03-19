//
//  StreamModel.swift
//  DUDD
//
//  Created by Aayush Pokharel on 2022-03-18.
//

import SwiftUI

// MARK: StreamModel

struct StreamModel: Codable, Hashable {
    let channel: String?
    let url: String
    let httpReferrer: String? = ""
    let userAgent: String? = ""
    let status: StreamStatus
    let width, height, bitrate: Int?

    enum CodingKeys: String, CodingKey {
        case channel, url
        case httpReferrer = "http_referrer"
        case userAgent = "user_agent"
        case status, width, height, bitrate
    }

    static func getChannel(_ channel: String?) -> String {
        return String(channel?.split(separator: ".").first ?? "Unknwown Channel")
    }

    static func getCountryCode(_ channel: String?) -> String {
        return String(channel?.split(separator: ".").last ?? "NaN")
    }

    static func getCountryFlag(_ channel: String?) -> String {
        return countriesData[getCountryCode(channel)]?.last ?? "◼️"
    }

    static func getResolution(_ width: Int?, _ height: Int?) -> String {
        return "\(width ?? 0)x\(height ?? 0)"
    }

    func getColor() -> Color {
        switch status {
        case .blocked:
            return Color.orange
        case .error:
            return Color.red
        case .online:
            return Color.green
        case .timeout:
            return Color.gray
        }
    }

    static let exampleStream = StreamModel(channel: "1001Noites.br", url: "https://cdn.jmvstream.com/w/LVW-8155/ngrp:LVW8155_41E1ciuCvO_all/playlist.m3u8", status: .online, width: 640, height: 360, bitrate: 1_066_072)
}

// MARK: StreamStatus

enum StreamStatus: String, Codable {
    case blocked
    case error
    case online
    case timeout
}
