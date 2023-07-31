////
////  HomeView.swift
////  TaskManagmentApp
////
////  Created by khalid doncic on 05/07/2023.
////
//
//import SwiftUI
//
//struct HomeView: View {
//    @State var showingCalendarTasksView: Bool = false
//    @EnvironmentObject private var viewModel:  TaskManager
//
//    var body: some View {
//        NavigationStack {
//            
//            ScrollView(.vertical, showsIndicators: false) {
//                
//                HStack {
//                    
//                
//                    VStack(alignment: .leading) {
//                        Text("Good")
//                            .font(.largeTitle.bold())
//                            .foregroundColor(.black)
//                        Text("morning")
//                            .font(.title.italic().bold())
//                            .foregroundColor(.gray)
//                    }
//                    Spacer()
//                    Button {
//                        showingCalendarTasksView.toggle()
//                    } label: {
//                        
//                        
//                        
//                        Image(systemName: "calendar")
//                            .font(.system(size: 30))
//                            .foregroundColor(.black)
//                            .frame(width: 60, height: 60)
//                            .background(
//                                Color.gray.opacity(0.3)
//                                    .clipShape(Circle())
//                                
//                            )
//                    }
//                    
//
//
//                    }
//                    .padding()
//
//                
//                ProgressCardView()
//                
//
//                headerTaskView(title: "Ongoing", count: viewModel.getInCompletedTask().count)
//                    .padding(.top)
//                 
//                ForEach(viewModel.getInCompletedTask()) { task in
//                    LazyVStack {
//                        homeTasksView(task: task)
//                        Divider()
//                    }
//                }
//                .padding()
//                
//                headerTaskView(title: "Completed", count: viewModel.getCompletedTask().count)
//                    .padding(.top)
//                ForEach(viewModel.getCompletedTask()) { task in
//                    LazyVStack {
//                        homeTasksView(task: task)
//                        Divider()
//                    }
//                }
//                .padding()
//               
//                
//                
//            }
//         
//             
//            .refreshable {
//                viewModel.fetchTask()
//              
//            }
//            .navigationTitle("")
//            .navigationBarHidden(true)
//        } .fullScreenCover(isPresented: $showingCalendarTasksView) {
//            CalendarTasksView()
//        }
//     
//    }
// 
//    func homeTasksView(task: TaskModel) -> some View{
//  
//         HStack {
//           
//            Button {
//                withAnimation(.spring(response: 0.8, dampingFraction: 0.5)) {
//                    viewModel.makeTaskCompleted(task: task)
//                }
//            } label: {
//                
//                
//                
//                Image(systemName: task.status ? "checkmark.square" :  "square")
//                
//                    .font(.system(size: 40))
//                    .foregroundColor(.gray.opacity(0.6))
//                
//            }
//            VStack(alignment: .leading) {
//                Text(task.title ?? "")
//                    .font(.title2)
//                Text("Today")
//                    .font(.callout)
//                    .foregroundColor(.gray)
//            }
//            Spacer()
//        }
//
//    }
//    
//    @ViewBuilder
//    func headerTaskView(title: String, count: Int) -> some View {
//        HStack {
//            
//            Text(title).font(.title).bold()
//            Capsule()
//                .frame(width: 60, height: 40)
//                .foregroundColor(.gray.opacity(0.3))
//                .overlay {
//                    Text("\(count)").font(.title).bold()
//
//                }
//           
//            
//            Spacer()
//               
//        }  .padding(.leading)
//    }
//    @ViewBuilder
//    func ProgressCardView() -> some View {
//        
//        
//       
//                VStack(alignment: .leading) {
//                    VStack {
//                        
//                        
////                        Text("24 april, Mon")
//                        Text(viewModel.extractDate(date: Date(), format: "dd MMM, EE"))
//                            .font(.callout)
//                            .foregroundColor(.gray)
//                        
//                        Text("Today's progress")
//                            .font(.system(size: 25, weight: .bold))
//                            .foregroundColor(.white)
//                        
//                  
//                        
//                    } .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding([.leading, .top])
//                    VStack {
//                        
//                        HStack {
//                            VStack {
//                                Text("\(viewModel.getCompletedTask().count)/\(viewModel.getTasksForToday().count) tasks")
//                                    .font(.system(size: 16))
//                                    .foregroundColor(.gray)
//                                    .padding(.leading, -40)
//                                Text("\(viewModel.getPercent())%")
//                                    .font(.system(size: 55))
//                                    .bold()
//                                    .foregroundColor(.white)
//                                    .padding(.leading)
//                            }
//                            Spacer()
//                        }
//                        
//                        ProgressBarView(percent: viewModel.getPercent())
//                            
//                    }
//                    .padding(.leading)
//                    .padding(.top, 70)
//                    
//                    Spacer()
//                }
//                .frame(width: 350, height: 350)
//            .background(Color.black.cornerRadius(22))
//           
//            
//        }
//    @ViewBuilder
//    
//    func ProgressBarView(percent: Int) -> some View {
//        let barWidth = getPercentage(percent: percent, width: 300)
//
//         ZStack(alignment: .leading) {
//            RoundedRectangle(cornerRadius: 20)
//                .frame(width: 300, height: 50)
//                .foregroundColor(.white)
//            
//
//            RoundedRectangle(cornerRadius: 20)
//                .frame(width: barWidth, height: 50)
//                
//                .background(
//                    LinearGradient(
//                        gradient: Gradient(colors: [Color("PinkP"), Color("GrayP"), Color("BlueP")]),
//                        startPoint: .leading,
//                        endPoint: .trailing
//                    )
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
//               
//            )
//            .foregroundColor(.clear)
//        }
//    }
//
//
//
//    
//
//
//    
//    
//    
//    func getPercentage(percent: Int , width: CGFloat) -> CGFloat {
//        let multyplay = width / 100
//        return multyplay * CGFloat(percent)
//        
//    }
//     
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//            .environmentObject(TaskManager())
//    }
//}
// 
//
//extension Color {
//    static let gold = Color(
//        red: 0.9882352941,
//        green: 0.7607843137,
//        blue: 0,
//        opacity: 1
//    )
//}
