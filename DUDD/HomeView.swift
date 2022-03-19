//
//  HomeView.swift
//  DUDD
//
//  Created by Aayush Pokharel on 2022-03-18.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var streamsVM: StreamsViewModel

    @Environment(\.openURL) var openURL
    let columns = [
        GridItem(.adaptive(minimum: 200)),
    ]
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                if searchResults.count == 0 {
                    ProgressView()
                }
                LazyVGrid(columns: columns) {
                    ForEach(searchResults, id: \.self) { stream in
                        SingleStreamView(stream: stream)
                            .padding(2)
                            .contextMenu(menuItems: {
                                VStack {
                                    Button {
                                        UIPasteboard.general.string = stream.url
                                    } label: {
                                        Label("Copy URL", systemImage: "doc.on.doc")
                                    }
                                    Button {
                                        openURL(URL(string: stream.url)!)
                                    } label: {
                                        Label("Open URL", systemImage: "play.fill")
                                    }
                                }
                            })
                            .onTapGesture(count: 2) {
                                openURL(URL(string: stream.url)!)
                            }
                    }
                }
                .padding(.horizontal)
            }
            .searchable(text: $streamsVM.searchText)
            .background(Color("background-color"))
            .navigationTitle("DUDD:")
        }
        .navigationViewStyle(.stack)
    }

    var searchResults: [StreamModel] {
        if streamsVM.searchText.isEmpty {
            return streamsVM.streams
        } else {
            return streamsVM.streams.filter { $0.channel!.lowercased().contains(streamsVM.searchText.lowercased()) }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(StreamsViewModel())
    }
}
