//
//  HomeView.swift
//  TaskManagmentApp
//
//  Created by khalid doncic on 20/07/2023.
//

import SwiftUI

struct HomeView_v2: View {
    let tasks = ["Make UI/UX", "Record a video", "Edit View", "RUNING  for 4km", "Increase Performance", "Make UI/UX", "Record a video", "Edit View", "RUNING  for 4km", "Increase Performance"]

    @State private var isShowing: Bool = false
    @State private var isShowingAllTasksView: Bool = false
    @State var isCompleted: Bool = false
    @EnvironmentObject private var vm: TaskManager
    var body: some View {
        
        NavigationStack {
            ZStack {
             Color("background_v2")
                    .ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack  {
                        headerView()
                        HStack {
                            staticsView()
                            
                            tasksWatchCard()
                      
                        }
                        
                        ProgressCircleView(precent: vm.getPercent())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top, .leading])
                        
                        
                        titleHeaderView(title: "OnGoing",showSeeMoreButton: true)
                        
                        ForEach(vm.getInCompletedTask(), id: \.self) { task in
                            homeTasksView(task: task)
                        }

                  RoundedRectangle(cornerRadius: 22)
                            .fill(.gray)
                            .frame(width: 300,height: 5)
                            .padding([.top, .bottom])
                        
                        titleHeaderView(title: "Completed" ,showSeeMoreButton: false)
                        
                        ForEach(vm.getCompletedTask(), id: \.self) { task in
                            homeTasksView(task: task)
                        }
                    }
                    
                }
            }
         
        } .fullScreenCover(isPresented: $isShowing) {
            CalendarTasksView_v2()
        }
        .fullScreenCover(isPresented: $isShowingAllTasksView){
            AllTasksView()
        }
     
        
    }
     
    private func greting() -> String{
        let hour = Calendar.current.component(.hour, from: Date())
        if 6..<12 ~= hour {
                 return "   Good\nMorning"
             } else {
                 return "   Good\nEvening"
             }
    }
    
    @ViewBuilder
    private func headerView() -> some View{
        HStack(spacing: 60) {
            Text(greting())
                .font(.system(size: 25, design: .serif))
            
                .foregroundColor(.gray)
           
            
      Spacer()
            
            Button {
                isShowing.toggle()
            } label: {
                Image(systemName: "calendar")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
                    .padding(15)
                    .background(Color.white.cornerRadius(15))
                    .clipShape(Circle())
            }

        } .padding(.horizontal)
    }
    
    @ViewBuilder
    private func tasksWatchCard() -> some View {
        VStack {
            VStack {
                Text("Today's Task")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 15)
                    .padding(.leading)
            } .frame(maxWidth: .infinity,alignment: .leading)
           
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVStack(spacing: 15) {
                    ForEach(vm.getTasksForToday(), id: \.self) { task in
                        HStack(spacing: 0) {
                          
                            Image(systemName: task.status ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.white)
                              
                             
                
                            Text(task.title ?? "")
                                .font(.system(size: 12))
                                .lineLimit(3)
                            .foregroundColor(.white)
                            .padding(.leading)
                            .strikethrough(task.status, pattern: .solid, color: .black)
                            Spacer()
                            
                        } .padding(3)
                            
                    }
                }
            }
            .padding(7)
        }
      
        .frame(minWidth: 190,maxHeight: 300)
        .background(Color("Orange").cornerRadius(30))
        
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding([.trailing,.top])
    }
    @ViewBuilder
    private func titleHeaderView(title: String,showSeeMoreButton: Bool = false) -> some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
            Spacer()
            if showSeeMoreButton {
                Button {
                    isShowingAllTasksView.toggle()
                } label: {
                    Text("See All tasks")
                        .foregroundColor(.black)
                        .bold()
                    
                        .padding()
                        .background(Color.white)
                        .shadow(color: .orange,radius: 10, x: 0, y: 20)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                }
            }
        } .padding(.leading)
    }
    
    
    @ViewBuilder
    private func staticsView() -> some View {
        VStack {
            VStack {
                HStack {
                    Text("Your Achivments")
                    
                        .overlay(
                            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
                                .mask(Text("Your Achivments"))
                        )
                  
                        .font(.system(size: 16))
                        .bold()
                        .fixedSize()
                        .padding(.top, 15)
                        .padding(.leading, 1)
                    
                    Text("📊")
                        .font(.system(size: 16))
                        .padding(.top)
                        
                }
               
            } .frame(maxWidth: .infinity,alignment: .leading)
           
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVStack(spacing: 15) {
                    ForEach(vm.acivments, id: \.self) { achivemnt in
                        HStack(spacing: 0) {
                          
                            Image(systemName: vm.completedAchievements.contains(achivemnt) ? "checkmark.circle": "circle")
                                .foregroundColor(.black)
                                .font(.system(size: 10))
                             
                
                                Text(achivemnt)
                            .foregroundColor(.black)
                            .padding(.leading)
                            .font(.system(size: 10))
                            .bold()
                            .lineLimit(2)
                            .strikethrough(vm.completedAchievements.contains(achivemnt), pattern: .solid, color: .black)
                   
                            Spacer()
                            
                        }
                         
                    }
                }
            }
            .padding(7)
        }
      
        .frame(maxWidth: 180,maxHeight: 250)
        .background(Color.white.cornerRadius(30))
        
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding([.trailing,.top])
    }
    @ViewBuilder
    private func ProgressCircleView(precent: Int) -> some View {
        
           let circleWidth: CGFloat = 15
           
       
               HStack {
                  
                   VStack(spacing: 20) {
                       Text("Daily Task")
                           .font(.title2)
                           .bold()
                           .foregroundColor(.white)
                       
                       Text("\(vm.getCompletedTask().count)/\(vm.getTasksForToday().count) done")
                           .font(.system(size: 20))
                           .bold()
                           .foregroundColor(.gray)
                   }
                   Spacer()
                  
                   ZStack
                   {
                       ZStack {
                           Circle()
                               .stroke(lineWidth: circleWidth)
                               .opacity(0.3)
                               .foregroundColor(Color.white)
                           
                           Circle()
                               .trim(from: 0.0, to: CGFloat(precent) / 100)
                               .stroke(
                                style: StrokeStyle(lineWidth: circleWidth, lineCap: .round, lineJoin: .round)
                               )
                               .fill(
                                .white                   )
                               .rotationEffect(Angle(degrees: 270.0))
                       }
                       
                   }
              
                   .frame(width: 60, height: 60)

                  
                  
                   
                 
               }   .padding()
                   .padding(.horizontal)
               .frame(maxWidth: 300)
           
               .background(Color.black)
               .clipShape(RoundedRectangle(cornerRadius: 30))
           
        
    }
    
  
    
    
    @ViewBuilder
    private func homeTasksView(task: TaskModel ) -> some View {
        VStack {
 
           
                HStack {
                    Text(task.title ?? "")
                        .font(.title2)
                    .foregroundColor(.black)
                    Spacer()
                    Button {
                        withAnimation(.spring(response: 0.7, dampingFraction: 0.4 ,blendDuration: 0.7)) {
                            vm.makeTaskCompleted(task: task)
                        }
                    } label: {
                        
                        Image(systemName: task.status ? "checkmark.circle.fill"  : "circle")
                            .font(.system(size: 35))
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .frame(width: 370, height: 100)
                .background(Color.white.cornerRadius(30))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(.top)
            
          
        }
    }
     
    
}
 
struct HomeView_v2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView_v2()
            .environmentObject(TaskManager())
    }
}
 
