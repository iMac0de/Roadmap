//
//  RoadmapView.swift
//  Roadmap
//
//  Created by Antoine van der Lee on 19/02/2023.
//

import SwiftUI

@available(iOS 15, macOS 12, *)
public struct RoadmapView<Header: View, Footer: View>: View {
    @StateObject var viewModel: RoadmapViewModel
    let header: Header
    let footer: Footer
    
    public var body: some View {
            featuresList
                .scrollContentHidden()
                .listStyle(.plain)
                .conditionalSearchable(if: viewModel.allowSearching, text: $viewModel.searchText)
    }
    
    var featuresList: some View {
        List {
            header
            ForEach(viewModel.filteredFeatures) { feature in
                RoadmapFeatureView(viewModel: viewModel.featureViewModel(for: feature))
                    .macOSListRowSeparatorHidden()
                    .listRowBackground(Color.clear)
            }
            footer
        }
    }
}

@available(iOS 15, macOS 12, *)
public extension RoadmapView where Header == EmptyView, Footer == EmptyView {
    init(configuration: RoadmapConfiguration) {
        self.init(viewModel: .init(configuration: configuration), header: EmptyView(), footer: EmptyView())
    }
}

@available(iOS 15, macOS 12, *)
public extension RoadmapView where Header: View, Footer == EmptyView {
    init(configuration: RoadmapConfiguration, @ViewBuilder header: () -> Header) {
        self.init(viewModel: .init(configuration: configuration), header: header(), footer: EmptyView())
    }
}

@available(iOS 15, macOS 12, *)
public extension RoadmapView where Header == EmptyView, Footer: View {
    init(configuration: RoadmapConfiguration, @ViewBuilder footer: () -> Footer) {
        self.init(viewModel: .init(configuration: configuration), header: EmptyView(), footer: footer())
    }
}

@available(iOS 15, macOS 12, *)
public extension RoadmapView where Header: View, Footer: View {
    init(configuration: RoadmapConfiguration, @ViewBuilder header: () -> Header, @ViewBuilder footer: () -> Footer) {
        self.init(viewModel: .init(configuration: configuration), header: header(), footer: footer())
    }
}

@available(iOS 15, macOS 12, *)
struct RoadmapView_Previews: PreviewProvider {
    static var previews: some View {
        RoadmapView(configuration: .sample())
    }
}
