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
    
    @Environment(\.managedObjectContext) var context
    
//    @FetchRequest(fetchRequest: fetchRequestLimit10()) var students: FetchedResults<Student>
    
    @FetchRequest(sortDescriptors: []) var pencils: FetchedResults<Pencil>
    
    @State private var students: [Student] = []
    @State private var fetchLimit: Int = 10 // 初始為 10
    
//    static func fetchRequestLimit10() -> NSFetchRequest<Student> {
//        let request: NSFetchRequest<Student> = Student.fetchRequest()
//        request.fetchLimit = 10
//        request.sortDescriptors = []
//        
//        return request
//    }
    
    var body: some View {
        VStack {
            Button("Show Alert") {
                viewModel.isShowAlert = true
            }
            
            Button("Show Toast") {
                viewModel.isShowToast = true
            }
            
            Button("Add Student") {
                AppState.shared.showProgressView()
                
                DispatchQueue.main.async {
                    saveInBatches() {
                        fetchLimit = 20
                        fetchStudents()
                        AppState.shared.hiddenProgressView()
                    }
                }
            }
            
            List(students, id: \.self) { student in
                VStack{
                    Text("\(student.id ?? UUID())")
                    
                    if let pencils = student.pencils?.allObjects as? [Pencil], let pencil = pencils.first {
                        Text(pencil.title ?? "")
                    }
                }
            }
            
            Button("Delete all") {
                deleteAllData()
            }
        }
        .padding(.vertical)
        .showAlert(isPresented: $viewModel.isShowAlert) {
            .init(type: .normal(title: "title", message: "message", confirmActionText: "confirm", cancelActionText: "cancel", iconStyle: .none))
        }
        .toast(isShow: $viewModel.isShowToast, info: "Toast")
        .onAppear(perform: fetchStudents) // 初始化加載數據
    }
    
    private func fetchStudents() {
        let request: NSFetchRequest<Student> = Student.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        request.fetchLimit = fetchLimit // 動態設置 fetchLimit
        
        do {
            students = try context.fetch(request) // 執行查詢
        } catch {
            print("Failed to fetch students: \(error)")
        }
    }
}

#Preview {
    DemoScreen()
        .environmentObject(AppState.shared)
}

extension DemoScreen {
    typealias Entity = Student
    
    func saveInBatches(_ completion: @escaping () -> ()) {
//        let backgroundContext = DataController.shared.container.newBackgroundContext()
//        backgroundContext.automaticallyMergesChangesFromParent = true
//        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        DispatchQueue.global(qos: .background).async {
            var array = [Student]()
            
            for i in (1...1000) {
                let student = Student(context: context)
                let pencil = Pencil(context: context)
                student.id = UUID()
                student.name = "\(i)"
                
                pencil.title = "AAAA pencil"
//                student.pencils = [pencil]
                pencil.student = student
                
                array.append(student)
            }
            
            
            context.perform {
                // 進行數據處理
                do {
//                    try backgroundContext.save() // 在背景執行緒保存
//                    backgroundContext.reset()
                    
                    DispatchQueue.main.async {
                        try? context.save() // 确保更改同步到磁盘
                        context.reset()
                        completion()
                    }
                } catch {
                    print("Error saving background context: \(error)")
                }
            }
        }
    }
    
    func delete(entity: Entity) {
        context.delete(entity)
        
        do {
            try context.save()
            students.removeAll(where: { $0.id == entity.id })
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
//    func deleteAll() {
//        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Student.fetchRequest()
//        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
//        _ = try? context.execute(batchDeleteRequest1)
//    }
    
    private func deleteAllData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.executeAndMergeChanges(using: batchDeleteRequest)
            // 重置緩存，避免讀取到舊數據
            context.reset()
        } catch { // handle error here
            print("BATCH DELETE FAILED")
        }
        
        fetchStudents()
    }
}

extension NSManagedObjectContext {
    
    /// Executes the given `NSBatchDeleteRequest` and directly merges the changes to bring the given managed object context up to date.
    ///
    /// - Parameter batchDeleteRequest: The `NSBatchDeleteRequest` to execute.
    /// - Throws: An error if anything went wrong executing the batch deletion.
    public func executeAndMergeChanges(using batchDeleteRequest: NSBatchDeleteRequest) throws {
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        let result = try execute(batchDeleteRequest) as? NSBatchDeleteResult // 執行刪除
        let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [self]) // 合併變更
    }
}
