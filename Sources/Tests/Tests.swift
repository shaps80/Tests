import SwiftUI

public protocol Compositional { }

public struct Section<C: Compositional & View>: Compositional {
    let content: C
    public init(@CompositionalElementBuilder _ content: () -> C) {
        self.content = content()
    }
    public var body: some Compositional & View { content }
}

extension Section: View where C: View { }

public struct ForEach<C: View>: Compositional {
    let content: C
    public init(@ViewBuilder _ content: () -> C) {
        self.content = content()
    }
    public var body: some View { content }
}

extension ForEach: View where C: View { }

public struct CompositionalList<C: Compositional & View>: View {
    let content: C
    public init(@CompositionalSectionBuilder _ sections: () -> C) {
        self.content = sections()
    }
    public var body: some View { content }
}

@resultBuilder public struct CompositionalSectionBuilder {
    public static func buildBlock() -> EmptyView { .init() }
    public static func buildBlock<C: Compositional>(_ component: C) -> C { component }
}

@resultBuilder public struct CompositionalElementBuilder {
    public static func buildBlock() -> EmptyView { .init() }
    public static func buildBlock<C: Compositional>(_ component: C) -> C { component }
}

public struct EmptyView: Compositional {
    public var body: Never { fatalError() }
}

extension Never: Compositional {
    public var body: Never { fatalError() }
}
