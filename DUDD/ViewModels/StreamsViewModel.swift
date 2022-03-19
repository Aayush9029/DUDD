//
//  StreamsViewModel.swift
//  DUDD
//
//  Created by Aayush Pokharel on 2022-03-18.
//

import SwiftUI

class StreamsViewModel: ObservableObject {
    @Published var streams: [StreamModel] = []
    @Published var searchText: String = ""
    init() {
        print("Starting fetch")
        Task {
            do {
                try await fetchStreams()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func fetchStreams() async throws {
        guard let url = URL(string: Constant.streamsUrl) else {
            throw StreamsFetchError.invalidURLError
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        print(response)
        if let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                do {
                    let result = try JSONDecoder().decode([StreamModel].self, from: data)
                    DispatchQueue.main.async {
                        for res in result {
                            if res.channel != nil, res.url.split(separator: ".").last == "m3u8" {
                                self.streams.append(res)
                            }
                        }
                    }
                } catch {
                    print("HUGE ERROR")
                    throw StreamsFetchError.invalidDataError
                }
            } else {
                throw StreamsFetchError.missingDataError
            }
        }
    }
}

enum StreamsFetchError: Error {
    case invalidURLError
    case missingDataError
    case invalidDataError
}
