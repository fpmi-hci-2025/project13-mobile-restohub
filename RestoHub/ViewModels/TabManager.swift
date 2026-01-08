// ViewModels/TabManager.swift
import SwiftUI
internal import Combine

class TabManager: ObservableObject {
    @Published var selectedTab = 0
    
    let tabChanged = PassthroughSubject<Int, Never>()
    
    func selectTab(_ tab: Int) {
        selectedTab = tab
        tabChanged.send(tab)
    }
}
