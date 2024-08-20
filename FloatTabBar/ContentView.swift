//
//  ContentView.swift
//  FloatTabBar
//
//  Created by Benji Loya on 20.08.2024.
//

import SwiftUI

struct ContentView: View {
    /// View Properties
    @State private var activeTab: TabModel = .home
    @State private var isTabBarHidden: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                if #available(iOS 18, *) {
                    TabView(selection: $activeTab) {
                        //                Tab.init(value: .home) {
                        //                    HomeView()
                        //                        .toolbarVisibility(.hidden, for: .tabBar)
                        //                }
                        //
                        //                Tab.init(value: .search) {
                        //                    Text("Search")
                        //                        .toolbarVisibility(.hidden, for: .tabBar)
                        //                }
                        //
                        //                Tab.init(value: .notification) {
                        //                    Text("Notification")
                        //                        .toolbarVisibility(.hidden, for: .tabBar)
                        //                }
                        //
                        //                Tab.init(value: .settings) {
                        //                    Text("Settings")
                        //                        .toolbarVisibility(.hidden, for: .tabBar)
                        //                }
                    }
                } else {
                    TabView(selection: $activeTab) {
                        HomeView()
                            .tag(TabModel.home)
                            .background {
                                if !isTabBarHidden {
                                    HideTabBar {
                                        isTabBarHidden = true
                                    }
                                }
                            }
                        
                        Text("Search")
                            .tag(TabModel.search)
                        
                        Text("Notifications")
                            .tag(TabModel.notifications)
                        
                        Text("Settings")
                            .tag(TabModel.profile)
                        
                    }
                    
                }
            }
            
            CustomTabBar(activeTab: $activeTab)
            
        }
    }
}

struct HomeView: View {
    var body: some View {
        Text("Home")
            .font(.title.bold())
    }
}

struct HideTabBar: UIViewRepresentable {
    var result: () -> ()
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        DispatchQueue.main.async {
            if let tabController = view.tabController {
                tabController.tabBar.isHidden = true
                result()
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

extension UIView {
    var tabController: UITabBarController? {
        if let controller = sequence(first: self, next: {
            $0.next
        }).first(where: { $0 is UITabBarController }) as? UITabBarController {
            return controller
        }
        
        return nil
    }
}

#Preview {
    ContentView()
}






/*
 import SwiftUI

 struct ContentView: View {
     /// View Properties
     @State private var activeTab: TabModel = .home
     
     var body: some View {
         if #available(iOS 18, *) {
             TabView(selection: $activeTab) {
                 //                Tab.init(value: .home) {
                 //                    Text("Home")
                 //                        .toolbarVisibility(.hidden, for: .tabBar)
                 //                }
                 //
                 //                Tab.init(value: .search) {
                 //                    Text("Search")
                 //                        .toolbarVisibility(.hidden, for: .tabBar)
                 //                }
                 //
                 //                Tab.init(value: .notification) {
                 //                    Text("Notification")
                 //                        .toolbarVisibility(.hidden, for: .tabBar)
                 //                }
                 //
                 //                Tab.init(value: .settings) {
                 //                    Text("Settings")
                 //                        .toolbarVisibility(.hidden, for: .tabBar)
                 //                }
             }
         } else {
             /*
              as you can see, this is the issue im referring to. i believe it has existed since ios 17.3. to completely remove the tabbar in ios 17 versions< we must first locate the relevant UITabbarController, and the hide the tabbar completely
              */
             TabView(selection: $activeTab) {
                 Text("Home")
                     .tag(TabModel.home)
                     .onAppear {
                         hideTabBar()
                     }
                 
                 Text("Search")
                     .tag(TabModel.search)
                     .onAppear {
                         hideTabBar()
                     }
                 
                 Text("Notifications")
                     .tag(TabModel.notifications)
                     .onAppear {
                         hideTabBar()
                     }
                 
                 Text("Settings")
                     .tag(TabModel.settings)
                     .onAppear {
                         hideTabBar()
                     }
             }
             .overlay {
                 Button {
                     activeTab = activeTab == .home ? .search : .home
                 } label: {
                     Text("Switch Tabs")
                 }
             }
         }
     }
     
     private func hideTabBar() {
         DispatchQueue.main.async {
             if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let tabBarController = windowScene.windows.first?.rootViewController as? UITabBarController {
                 tabBarController.tabBar.isHidden = true
             }
         }
     }
     
 }

 #Preview {
     ContentView()
 }

 */
