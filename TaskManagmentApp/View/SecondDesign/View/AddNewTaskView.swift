//
//  AddNewTaskView.swift
//  TaskManagmentApp
//
//  Created by khalid doncic on 22/07/2023.
//

import SwiftUI

struct AddNewTaskView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var date = Date()
    @State private var selctedCatigory: Catigory = Catigory.coding
    @State private var isPushed: Bool = false
    @State private var isSuucced: Bool = false
    @EnvironmentObject private var vm: TaskManager
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var scheme
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color("background_v2")
                    .ignoresSafeArea()
                
             
                
                
                VStack {
                    headerView()
                    VStack(alignment: .leading) {
                           
                        
                            
                            titleAndDescriptionView()
                            
                            taskTimeAndDate()
                            
                            Text("Where You would like to do it")
                                .font(.title2)
                                .foregroundColor(.white)
                               
                            
                                DropDown(content: Catigory.allCases, selection: $selctedCatigory,
                                         activeTint: $selctedCatigory, inActiveTint: .white.opacity(1))
                                .frame(width: 160)
                                
                                .background {
                                    Color.white
                                        .ignoresSafeArea()
                                }
                                .padding(.leading, 45)
                                .padding(.bottom)
                                
                           
                                
                                
                                
                                
                     
                        HStack(spacing: 40) {
                            Text("Schedule Your Task")
                                .font(.system(size: 24, weight: .bold, design: .serif))
                                .foregroundColor(.white)
                            Button {
                                vm.saveTasks(title: title, date: date, description: description, typeName: selctedCatigory.taskName, typeColor: selctedCatigory.nameColor)
                                
                                withAnimation(.interactiveSpring(response: 1, dampingFraction: 0.4, blendDuration: 0.7)) {
                                    isPushed.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                        isSuucced.toggle()
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            dismiss()
                                        }
                                    }
                                }
                                
                            } label: {
                           Image(systemName: "arrow.right")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color("Orange"))
                                    .clipShape(Circle())
                            
                                    .rotationEffect(Angle(degrees: isPushed ? 360 : 0))
                            }
                           
                              
                        }  .padding(.top)
                        
                       
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 3)
                    
                

                }
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .frame(width: 200, height: 150)
                    
                        .overlay(alignment: .center) {
                            VStack(spacing: 20) {
                                Image(systemName: "checkmark.seal.fill")
                                    .font(.system(size: 70))
                                    .foregroundColor(Color("Orange"))
                                Text("Task added successfully")
                                    .bold()
                                   
                                 
                            }
                        }
                }
                
                .opacity(isSuucced ? 1 : 0)
                
                    .offset(y: 180)
            }
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
                    
                    
                    Text("New Task")
                        .fixedSize()
                        .foregroundColor(.white)
                        .font(.system(size: 35, weight: .bold, design: .monospaced))
                        .padding(.leading, 10)
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    private func titleAndDescriptionView() -> some View {
        Text("Title")
            .foregroundColor(.white)
        TextField("Make UI/UX better",text: $title)
            .font(.system(size: 18, weight: .regular))
            .padding(.leading)
            .foregroundColor(.white)
            .tint(.white)
            .frame(width: 350, height: 70)
            .background(Color("Gray_V2")).cornerRadius(30)
        
        Text("Description")
            .foregroundColor(.white)
        TextEditor(text: $description)
            .font(.system(size: 22, weight: .regular))
            .foregroundColor(.white)
            .scrollContentBackground(.hidden)
            .tint(.white)
            .padding()
            .frame(maxWidth: 350, maxHeight: 150)
            .background(Color("Gray_V2"))
            .cornerRadius(30)
        
    }
    
    @ViewBuilder
    private func taskTimeAndDate() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 14) {
                Text("Due Date")
                    .foregroundColor(.white)
                
                HStack(spacing: 12) {
                    Text(vm.extractDate(date: date, format: "dd MMM"))
                        .foregroundColor(.white)
                        .padding()
                    
                        
               

                        Image(systemName: "calendar")
                            .font(.title2)
                            .foregroundColor(.white)
                            .overlay(
                                DatePicker("", selection: $date, displayedComponents: [.date])
                                    .blendMode(.destinationOver)
                            )
                    
                    
                } .frame(width: 170, height: 70)
                    .background(Color("Gray_V2")) .cornerRadius(25)
     
                    
               
                
            }
        
            Spacer()
            
            VStack(alignment: .leading, spacing: 14) {
                Text("Due Time")
                    .foregroundColor(.white)
                
                HStack(spacing: 12) {
                    Text(vm.extractDate(date: date, format: "h:mm a"))
                        .foregroundColor(.white)
                        .padding()
              
                        
                  

                        Image(systemName: "clock")
                            .font(.title2)
                            .foregroundColor(.white)
                            .overlay(
                                DatePicker("", selection: $date, displayedComponents: [.hourAndMinute])
                                    .blendMode(.destinationOver)
                            )
                    
                    
                } .frame(width: 170, height: 70)
                    .background(Color("Gray_V2")) .cornerRadius(25)
     
                    
               
                
            }
            
            
        }
    }
}


struct AddNewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskView()
            .environmentObject(TaskManager())
    }
}
