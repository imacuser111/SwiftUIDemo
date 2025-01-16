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
    
    @FetchRequest(sortDescriptors: []) var pencils: FetchedResults<Pencil>
    
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
                let pencil = Pencil(context: moc)
                student.id = UUID()
                student.name = "1"
                
                pencil.title = "AAAA pencil"
//                student.pencils = [pencil]
                pencil.student = student
                
                try? moc.save()
            }
            
            List(students, id: \.self) { student in
                VStack{
                    Text("\(student.id ?? UUID())")
                    
                    if let pencils = student.pencils?.allObjects as? [Pencil], let pencil = pencils.first {
                        Text(pencil.title ?? "")
                    }
                }
            }
            
            Button("Delete Student") {
                if let student = students.first {
                    moc.delete(student)
                    try? moc.save() // 記得要保存，否則不會更新DB
                }
            }
        }
        .padding(.vertical)
        .showAlert(isPresented: $viewModel.isShowAlert) {
            .init(type: .normal(title: "title", message: "message", confirmActionText: "confirm", cancelActionText: "cancel", iconStyle: .none))
        }
        .toast(isShow: $viewModel.isShowToast, info: "Toast")
    }
}

#Preview {
    DemoScreen()
}
