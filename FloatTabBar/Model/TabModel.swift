//
//  Tab.swift
//  FloatTabBar
//
//  Created by Benji Loya on 20.08.2024.
//

import SwiftUI

enum TabModel: String, CaseIterable {
    case home = "square.on.square.dashed"
    case search = "magnifyingglass"
    case notifications = "app.badge"
    case profile = "person"
    
    var title: String {
        switch self {
        case .home: "Home"
        case .search: "Search"
        case .notifications: "Notifications"
        case .profile: "Profile"
        }
    }
}
