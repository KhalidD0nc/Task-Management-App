//
//  TaskViewModel.swift
//  TaskManagmentApp
//
//  Created by khalid doncic on 05/07/2023.
//

import SwiftUI
import CoreData
 
class TaskManager: ObservableObject {
    let container = NSPersistentContainer(name: "TaskModel")
//    let userContainer = NSPersistentContainer(name: "UserModel")
    @Published var tasks: [TaskModel] = []
//    @Published var TaskCompleted: [TaskModel] = []
//    @Published var TaskInCompleted: [TaskModel] = []
    @Published var currentWeek: [Date] = []
    @Published var currentDay = Date()
    @Published var hours: [Int] = []
    @Published var completedAchievements: Set<String> = []
    let acivments = [
     "Successfully complete 2 tasks.",
     "Successfully complete 10 tasks.",
     " Complete tasks for 7 consecutive days.",
     "Complete a task before 9 AM.",
     "Complete a task after 9 PM." ,
     "Spend less than estimated time on a task."
        
    ]

//    @State var todayTasks: [TaskModel] = []
    
     
    init() {
        container.loadPersistentStores{ (storeDescription , error )in
            if let error = error{
                print("DEBUG: error while loading \(error.localizedDescription)")
            }
             
            
        }
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fetchCurrentWeek()
            self.fetchTask()
            self.updateAchievements()
        }
     
    }
    // Tasks Function
    func fetchTask() {
        do {
            let request = NSFetchRequest<TaskModel>(entityName: "TaskModel")
            self.tasks = try container.viewContext.fetch(request)
        } catch  {
            print("DEBUG: error while fetching tasks")
            return
        }
    }
    
    func saveTasks(title: String, date: Date, description: String?, typeName: String?, typeColor: String) {
        let newTask = TaskModel(context: container.viewContext)
        
        do {
            newTask.id = UUID()
            newTask.title = title
            newTask.date = date
            newTask.descrip = description
            newTask.catigoryName = typeName
            newTask.catigoryColor = typeColor
            
            
            try container.viewContext.save()
        } catch  {
            print("DEBUG: error while save task \(error.localizedDescription)")
            return
        }
        fetchTask()
    }
    
    func getTasksForToday() -> [TaskModel] {
        let calendar = Calendar.current
       
        let todayTasks = tasks.filter { task in
            guard let taskDate = task.date else {return false}
           
            return calendar.isDate(taskDate, inSameDayAs: currentDay)
        }
        
        return todayTasks.sorted{(task1, task2) in
            if let taskDate1 = task1.date, let taskDate2 = task2.date {
                return taskDate1 < taskDate2
            }
            return false
        }
       
    }
     
    func makeTaskCompleted(task: TaskModel) {
        do {
      
            task.status.toggle()
            try container.viewContext.save()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.updateAchievements()
            }
          
        } catch  {
            print("DEBUG: error while toogle status")
            return
        }
        fetchTask()
    }
    
    func getCompletedTask() -> [TaskModel]{
      
        let colmpletedTask = getTasksForToday().filter{$0.status}
          return colmpletedTask
        
         
    }

    func getInCompletedTask() -> [TaskModel] {
        
        let inColmpletedTask = getTasksForToday().filter{!$0.status}
          return inColmpletedTask
        
    }
    
     
    func getPercent() -> Int {
        let totalTasksCount = getTasksForToday().count
        guard totalTasksCount > 0 else {
            return 0
        }
        
        let completedTasksCount = getCompletedTask().count
        let percent = (completedTasksCount * 100) / totalTasksCount
        
        return percent
    }
    
     
    func deleteTask(task: TaskModel) {
     
            container.viewContext.delete(task)
            try? container.viewContext.save()
        
        
    }


    
 
    
    func getLastMonthTasks()  -> [TaskModel]{
        let calendar = Calendar.current
        guard let lastMonth = calendar.date(byAdding: .month, value: -1, to: calendar.startOfDay(for: Date())) else {return []}

        let lastWeekTasks = tasks.filter { task in
            guard let taskDate = task.date else {return false}
           return taskDate < lastMonth

        }
        return lastWeekTasks.sorted{ (task1, task2) in
            if let task1Date = task1.date, let task2Date = task2.date {
                return task1Date < task2Date
            }
            return false
        }

    }
    
    
    func isAchievementCompleted(achievement: String) -> Bool {
        switch achievement {
                case _ where achievement.contains("2 tasks"):
                    return tasks.filter { $0.status }.count >= 2
                case _ where achievement.contains("10 tasks"):
                    return tasks.filter { $0.status }.count >= 10
                case _ where achievement.contains("7 consecutive days"):
                    // Implement logic to check if tasks were completed for 7 consecutive days.
                    // You can track this using additional properties like timestamps for tasks completion.
                    // For this example, let's return false.
                    return false
                case _ where achievement.contains("Complete a task before 9 AM"):
                    // Implement logic to check if a task was completed before 9 AM.
                    // You can check the time of the completed task against 9 AM.
                    // For this example, let's return false.
                    return false
                case _ where achievement.contains("Complete a task after 9 PM"):
                    // Implement logic to check if a task was completed after 9 PM.
                    // You can check the time of the completed task against 9 PM.
                    // For this example, let's return false.
                    return false
                case _ where achievement.contains("Spend less than estimated time on a task"):
                    // Implement logic to check if a task was completed in less time than estimated.
                    // You may need to have a property in the TaskModel to store the estimated time.
                    // For this example, let's return false.
                    return false
                default:
                    return false
                }
        }
    
    func updateAchievements() {
        var completedAchievements: Set<String> = []
        for achivment in acivments {
            if isAchievementCompleted(achievement: achivment) {
                completedAchievements.insert(achivment)
            }
        }
        self.completedAchievements = completedAchievements
    }
    
    
    
    
    
    
    
    
//    func deleteyesteDayTasks() {
//        let tasksDeleted = getYesterDayTaks()
//        for tasksDelete in tasksDeleted {
//            container.viewContext.delete(tasksDelete)
//        }
//        do {
//            try container.viewContext.save()
//        } catch  {
//            print("DEBUG: error while deleteyesteDayTasks")
//        }
//        fetchTask()
//
//
//
//
//    }
//
// Date Function÷
    
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        guard let firstDayOffWeek = week?.start else {return}
        (0..<7).forEach { day in
            if let dayOfWeek = calendar.date(byAdding: .day,value: day ,to: firstDayOffWeek) {
                currentWeek.append(dayOfWeek)
            }
        }
    }
    func extractDate(date: Date, format: String) -> String{
        let formater = DateFormatter()
        formater.dateFormat = format
        return formater.string(from: date)
        
    }
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
        
    }
    func getMonthAndYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: Date())
    }
    func isCurrentHour(date: Date) -> Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        return hour == currentHour
        
        
    }
    
   
    

}


    



enum Catigory: String,CaseIterable{
    case gym
    case coding
    case general
    case study
    case work
    
    var taskName: String {
        switch self {
        case .gym:
            return "GYM"
        case .coding:
            return "CODING"
        case .general:
            return "GENERAL"
        case .study:
            return "STUDY"
        case .work:
            return "WORK"
            
        }

    }
    
    var nameColor: String{
        switch self {
        case .gym:
            return "Gray"
        case .coding:
            return "Green"
        case .general:
            return "Pink"
        case .study:
            return "Blue"
        case .work:
            return "Purple"
            
        }
    }
}
 

