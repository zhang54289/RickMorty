//
//  SearchViewModel.swift
//  RickMorty
//
//  Created by Huan Zhang on 4/9/25.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var errorMessage: String?
    @Published var hasNext: Bool = false
    @Published var hasPrev: Bool = false
    @Published var searchText: String = "Rick" {
        didSet {
            errorMessage = nil
            pageCount = 1
            debounceSearch()
        }
    }

    init() {
        errorMessage = nil
        pageCount = 1
        debounceSearch()
    }
    
    private let apiURLString = "https://rickandmortyapi.com/api/character/"

    private var debounceTimer: Timer?
    private var pageCount: Int = 1
    
    private func debounceSearch() {
        debounceTimer?.invalidate()

        guard !searchText.isEmpty else {
            self.characters = []
            return
        }

        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.fetchCharacters(name: self?.searchText ?? "")
        }
    }

    func fetchCharacters(name: String, page: Int = 1) {
        let urlString = "\(apiURLString)?name=\(name)&page=\(page)"
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(CharacterResponseModel.self, from: data)
                    self?.characters = decoded.results
                    self?.hasNext = decoded.info.next != nil
                    self?.hasPrev = decoded.info.prev != nil
                } catch {
                    self?.errorMessage = "Decoding failed: \(error.localizedDescription)"
                }
            }
        }

        task.resume()
    }
    
    func loadNextPage() {
        pageCount += 1
        fetchCharacters(name: searchText, page: pageCount)
    }

    func loadPrevPage() {
        guard pageCount > 1 else { return }
        pageCount -= 1
        fetchCharacters(name: searchText, page: pageCount)
    }
}
