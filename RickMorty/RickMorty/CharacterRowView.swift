//
//  CharacterRowView.swift
//  RickMorty
//
//  Created by Huan Zhang on 4/9/25.
//

import SwiftUI

struct CharacterRowView: View {
    let character: Character

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            .cornerRadius(5)

            VStack(alignment: .leading) {
                Text(character.name).font(.headline)
                Text(character.species).font(.subheadline)
            }
        }
    }
}
