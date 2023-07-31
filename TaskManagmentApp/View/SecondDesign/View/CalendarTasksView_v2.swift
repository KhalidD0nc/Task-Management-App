//
//  CalendarTasksView_v2.swift
//  TaskManagmentApp
//
//  Created by khalid doncic on 20/07/2023.
//

import SwiftUI

struct CalendarTasksView_v2: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isShowing: Bool = false
    @EnvironmentObject private var taskViewModel: TaskManager
    var body: some View {
        NavigationStack {
            
            ZStack(alignment: .top) {
                Color("background_v2")
                    .ignoresSafeArea()
                // Header And Days View
                
                
                
                VStack {
                    headerView()
                    daysAndNumView()
                    timeLineView()
                    
                }
                .padding(.leading)
                createTaskButton()
                
                
            }
            
            
        }.fullScreenCover(isPresented: $isShowing) {
            AddNewTaskView()
        }
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        VStack {
            VStack {
                HStack(spacing: 40) {
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
                    
                    
                    Text("Manage Task")
                        .fixedSize()
                        .foregroundColor(.white)
                        .font(.system(size: 35, weight: .bold, design: .monospaced))
                        .padding(.leading, 10)
                    Spacer()
                }
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(taskViewModel.extractDate(date: Date(), format: "dd MMMM yyyy "))
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.top)
                    Spacer()
                } .padding()
                Text("You have 4 tasks today")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.leading)
            }
        }
    }
    
    @ViewBuilder
    private func daysAndNumView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            
            ScrollViewReader { value in
                HStack {
                    ForEach(taskViewModel.currentWeek, id: \.self) { date in
                        VStack {
                            Text(taskViewModel.extractDate(date: date, format: "dd"))
                                .foregroundColor(.white)
                            
                            
                            Text(taskViewModel.extractDate(date: date, format: "EE"))
                                .foregroundColor(.white)
                            
                        } .onTapGesture {
                            withAnimation(.spring()) {
                                taskViewModel.currentDay = date
                            }
                        }
                        
                        .frame(width: 60, height: 80)
                        .background(taskViewModel.isToday(date: date)  ? Color("Orange") : Color(red: 0.2, green: 0.2, blue: 0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 20)) // make the background a capsule
                        .padding(.horizontal, 5) // Add horizontal spacing between capsules
                        
                    }
                    
                }
                .onChange(of: taskViewModel.currentDay) { newValue in
                    withAnimation(.spring()) {
                        value.scrollTo(taskViewModel.currentDay, anchor: .trailing)
                    }
                }
                .onAppear {
                    
                    value.scrollTo(taskViewModel.currentDay)
                    
                }
            }
            
            
            
            
            
            
            
        }
    }
    
    
    @ViewBuilder
    private func timeLineView() -> some View  {
        ScrollView(.vertical) {
            
            let hours = Calendar.current.hours
            
            LazyVStack {
                ForEach(hours, id: \.self) { hour in
                    TimelineViewRow(hour)
                        .id(hour)
                }
            }
            
            
            
        }
        
    }
    
    @ViewBuilder
    func TimelineViewRow(_ date: Date)->some View{
        HStack(alignment: .top) {
            Text(taskViewModel.extractDate(date: date, format: "h a"))
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .regular))
                .frame(width: 45,alignment: .leading)
            
            /// - Filtering Tasks
            let calendar = Calendar.current
            let filteredTasks = taskViewModel.getTasksForToday().filter{
                guard let dateAdded = $0.date else {return false}
                if let hour = calendar.dateComponents([.hour], from: date).hour,
                   let taskHour = calendar.dateComponents([.hour], from: dateAdded).hour,
                   hour == taskHour && calendar.isDate(dateAdded, inSameDayAs: taskViewModel.currentDay){
                    return true
                }
                return false
            }
            
            if filteredTasks.isEmpty{
                Rectangle()
                    .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel, dash: [5], dashPhase: 5))
                    .frame(height: 0.5)
                    .offset(y: 10)
            }else{
                /// - Task View
                VStack(spacing: 10){
                    ForEach(filteredTasks){task in
                        taskRowView(task: task)
                            .padding(.trailing)
                    }
                }
            }
        }
        //        .hAlign(.leading)
        .padding(.vertical,15)
    }
    
    
    
    @ViewBuilder
    private func taskRowView(task: TaskModel) -> some View{
        
        VStack(alignment: .leading, spacing: 8) {
            Text(task.title ?? "")
                .foregroundColor(.white)
            Spacer()
            
            HStack {
                Image(systemName: "pencil.line")
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                
                Text(task.catigoryName ?? "")
                    .fixedSize()
                    .foregroundColor(.gray)
                Spacer()
            } .padding(.leading)
            
            
            
        }
        .padding(.leading, 25)
        .padding(12)
        
        .background (
            
            ZStack(alignment: .leading) {
                
                
                
                Rectangle()
                    .fill(Color("Orange").opacity(0.30))
                
                Rectangle()
                    .foregroundColor(Color(task.catigoryColor ?? ""))
                    .frame(width: 15, height: 80)
                    .cornerRadius(15)
                    .padding(.leading, 18)
                if let task = task.date {
                    if taskViewModel.isCurrentHour(date: task) {
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("Green_v2"))
                                .frame(width: 15)
                                .overlay(
                                    Image(systemName: "line.3.horizontal")
                                        .foregroundColor(.white)
                                        .rotationEffect(Angle(degrees: 90))
                                )
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("Green_v2"))
                                .frame(width: 15)
                                .overlay(
                                    Image(systemName: "line.3.horizontal")
                                        .foregroundColor(.white)
                                        .rotationEffect(Angle(degrees: 90))
                                )
                        }
                    }
                }
                
            }
            
            
            
        ) .cornerRadius(15)
        
            .overlay(
                RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 3)
                    .fill(taskViewModel.isCurrentHour(date: task.date ?? Date()) ? Color("Green_Border") : .clear)
                
                
            )
    

 
    

//           .background(Color(red: 0.2, green: 0.2, blue: 0.2))
       
       
        
    }
    
    @ViewBuilder
    private func createTaskButton() -> some View {
        VStack {
            Spacer()
            
            Button {
                isShowing.toggle()
            } label: {
                Text("Create New Task")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(20)
                    .frame(width: 350)
                    .background(Color("Orange").cornerRadius(60))
                   
            }
        }

    }
    
}

struct CalendarTasksView_v2_Previews: PreviewProvider {
    static var previews: some View {
        CalendarTasksView_v2()
            .environmentObject(TaskManager())
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

//struct DashedDivider: View {
//    let lineColor: Color
//    let lineWidth: CGFloat
//    let dashHeight: CGFloat
//    let dashGap: CGFloat
//
//    var body: some View {
//        GeometryReader { geometry in
//            Path { path in
//                let dashCount = Int(geometry.size.height / (dashHeight + dashGap))
//                for index in 0..<dashCount {
//                    let y = CGFloat(index) * (dashHeight + dashGap)
//                    path.move(to: CGPoint(x: 0, y: y))
//                    path.addLine(to: CGPoint(x: 0 , y: y + dashHeight))
//                }
//            }
//            .stroke(lineColor, lineWidth: lineWidth)
//        }
//    }
//}
//
 
struct DashedDivider: View {
    let lineColor: Color
    let lineWidth: CGFloat
    let dashHeight: CGFloat
    let dashGap: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let dashCount = Int(geometry.size.width / (dashHeight + dashGap))
                for index in 0..<dashCount {
                    let x = CGFloat(index) * (dashHeight + dashGap)
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x + dashHeight , y: 0))
                }
            }
            .stroke(lineColor, lineWidth: lineWidth)
        }
    }
}


extension Calendar{
    /// - Return 24 Hours in a day
    var hours: [Date]{
        let startOfDay = self.startOfDay(for: Date())
        var hours: [Date] = []
        for index in 0..<24{
            if let date = self.date(byAdding: .hour, value: index, to: startOfDay){
                hours.append(date)
            }
        }
        
        return hours
    }
    
    /// - Returns Current Week in Array Format
    var currentWeek: [WeekDay]{
        guard let firstWeekDay = self.dateInterval(of: .weekOfMonth, for: Date())?.start else{return []}
        var week: [WeekDay] = []
        for index in 0..<7{
            if let day = self.date(byAdding: .day, value: index, to: firstWeekDay){
                let weekDaySymbol: String = day.toString("EEEE")
                let isToday = self.isDateInToday(day)
                week.append(.init(string: weekDaySymbol, date: day,isToday: isToday))
            }
        }
        
        return week
    }
    
    /// - Used to Store Data of Each Week Day
    struct WeekDay: Identifiable{
        var id: UUID = .init()
        var string: String
        var date: Date
        var isToday: Bool = false
    }
}

extension Date{
    func toString(_ format: String)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

struct TimeMarker: View {
    var heightRatio: CGFloat // Representing the duration of the task in relation to the total time frame

    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height * heightRatio
            Path { path in
                path.move(to: CGPoint(x: 0, y: height))
                path.addRect(CGRect(x: 0, y: 0, width: geometry.size.width, height: height))
            }
            .fill(Color.green) // Or any other color to represent the time marker
        }
    }
}
