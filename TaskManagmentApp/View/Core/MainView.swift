//
//  MainView.swift
//  TaskManagmentApp
//
//  Created by khalid doncic on 18/07/2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var userManager = UserManager()
    var body: some View {
        
            if  userManager.currentUser?.isFirstTime != nil {
           
                HomeView_v2()
                 
                }
                else {
                   
                    OnBoardingView()
                }
            
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
