//
//  OnBoardingCardView.swift
//  TaskManagmentApp
//
//  Created by khalid doncic on 05/07/2023.
//

import SwiftUI


struct OnBoardingCardView: View {
    @State var  showingHomeView: Bool = false
    @Binding var isShowing: Bool
   @StateObject private var userManager = UserManager()
    var body: some View { 
        
            VStack(alignment: .leading) {
                Spacer()
                Text(NSLocalizedString("Manage\nYour", comment: ""))
                    .font(.system(size: 60, design: .rounded))
                    .bold()
                    .fixedSize()
//                    .offset(x: -30)
                    .padding(.horizontal)
                    .foregroundColor(Color("Orange").opacity(0.8))
                Text(NSLocalizedString("tasks", comment: ""))
                    .offset(x: 150, y: 40)
                    .font(.system(size: 55))
                    .foregroundColor(.gray)
                    .bold()
                
                HStack(spacing: 70) {
                    Text("Get started")
                        .foregroundColor(.black)
                        .fixedSize()
                        .font(.system(size: 45, weight: .bold, design: .serif))
                    
                    Button {
                        showingHomeView.toggle()
                        userManager.toogleUserStatus()
                      
                      
                    } label: {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color("Orange"))
                            .clipShape(Circle())
                    } .disabled(isShowing)
                        .padding([.bottom, .top])
                }
                
                
                .padding([.all, .horizontal], 1)
                
                
            }
            
            .frame(width: UIScreen.main.bounds.width - 14, height: 350)
            
            .background(Color("background_v2").opacity(0.7))
                .cornerRadius(50)
                
         .fullScreenCover(isPresented: $showingHomeView) {
            HomeView_v2()
        }
    }
    
    
    
}

struct OnBoardingCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingCardView(isShowing: .constant(true))
    }
}
