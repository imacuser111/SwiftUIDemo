//
//  DemoScreen.swift
//  SwiftUIDemo
//
//  Created by Cheng-Hong on 2024/12/17.
//

import SwiftUI
import CoreData

struct DemoScreen: View {
    
    @StateObject private var viewModel = DemoViewModel()
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(fetchRequest: fetchRequestLimit10()) var students: FetchedResults<Student>
    
    static func fetchRequestLimit10() -> NSFetchRequest<Student> {
        let request: NSFetchRequest<Student> = Student.fetchRequest()
        request.fetchLimit = 10
        request.sortDescriptors = []
        
        return request
    }
    
    var body: some View {
        VStack {
            Button("Show Alert") {
                viewModel.isShowAlert = true
            }
            
            Button("Show Toast") {
                viewModel.isShowToast = true
            }
            
            Button("Add Student") {
                let student = Student(context: moc)
                student.id = UUID()
                student.name = "1"
                
                try? moc.save()
            }
            
            if let student = students.first {
                Button("Remove First Student") {
                    moc.delete(student)
                }
                
                Text(student.name ?? "")
                    .onAppear {
                        if moc.hasChanges {
                            print("123456")
                        }
                    }
            }
        }
        .padding(.bottom, 10)
        .showAlert(isPresented: $viewModel.isShowAlert) {
            .init(type: .normal(title: "title", message: "message", confirmActionText: "confirm", cancelActionText: "cancel", iconStyle: .none))
        }
        .toast(isShow: $viewModel.isShowToast, info: "Toast")
    }
}

#Preview {
    DemoScreen()
}
