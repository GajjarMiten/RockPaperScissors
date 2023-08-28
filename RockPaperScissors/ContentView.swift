//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Miten Gajjar on 28/08/23.
//

import SwiftUI


enum GameMove: String, CaseIterable {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
}

enum GameResult{
    case win
    case lose
}

struct ContentView: View {
    @State var appMove:GameMove = GameMove.allCases.shuffled()[0]
    @State var userGameResult = GameResult.win
    
    let totalQuestions = 10
    @State var currentQuestion = 1
    @State var totalPoints = 0
    
    @State var shouldShowPopup = true
    @State var showGameOverPopup = false
    @State var showQuestionPopup = false;
    
    @State var questionStatus:String = "You won!";
    
    var isGameOver: Bool {
        currentQuestion == totalQuestions
    }
    
    

    
    var body: some View {
        VStack {
            Text("Pick your move").font(.largeTitle)
            Text("App's move is \(appMove.rawValue)")
            VStack{
                Spacer()
                Button("Rock", systemImage: "circle.fill"){
                    determineResult(.rock)
                }
                Spacer()
                Button("Paper", systemImage: "paperplane.fill"){
                    determineResult(.paper)
                }
                Spacer()
                Button("Scissors", systemImage: "scissors"){
                    determineResult(.scissors)
                }
                Spacer()
                Text("Your score is \(totalPoints)")
            }.font(.headline)
        
        }
        .padding()
        .alert("Do you want to lose or win?" ,isPresented: $shouldShowPopup){
                Button("lose"){
                    userGameResult = GameResult.lose
                }
                Button("win"){
                    userGameResult = GameResult.win
                }
        }
        .alert("Game Over", isPresented: $showGameOverPopup){
            Button("restart",action: restartGame)
        }message: {
            Text("Your score is \(totalPoints)")
        }
        .alert(questionStatus, isPresented: $showQuestionPopup){
            Button("next",action: handleGameFlow)
        }message: {
            Text("Your score is \(totalPoints)")
        }
    }
    
    func restartGame(){
        totalPoints = 0
        currentQuestion = 0
    }
    
    func handleGameFlow(){
        if isGameOver {
            showGameOverPopup = true
        }
        else {
            appMove = GameMove.allCases.shuffled()[0]
            shouldShowPopup = true
//            switch userGameResult{
//                case .lose: userGameResult = .win
//                case .win: userGameResult = .lose
//            }
            currentQuestion+=1
        }
    }
    func determineResult(_ selectedMove:GameMove){
        let isCorrect = switch userGameResult {
        case .win:
            didUserWin(selectedMove)
        case .lose:
            !didUserWin(selectedMove)
        }
        
        if isCorrect {
            totalPoints+=1
            questionStatus = "Yes! you won!"
        }else{
            questionStatus = "Opps! you lost!"
        }
        showQuestionPopup = true
        handleGameFlow()
    }
    func didUserWin(_ selectedMove:GameMove)->Bool{
        switch appMove {
          case  .paper:
            selectedMove == GameMove.scissors
          case  .scissors:
            selectedMove == GameMove.rock
        case  .rock:
          selectedMove == GameMove.paper
        }
    }
}

#Preview {
    ContentView()
}
