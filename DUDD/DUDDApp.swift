//
//  DUDDApp.swift
//  DUDD
//
//  Created by Aayush Pokharel on 2022-03-18.
//

import SwiftUI

@main
struct DUDDApp: App {
    @StateObject var StreamsVM = StreamsViewModel()
//    let persistenceController = PersistenceController.shared

//    ContentView()
//        .environment(\.managedObjectContext, persistenceController.container.viewContext)

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(StreamsVM)
        }
    }
}

private extension View {
    func withHostingWindow(_ callback: @escaping (UIWindow?) -> Void) -> some View {
        background(HostingWindowFinder(callback: callback))
    }
}

private struct HostingWindowFinder: UIViewRepresentable {
    var callback: (UIWindow?) -> Void

    func makeUIView(context _: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async { [weak view] in
            self.callback(view?.window)
        }
        return view
    }

    func updateUIView(_: UIView, context _: Context) {}
}
