//
//  TaskManagmentAppApp.swift
//  TaskManagmentApp
//
//  Created by khalid doncic on 05/07/2023.
//

import SwiftUI

@main
struct TaskManagmentApp: App {
    let migrator = Migrator()
    @StateObject var viewModel = TaskManager()
  
    var body: some Scene {
        WindowGroup {
           
                MainView()
                .environmentObject(viewModel)
                .environment(\.managedObjectContext, viewModel.container.viewContext)
                .colorScheme(.light)
                .preferredColorScheme(.light)
           
          
              

        }
    }
}
