import SwiftUI

public protocol Compositional: View where Body: Compositional { }

public struct Section: Compositional {
    public init<C: Compositional>(@CompositionalElementBuilder _ content: () -> C) { }
    public var body: Never { fatalError() }
}

public struct ForEach: Compositional {
    public init<C: View>(@ViewBuilder _ content: () -> C) { }
    public var body: Never { fatalError() }
}

public struct CompositionalList: View {
    public init<C: Compositional>(@CompositionalSectionBuilder _ sections: () -> C) { }
    public var body: some View {
        Text("Compositional List")
    }
}

@resultBuilder public struct CompositionalSectionBuilder {
    public static func buildBlock() -> EmptyView { .init() }
    public static func buildBlock<C: Compositional>(_ components: C...) -> C { fatalError() }
}

@resultBuilder public struct CompositionalElementBuilder {
    public static func buildBlock() -> EmptyView { .init() }
    public static func buildBlock<C: Compositional>(_ components: C...) -> C { fatalError() }
}

public struct EmptyView: Compositional {
    public var body: Never { fatalError() }
}

extension Never: Compositional {
    public var body: Never { fatalError() }
}

