//
//  LocationTask.swift
//  WhySit
//
//  Created by Andrew McConnell on 4/25/17.
//  Copyright © 2017 Andrew McConnell. All rights reserved.
//

import Foundation
import ResearchKit

struct ResultParser {
    
    func processSurveyResults(taskResult: ORKTaskResult?)
    {
        if let taskResultValue = taskResult
        {
            //1
            //print("Task Run UUID : " + taskResultValue.taskRunUUID)
            print("Survey started at : \(taskResultValue.startDate)     Ended at : \(taskResultValue.endDate)")
            //2
            if let instStepResult = taskResultValue.stepResult(forStepIdentifier: "Instruction Step")
            {
                print("Instruction Step started at : \(instStepResult.startDate)   Ended at : \(instStepResult.endDate)")
            }
            //3
            if let compStepResult = taskResultValue.stepResult(forStepIdentifier: "Completion Step")
            {
                print("Completion Step started at : \(compStepResult.startDate)   Ended at : \(compStepResult.endDate)")
            }
        }
    }
}
