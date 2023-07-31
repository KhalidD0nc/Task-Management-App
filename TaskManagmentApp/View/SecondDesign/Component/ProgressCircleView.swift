//
//  ProgressCircleView.swift
//  TaskManagmentApp
//
//  Created by khalid doncic on 20/07/2023.
//

//import SwiftUI
//
//struct ProgressCircleView: View {
//    var progress: CGFloat = 0.8 // Progress value between 0 and 1
//       let circleWidth: CGFloat = 15
//       
//       var body: some View {
//           HStack {
//              
//               VStack(spacing: 20) {
//                   Text("Daily Task")
//                       .font(.title2)
//                       .bold()
//                       .foregroundColor(.white)
//                   
//                   Text("8/10 done")
//                       .font(.system(size: 20))
//                       .bold()
//                       .foregroundColor(.gray)
//               }
//               Spacer()
//              
//               ZStack
//               {
//                   ZStack {
//                       Circle()
//                           .stroke(lineWidth: circleWidth)
//                           .opacity(0.3)
//                           .foregroundColor(Color.white)
//                       
//                       Circle()
//                           .trim(from: 0.0, to: progress)
//                           .stroke(
//                            style: StrokeStyle(lineWidth: circleWidth, lineCap: .round, lineJoin: .round)
//                           )
//                           .fill(
//                            .white                   )
//                           .rotationEffect(Angle(degrees: 270.0))
//                   }
//                   
//               }
//          
//               .frame(width: 60, height: 60)
//
//              
//              
//               
//             
//           }   .padding()
//               .padding(.horizontal)
//           .frame(maxWidth: 300)
//       
//           .background(Color.black)
//           .clipShape(RoundedRectangle(cornerRadius: 30))
//       }
//    
//}
//
//struct ProgressCircleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressCircleView()
//    }
//}
//
