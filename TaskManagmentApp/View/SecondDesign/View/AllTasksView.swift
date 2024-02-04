//
//  AllTasksView.swift
//  TaskManagmentApp
//
//  Created by Khalid R on 23/07/1445 AH.
//

import SwiftUI

struct AllTasksView: View {
    @EnvironmentObject private var taskViewModel: TaskManager
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
//    @State private var currentMonth = Date()
    @State private var isShowingCalendar: Bool = false
    @State private var isShowingAddTaskView: Bool = false
    @State var dateToString = Date().toString("MMMM")
    @Environment (\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Gray_V2")
              
                VStack {
                
                        MonthsRow()
//                        .offset(y: -50)
                    
                    if (!taskViewModel.tasks.isEmpty) {
                        CardTaskView()
                    } else {
                        VStack {
                            
                            Text("No Tasks this month !!")
                            ProgressView()
                                .progressViewStyle(.circular)
                                
                             
                        }
                        .frame(width: UIScreen.main.bounds.width - 25, height: 300)
                        .background(.white)
                        .cornerRadius(30)
                            
                    }
           
                    
                    Button(action: {
                        isShowingAddTaskView.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
                            .background(Color("Orange"))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    })
                    
                    .offset(y: 70)
                
   
                }
                
                .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height / 1.5)
                
         
           
                
            } .ignoresSafeArea()
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                                .padding(3)
                                .overlay {
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(.gray)
                                    
                                }
                            
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        
                        Button {
                            isShowingCalendar.toggle()
                        } label: {
                            Image(systemName: "calendar")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .padding(15)
                                .background(Color("Orange").opacity(0.6))
                                .clipShape(Circle())
                        }

                  
                    }
                })
        } .fullScreenCover(isPresented: $isShowingCalendar, content: {
            CalendarTasksView_v2()
        })
        .fullScreenCover(isPresented: $isShowingAddTaskView, content: {
           AddNewTaskView()
        })
    }
    
    @ViewBuilder
    private func MonthsRow() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            
            ScrollViewReader { value in
                HStack {
                    ForEach(months, id: \.self) { date in
                        VStack {
                            Text(date.prefix(3))
                                .fixedSize()
                                .foregroundColor(.white)
                            
                            
                           
                            
                        } .onTapGesture {
                            withAnimation(.spring()) {
                              
                                dateToString = date
                            }
                        }
                        
                        .frame(width: 60, height: 80)
                        .background(dateToString == date  ? Color("Orange") : Color(red: 0.2, green: 0.2, blue: 0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 20)) // make the background a capsule
                        .padding(.horizontal, 5) // Add horizontal spacing between capsules
                        
                    }
                    
                }
                .onChange(of: dateToString) { newValue in
                    withAnimation(.spring()) {
                        value.scrollTo(dateToString, anchor: .trailing)
                    }
                }
                .onAppear {
                    
                    value.scrollTo(dateToString)
                    
                }
            }
            
            
            
            
            
            
            
        }
    }
    
    @ViewBuilder
    func CardTaskView() -> some View {
     
            ScrollView{
                
                ForEach(taskViewModel.getTasksForMonthNamed(monthName: dateToString), id: \.self) { task in
                    
                    
                    VStack(alignment:.leading) {
                        HStack {
                            Image(systemName:task.status ?  "circle" : "checkmark")
                            Text(task.title ?? "")
                                .foregroundStyle(.black)
                                .padding()
                            
                            
                        }
                        Divider()
                        
                        
                    }
                }
                
            }
           
            .frame(maxWidth: UIScreen.main.bounds.width - 25, alignment: .leading)
            .background(.white)
            .cornerRadius(30)
    }
    
}

#Preview {
    AllTasksView()
        .environmentObject(TaskManager())
        
}


