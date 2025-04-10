//
//  CharacterDetailView.swift
//  RickMorty
//
//  Created by Huan Zhang on 4/9/25.
//

import SwiftUI
import MessageUI

struct CharacterDetailView: View {
    let character: Character
    @State private var imageData: Data?
    @State private var showShareSheet = false

    var body: some View {
        let tempFileURL = URL(string: character.image)

        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(character.name)
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Button("Share") {
                        showShareSheet = true
                    }
                    .disabled(tempFileURL == nil)
                }
                .padding(.horizontal, 20)

                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }

                Group {
                    Text("Species: \(character.species)")
                    Text("Status: \(character.status)")
                    Text("Origin: \(character.origin.name)")
                    if !character.type.isEmpty {
                        Text("Type: \(character.type)")
                    }
                    if let formattedDate = formattedDate(from: character.created) {
                        Text("Created: \(formattedDate)")
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .sheet(isPresented: $showShareSheet) {
            if let fileURL = tempFileURL {
                ShareSheet(items: [fileURL])
            }
        }
    }

    private func formattedDate(from isoString: String) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = isoFormatter.date(from: isoString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .long
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return nil
    }
}

import UIKit

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
