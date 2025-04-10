//
//  SearchView.swift
//  RickMorty
//
//  Created by Huan Zhang on 4/9/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("SEARCH")
                    TextField("Search name", text: $viewModel.searchText)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding()
                        .onChange(of: viewModel.searchText) { }
                }
                .padding(.horizontal, 20)

                if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                        .padding(.horizontal, 20)
                } else {
                    List(viewModel.characters) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            CharacterRowView(character: character)
                        }
                    }
                }
                
                HStack {
                    if viewModel.hasPrev {
                        Button("Prev") {
                            viewModel.loadPrevPage()
                        }
                        .padding()
                    }

                    Spacer()

                    if viewModel.hasNext {
                        Button("Next") {
                            viewModel.loadNextPage()
                        }
                        .padding()
                    }
                }
                .padding(.horizontal)

            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
