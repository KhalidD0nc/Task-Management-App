////
////  CalendarTasksView.swift
////  TaskManagmentApp
////
////  Created by khalid doncic on 05/07/2023.
////
//
//import SwiftUI
//
//struct CalendarTasksView: View {
// 
////    let tasks = ["Make UI/UX", "Record a video", "Edit View", "RUNING  for 4km", "Increase Performance", "Make UI/UX", "Record a video", "Edit View", "RUNING  for 4km", "Increase Performance"]
////
//    @State private var showingAddTaskScreenView: Bool = false
//    @EnvironmentObject private var viewModel:  TaskManager
//    @Environment(\.dismiss) var dismiss
//    var body: some View {
//        NavigationStack {
//          
//            ZStack(alignment: .top) {
//            
//                
//                VStack(alignment: .leading) {
//                  
//              headerView()
//                    
//                    ScrollView(.vertical) {
//                        tasksView()
//                    } .refreshable {
//                        viewModel.fetchTask()
//                    }
//                 
//                }
//                    
//                
//                
//               
//            }
//            
//            
//            
//            
//            .fullScreenCover(isPresented: $showingAddTaskScreenView) {
//                AddTaskView()
//            }
//        }
//        
//    }
//    @ViewBuilder
//    func headerView() -> some View {
//        VStack {
//            HStack {
//                Button {
//                    dismiss()
//                } label: {
//                    Image(systemName: "arrow.left")
//                        .foregroundColor(.black)
//                        .frame(width: 60, height: 60)
//                        .background(
//                            Color.white
//                                .cornerRadius(30)
//                        )
//                }
//                
//                .padding(.trailing)
//                Text(viewModel.getMonthAndYear())
//                    .font(.largeTitle)
//                    .fontWeight(.heavy)
//                    .foregroundColor(.white)
//                    .padding(.top)
//                
//                Button {
//                    showingAddTaskScreenView.toggle()
//                } label: {
//                    Image(systemName: "plus")
//                        .font(.system(size: 30))
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(
//                            Color.blue
//                                .clipShape(Circle())
//                        )
//                    
//                } .frame(maxWidth: .infinity, alignment: .trailing)
//            
//            }
//            daysRow()
//            
//        }   .background(Color.black)
// 
//           
//    }
//    
//    @ViewBuilder
//    func daysRow() -> some View {
//      
//           
//            Section {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    
//                    
//                    ScrollViewReader { value in
//                        HStack {
//                            ForEach(viewModel.currentWeek, id: \.self) { date in
//                                VStack {
//                                    Text(viewModel.extractDate(date: date, format: "EEE"))
//                                        .font(.subheadline)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                    
//                                    Text(viewModel.extractDate(date: date, format: "dd"))
//                                        .font(.system(size: 50, weight: .heavy))
//                                    
//                                    
//                                }
//                                .onTapGesture {
//                                    withAnimation(.spring()) {
//                                        viewModel.currentDay = date
//                                    }
//                                } .onChange(of: viewModel.currentDay, perform: { newValue in
//                                    withAnimation(.spring()) {
//                                        value.scrollTo(newValue, anchor: .none)
//                                    }
//                                    
//                                })
//                                .onAppear(perform: {
//                                    value.scrollTo(viewModel.currentDay, anchor: .trailing)
//                                    
//                                })
//                                .foregroundColor(viewModel.isToday(date: date) ? .white : .gray)
//                                .padding(.all, 5)
//                                
//                            }
//                        }
//                    }
//                }
//                
//                
//                
//                
//            
//            
//           
//                
//                
//             
//            } .background(Color.black)
//        
//    }
//    
//    
//    @ViewBuilder
//    func tasksView() -> some View {
//        LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
//            if !viewModel.getTasksForToday().isEmpty {
//                VStack {
//                    ForEach(viewModel.getTasksForToday()) { task in
//                        taskCardView(task: task)
//                    
//                        
//
//                            .padding(.vertical, 15)
//                    }
//                 
//                }  .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.vertical)
//            } else {
//                VStack {
//                    Text("No  Taks Found!!")
//                        .font(.system(size: 15))
//                        .foregroundColor(.black)
//                        .fontWeight(.light)
//                        .offset(y: 90)
//                        .padding()
//                    Spinner(lineWidth: 3, height: 80, width: 60)
//                    
//                }
//            Spacer(minLength: 200)
//            }
//                
//           
//
//        }
//
//        .background(
//            Color.white
//                .cornerRadius(30)
//        )
//      
//       
//        
//    }
//    
//    @ViewBuilder
//    func taskCardView(task: TaskModel) -> some View {
//
//
//        HStack {
//            // Line View
//           
//                
//            
//               
//                    VStack {
//                    Circle()
//                        .fill(.black)
//                        .frame(width: 15, height: 15)
//                        .background(
//                            Circle()
//                                .stroke(lineWidth: 3)
//                                .padding(-4)
//                        )
//                        .scaleEffect(1)
//                        Rectangle()
//                            .fill(.black)
//                            .frame(width: 3)
//                    } .padding(.leading)
//                   
//                
//            
//            VStack {
//                HStack {
//                    
//                    
//                    Text(task.title ?? "")
//                        .fontWeight(.semibold)
//                      
//                        .strikethrough(task.status, pattern: .solid, color: .black)
//                        .fixedSize(horizontal: false, vertical: true)
//                        .padding(2)
//                    Spacer()
//                    VStack(spacing: 10) {
//                        Text(viewModel.extractDate(date: task.date!, format: "h:mm a"))
//                            .font(.system(size: 15))
//                            .foregroundStyle(.gray)
//                        
//                        Menu {
//                            Button {
//                                
//                            } label: {
//                                Label("Edit", systemImage: "square.and.pencil")
//                            }
//                            Button(role: .destructive) {
//                                viewModel.deleteTask(task: task)
//                            } label: {
//                                Label("Delete", systemImage: "trash.fill")
//                                    
//                            }
//                        } label: {
//                            Image(systemName: "ellipsis")
//                                .foregroundColor(.black.opacity(0.7))
//                        }
//                    
//                      
//                            
//                    }
//                        
//                }
//                .padding()
//                .background   {
//                  
//                    
//                }
//                
//              
//            }
//            .padding(.horizontal)
//            
//            
//          
//            
//        }
//       
//    }
//    
//
//}
//
//struct CalendarTasksView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarTasksView()
//            .environmentObject(TaskManager())
//    }
//}
