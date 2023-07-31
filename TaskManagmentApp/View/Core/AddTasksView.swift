////
////  AddTasksView.swift
////  TaskManagmentApp
////
////  Created by khalid doncic on 06/07/2023.
////
//
//import SwiftUI
//
//import SwiftUI
//
//
//import SwiftUI
//
//struct AddTaskView: View {
//    @State var title: String = ""
//    @State var description: String = ""
//    @State var date = Date()
//    @State var catigoryName: String = Catigory.coding.taskName
//    @State var catigoryColor: String = Catigory.coding.nameColor
//    @State private var animate: Bool = false
//    @State private var animateColor: String = Catigory.coding.nameColor
//
//    @EnvironmentObject private var viewModel:  TaskManager
//    @Environment(\.dismiss) var dismiss
//    var body: some View {
//        VStack(alignment: .leading) {
//            VStack(alignment: .leading, spacing: 10) {
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
//                Text("Create New Task")
//                    .font(.system(size: 28, weight: .regular))
//                    .foregroundColor(.white)
//                    .padding(.vertical, 15)
//
//                titleView("NAME")
//
//                TextField("Make UI/UX Design", text: $title)
//                    .font(.system(size: 16, weight: .regular))
//                    .tint(.white)
//                    .padding(.top, 2)
//                Rectangle()
//                    .fill(.white.opacity(0.7))
//                    .frame(height: 1)
//                titleView("DATE")
//                    .padding([.top, .bottom], 15)
//
//
//
//                HStack(spacing: 22) {
//
//                    HStack(spacing: 12) {
//                        Text(viewModel.extractDate(date: date, format: "EEEE dd, MMMM"))
//
//
//                        Image(systemName: "calendar")
//                            .font(.title3)
//                            .foregroundColor(.white)
//                            .overlay {
//                                DatePicker("", selection: $date,displayedComponents: [.date])
//                                    .blendMode(.destinationOver)
//                            }
//
//
//
//                    } .offset(y: -5)
//                        .overlay(alignment: .bottom) {
//                            Rectangle()
//                                .fill(.white.opacity(0.7))
//                                .frame(height: 1)
//                                .offset(y: 5)
//
//
//
//                } .padding(.bottom, 5)
//
//
//
//                    HStack(spacing: 12) {
//                        Text(viewModel.extractDate(date: date, format: "hh: mm a"))
//
//
//                        Image(systemName: "clock")
//                            .font(.title3)
//                            .foregroundColor(.white)
//                            .overlay {
//                                DatePicker("", selection: $date,displayedComponents: [.hourAndMinute])
//                                    .blendMode(.destinationOver)
//                            }
//
//
//
//                    } .offset(y: -5)
//                        .overlay(alignment: .bottom) {
//                            Rectangle()
//                                .fill(.white.opacity(0.7))
//                                .frame(height: 1)
//                                .offset(y: 5)
//
//
//
//                        } .padding(.bottom, 5)
//
//                }
//
//
//
//
//            }
//            .environment(\.colorScheme, .dark)
//            .hAlign(.leading)
//            .padding(15)
//            .background {
//                ZStack {
//                    Color(catigoryColor)
//                    GeometryReader{
//                        let size = $0.size
//                        Rectangle()
//                            .fill(Color(animateColor))
//                            .mask {
//                                Circle()
//                            }
//                            .frame(width: animate ? size.width * 1 : 0, height: animate ? size.height * 3 : 0)
//                            .offset(animate ? CGSize(width: -size.width / 2, height: -size.height / 2) : size)
//                    }
//                    .clipped()
//
//                }
//
//                .ignoresSafeArea()
//            }
//
//
//
//
//
//            VStack(alignment: .leading, spacing: 10) {
//                titleView("DESCRIPTION", color: .gray)
//                TextField("About Your Task", text: $description)
//                    .font(.system(size: 12, weight: .regular))
//                    .padding(.top, 2)
//                Rectangle()
//                    .fill(.black.opacity(0.2))
//                    .frame(height: 1)
//
//                titleView("CATIGORY", color: .gray)
//                    .padding(.top, 15)
//             .padding(.horizontal)
//
//
//                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3),spacing: 15) {
//                    ForEach(Catigory.allCases, id: \.rawValue) { catigory in
//                        Text(catigory.rawValue.uppercased())
//                            .font(.system(size: 12, weight: .regular))
//                            .hAlign(.center)
//                            .padding(.vertical, 6)
//                            .background {
//                                RoundedRectangle(cornerRadius: 6, style: .continuous)
//                                    .fill(Color(catigory.nameColor).opacity(0.25))
//
//                            }
//                            .foregroundColor(Color(catigory.nameColor))
//                            .contentShape(Rectangle())
//                            .onTapGesture {
//                                guard !animate else {return}
//                                animateColor = catigory.nameColor
//                                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1, blendDuration: 1)){
//                                    animate = true
//                                }
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
//                                    animate = false
//                                    catigoryColor = catigory.nameColor
//                                }
//                            }
//                    }
//                }
//            } .padding(.top, 5)
//            Button {
//                viewModel.saveTasks(title: title, date: date, description: description, typeName: catigoryName, typeColor: catigoryColor)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
//                    dismiss()
//                }
//
//            } label: {
//                Text("Push The Task")
//                    .foregroundColor(.white)
//                    .padding(.vertical, 15)
//                    .hAlign(.center)
//                    .background {
//                        Capsule()
//                            .fill(Color(animateColor))
//
//                    }
//            }
//            .vAlign(.bottom)
//            .disabled(title == "" || animate)
//            .opacity(title == "" ? 0.7 : 1)
//
//                .padding(15)
//        }
//        .vAlign(.top)
//
//
//
//    }
//
//    @ViewBuilder
//    func titleView(_ value: String , color: Color = .white) -> some View {
//        VStack {
//            Text(value)
//                .font(.system(size: 12, weight: .regular))
//                .foregroundColor(color)
//        }
//    }
//
//
//
//
//}
//
//
//struct AddTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskView()
//            .environmentObject(TaskManager())
//    }
//}
//
//
//extension View{
//    func hAlign(_ alignment: Alignment)->some View{
//        self
//            .frame(maxWidth: .infinity,alignment: alignment)
//    }
//
//    func vAlign(_ alignment: Alignment)->some View{
//        self
//            .frame(maxHeight: .infinity,alignment: alignment)
//    }
//}
//
//
