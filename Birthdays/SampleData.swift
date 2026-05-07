//
//  SampleData.swift
//  Birthdays
//
//  Created by Feed0 on 31/03/26.
//

import Foundation
import SwiftData

class SampleData {
    
    // MARK: - Properties
    
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    // MARK: - Init
    
    private init() {
        let schema = Schema([
            Friend.self,
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true,
        )
        
        do {
            modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration],
            )
            
            insertSampleData()
            
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer! Error: \(error)")
        }
    }
    
    // MARK: - Private funcs
    
    private func insertSampleData() {
        for friend in Friend.sampleData {
            context.insert(friend)
        }
        
        for gift in Gift.sampleData {
            context.insert(gift)
        }
        
        Friend.sampleData[0].gifts = [
            Gift.sampleData[0],
            Gift.sampleData[3],
        ]
        
        Friend.sampleData[1].gifts = [
            Gift.sampleData[1],
        ]
        
        Friend.sampleData[2].gifts = [
            Gift.sampleData[2],
        ]
    }
}
