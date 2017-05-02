//
//  SurveyTask.swift
//  WhySit
//
//  Created by Andrew McConnell on 4/25/17.
//  Copyright © 2017 Andrew McConnell. All rights reserved.
//

import Foundation

import ResearchKit

public var SurveyTask: ORKNavigableOrderedTask {
    
    var steps = [ORKStep]()
    
    //TODO: add instructions step
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "WhySit Survey"
    instructionStep.text = "Please fill out the following survey. Thanks!"
    steps += [instructionStep]
    
    //TODO: add name question
    /*let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
    nameAnswerFormat.multipleLines = false
    let nameQuestionStepTitle = "What is your name?"
    let nameQuestionStep = ORKQuestionStep(identifier: "QuestionStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
    steps += [nameQuestionStep]*/
    
    //TODO: add 'what is your quest' question
    let question1 = "Are you:"
    let textChoices1 = [
        ORKTextChoice(text: "Lying", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Sitting", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Standing", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Walking", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let quest1AnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices1)
    let questQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep", title: question1, answer: quest1AnswerFormat)
    steps += [questQuestionStep]
    
    let question2 = "What are you doing? Choose one:"
    let textChoices2 = [
        ORKTextChoice(text: "Eating", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Television", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Talking", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Computer", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Desk Work", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Reading", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "On Phone", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Other", value: 7 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let quest2AnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices2)
    let quest2QuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep2", title: question2, answer: quest2AnswerFormat)
    steps += [quest2QuestionStep]
    
    let question3 = "If you would be willing to be disrupted right now, what would you be willing to do? Choose all that apply:"
    let textChoices3 = [
        ORKTextChoice(text: "No, I am not willing to be disrupted.", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Get up and walk.", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Get up and stand", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Get up and complete calisthenics (push-ups, squats, jumping jacks, etc.)", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
    ]
    let quest3AnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: textChoices3)
    let quest3QuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep3", title: question3, answer: quest3AnswerFormat)
    steps += [quest3QuestionStep]
    
    let question4 = "How long would you be willing to do these activities for? Choose one:"
    let textChoices4 = [
        ORKTextChoice(text: "<3 minutes", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "3-5 minutes", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "6-10 minutes", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: ">10 minutes", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
    ]
    let quest4AnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices4)
    let quest4QuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep4", title: question4, answer: quest4AnswerFormat)
    steps += [quest4QuestionStep]
    
    let question5 = "Who are you with? Choose all that apply:"
    let textChoices5 = [
        ORKTextChoice(text: "Alone", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Spouse/Significant Other", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Family Member", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Friend", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Colleague", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Acquaintance", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Pet", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
    ]
    let quest5AnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: textChoices5)
    let quest5QuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep5", title: question5, answer: quest5AnswerFormat)
    steps += [quest5QuestionStep]
    
    let question6a = "Where are you? Choose one:"
    let textChoices6a = [
        ORKTextChoice(text: "Outdoors", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Indoors", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Transport", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Other", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
    ]
    let quest6aAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices6a)
    let quest6aQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep6a", title: question6a, answer: quest6aAnswerFormat)
    steps += [quest6aQuestionStep]
    
    let question6b = "Where are you outdoors? Choose one:"
    let textChoices6b = [
        ORKTextChoice(text: "My house", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Other's house", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Restaurant", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Store", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Park", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Other", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
    ]
    let quest6bAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices6b)
    let quest6bQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep6b", title: question6b, answer: quest6bAnswerFormat)
    steps += [quest6bQuestionStep]
    
    let question6c = "Where are you indoors? Choose one:"
    let textChoices6c = [
        ORKTextChoice(text: "My house", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Other's house", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Restaurant", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Store", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Work", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Other", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
    ]
    let quest6cAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices6c)
    let quest6cQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep6c", title: question6c, answer: quest6cAnswerFormat)
    steps += [quest6cQuestionStep]
    
    let question6d = "What mode of transportation are you using? Choose one:"
    let textChoices6d = [
        ORKTextChoice(text: "Car", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Bus", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Train", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Plane", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Other", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ]
    let quest6dAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices6d)
    let quest6dQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep6d", title: question6d, answer: quest6dAnswerFormat)
    steps += [quest6dQuestionStep]
    
    //TODO: add color question step
    let colorQuestionStepTitle = "Estimate how good or bad you feel right now, from very bad (1) to very good (9)."
    let colorTuples = [
        (UIImage(named: "1")!, "1"),
        (UIImage(named: "2")!, "2"),
        (UIImage(named: "3")!, "3"),
        (UIImage(named: "4")!, "4"),
        (UIImage(named: "5")!, "5"),
        (UIImage(named: "6")!, "6"),
        (UIImage(named: "7")!, "7"),
        (UIImage(named: "8")!, "8"),
        (UIImage(named: "9")!, "9"),
    ]
    let imageChoices : [ORKImageChoice] = colorTuples.map {
        return ORKImageChoice(normalImage: $0.0, selectedImage: nil, text: $0.1, value: $0.1 as NSCoding & NSCopying & NSObjectProtocol)
    }
    let colorAnswerFormat: ORKImageChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: imageChoices)
    let colorQuestionStep = ORKQuestionStep(identifier: "ImageChoiceQuestionStep", title: colorQuestionStepTitle, answer: colorAnswerFormat)
    steps += [colorQuestionStep]
    
    let colorQuestionStepTitle2 = "Right now, how nervous or stressed do you feel? From not at all (1) to very stressed (5)."
    let colorTuples2 = [
        (UIImage(named: "1-5")!, "5"),
        (UIImage(named: "1-4")!, "4"),
        (UIImage(named: "1-3")!, "3"),
        (UIImage(named: "1-2")!, "2"),
        (UIImage(named: "1-1")!, "1"),
        ]
    let imageChoices2 : [ORKImageChoice] = colorTuples2.map {
        return ORKImageChoice(normalImage: $0.0, selectedImage: nil, text: $0.1, value: $0.1 as NSCoding & NSCopying & NSObjectProtocol)
    }
    let colorAnswerFormat2: ORKImageChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: imageChoices2)
    let colorQuestionStep2 = ORKQuestionStep(identifier: "ImageChoiceQuestionStep2", title: colorQuestionStepTitle2, answer: colorAnswerFormat2)
    steps += [colorQuestionStep2]
    
    //TODO: add summary step
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Right. Off you go!"
    summaryStep.text = "That was easy!"
    steps += [summaryStep]
    
    let task = ORKNavigableOrderedTask(identifier: "SurveyTask", steps: steps)
    
    // Navigation rules - Q1
    var predicateRule: ORKPredicateStepNavigationRule
    var resultSelector = ORKResultSelector.init(resultIdentifier: "TextChoiceQuestionStep");
    let predicateStanding: NSPredicate = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: 2 as NSCoding & NSCopying & NSObjectProtocol)
    let predicateWalking: NSPredicate = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: 3 as NSCoding & NSCopying & NSObjectProtocol)
    predicateRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers:
        [(predicateStanding, "TextChoiceQuestionStep5"), (predicateWalking, "TextChoiceQuestionStep5")])
    task.setNavigationRule(predicateRule, forTriggerStepIdentifier: "TextChoiceQuestionStep")
    
    // Q6a
    resultSelector = ORKResultSelector.init(resultIdentifier: "TextChoiceQuestionStep6a");
    let predicateOutdoors: NSPredicate = ORKResultPredicate.predicateForChoiceQuestionResult( with: resultSelector, expectedAnswerValue: 0 as NSCoding & NSCopying & NSObjectProtocol)
    let predicateIndoors: NSPredicate = ORKResultPredicate.predicateForChoiceQuestionResult( with: resultSelector, expectedAnswerValue: 1 as NSCoding & NSCopying & NSObjectProtocol)
    let predicateTransport: NSPredicate = ORKResultPredicate.predicateForChoiceQuestionResult( with: resultSelector, expectedAnswerValue: 2 as NSCoding & NSCopying & NSObjectProtocol)
    let predicateOther: NSPredicate = ORKResultPredicate.predicateForChoiceQuestionResult( with: resultSelector, expectedAnswerValue: 3 as NSCoding & NSCopying & NSObjectProtocol)
    predicateRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers:
        [(predicateOutdoors, "TextChoiceQuestionStep6b"), (predicateIndoors, "TextChoiceQuestionStep6c"), (predicateTransport, "TextChoiceQuestionStep6d"), (predicateOther, "ImageChoiceQuestionStep")])
    task.setNavigationRule(predicateRule, forTriggerStepIdentifier: "TextChoiceQuestionStep6a")
    
    // Direct skips
    var directRule: ORKDirectStepNavigationRule
    directRule = ORKDirectStepNavigationRule(destinationStepIdentifier: "ImageChoiceQuestionStep")
    task.setNavigationRule(directRule, forTriggerStepIdentifier: "TextChoiceQuestionStep6b")
    task.setNavigationRule(directRule, forTriggerStepIdentifier: "TextChoiceQuestionStep6c")
    task.setNavigationRule(directRule, forTriggerStepIdentifier: "TextChoiceQuestionStep6d")
    
    return task
}
