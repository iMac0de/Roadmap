//
//  RoadmapViewModel.swift
//  Roadmap
//
//  Created by Antoine van der Lee on 19/02/2023.
//

import Foundation

@available(iOS 15, macOS 12, *)
final class RoadmapViewModel: ObservableObject {
    @Published private var features: [RoadmapFeature] = []
    @Published var searchText = ""

    var filteredFeatures: [RoadmapFeature] {
        guard !searchText.isEmpty else {
            return features
        }
        return features.filter { feature in
            feature
                .localizedFeatureTitle
                .lowercased()
                .contains(searchText.lowercased())
        }
    }
    let allowSearching: Bool
    private let configuration: RoadmapConfiguration

    init(configuration: RoadmapConfiguration) {
        self.configuration = configuration
        self.allowSearching = configuration.allowSearching
        loadFeatures(roadmapJSONURL: configuration.roadmapJSONURL)
    }

    func loadFeatures(roadmapJSONURL: URL) {
        Task { @MainActor in
            if configuration.shuffledOrder {
                self.features = await FeaturesFetcher(featureJSONURL: roadmapJSONURL).fetch().shuffled()
            } else {
                self.features = await FeaturesFetcher(featureJSONURL: roadmapJSONURL).fetch()
            }
        }
    }

    func featureViewModel(for feature: RoadmapFeature) -> RoadmapFeatureViewModel {
        .init(feature: feature, configuration: configuration)
    }
}
