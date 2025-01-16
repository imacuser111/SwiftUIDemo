import GRDBQuery
import SwiftUI

// MARK: - Give SwiftUI access to the player repository

// Define a new environment key that grants access to a `PlayerRepository`.
//
// The technique is documented at
// <https://developer.apple.com/documentation/swiftui/environmentkey>.
private struct GRDBManagerKey: EnvironmentKey {
    /// The default appDatabase is an empty in-memory repository.
    static let defaultValue = GRDBManager.shared
}

extension EnvironmentValues {
    fileprivate(set) var grdbManager: GRDBManager {
        get { self[GRDBManagerKey.self] }
        set { self[GRDBManagerKey.self] = newValue }
    }
}

extension View {
    /// Sets both the `playerRepository` (for writes) and `databaseContext`
    /// (for `@Query`) environment values.
    func grdbManager() -> some View {
        self
            .environment(\.grdbManager, GRDBManager.shared)
            .databaseContext(.readOnly { GRDBManager.shared.dbWriter })
    }
}
