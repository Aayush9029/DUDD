//
//  SingleStreamView.swift
//  DUDD
//
//  Created by Aayush Pokharel on 2022-03-18.
//

import SwiftUI

// TODO: - Refactor small UI Elements like Flag and Resolution and UI
struct SingleStreamView: View {
    let stream: StreamModel
    var body: some View {
        Group {
            VStack {
                HStack {
                    Text(StreamModel.getCountryFlag(stream.channel))
                        .padding(6)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())

                    Text(StreamModel.getChannel(stream.channel))
                        .bold()
                        .lineLimit(1)
                    Spacer()
                }.font(.title3)
                HStack {
                    Group {
                        StreamStatusView(stream: stream)
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Text(StreamModel.getResolution(stream.width, stream.height))
                            .bold()
                            .font(.caption2)
                        Spacer()
                    }
                    .padding(4)
                    .background(.gray.opacity(0.1))
                    .overlay(RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray, lineWidth: 1.6)
                    )
                }
            }
        }
        .padding()
        .background(.ultraThickMaterial)
        .overlay(RoundedRectangle(cornerRadius: 16)
            .stroke(stream.getColor(), lineWidth: 4)
            .shadow(color: stream.getColor(), radius: 100, x: 0, y: 0)
        )
        .cornerRadius(16)
    }
}

// MARK: - StreamStatusView

struct StreamStatusView: View {
    let stream: StreamModel

    var body: some View {
        HStack {
            Spacer()
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(stream.getColor())
            Text(stream.status.rawValue.uppercased())
                .bold()
                .foregroundColor(stream.getColor())
                .saturation(0.20)
                .brightness(0.25)
                .lineLimit(1)
            Spacer()
        }
        .font(.caption2)
        .padding(4)
        .background(stream.getColor().opacity(0.1))
        .overlay(RoundedRectangle(cornerRadius: 16)
            .stroke(stream.getColor().opacity(0.75), lineWidth: 1.6)
        )
    }
}

struct SingleStreamView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("background-color")
                .ignoresSafeArea()
            SingleStreamView(stream: StreamModel.exampleStream)
                .preferredColorScheme(.dark)
        }
    }
}
