//
//  ContentView.swift
//  TaskManagmentApp
//
//  Created by khalid doncic on 05/07/2023.
//

import SwiftUI

struct OnBoardingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var name = ""
    @StateObject private var userManger = UserManager()
    @State var isShowing = true
    var body: some View {
       
            
            VStack{
                
        
                
                ZStack(alignment: .bottom) {
                    Color("background_v2").opacity(0.1)
                        .ignoresSafeArea()
                   
                    VStack() {
                        Spacer()
                        askNameCardView()
                            .frame(width: UIScreen.main.bounds.width - 10)
                          
                            .background()
                            .cornerRadius(20)
                     Spacer()
               
                    }
                   
                    .opacity(isShowing ? 1 : 0)
         
                    
                    OnBoardingCardView(isShowing: $isShowing)
                        .offset(y: isShowing ? 0 : -200)
                        .padding(.bottom)
                        .padding()
                        .opacity(isShowing ? 0 : 1)
                }
                
                
       
              
            }
            
           
        
          
                
               
                
                
                
            
        
        
            
    }

@ViewBuilder
    func askNameCardView() -> some View {
    
         
          
                
                 
                    VStack(spacing: 25) {
                    Text("give us the name which you love hear🥸")
                            .lineLimit(1)
                            .fixedSize()
                            .font(.system(size: 20, weight: .medium, design: .serif))
                        
                        TextField("HERE....", text: $name)
                            .font(.system(size: 20))
                                    .padding()
                                    .background(Color.orange.opacity(0.2))
                                    .cornerRadius(10)
                                    .shadow(color: .black, radius: 10, x: 0, y: 10)
                                    .padding(.horizontal, 20)
                        
                        Button {
                            userManger.saveUser(his: name)
                            withAnimation(.spring(response: 0.9, dampingFraction: 0.4, blendDuration: 0.2)) {
                                
                                
                                isShowing = false
                            }
                            dismiss()
                            
                        } label: {
                            HStack {
                            Spacer()
                                Image(systemName: "arrow.down")
                                    .foregroundColor(.white)
                                    .fixedSize()
                                    .frame(width: 40, height: 40)
                                    .background(Color.black.opacity(1))
                                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                
                            }
                        }

                    }
                    .padding()
                    .background(Color.orange.opacity(0.2))
                    
         
                    
                
            }
        

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}


