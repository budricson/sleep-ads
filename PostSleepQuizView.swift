import SwiftUI

struct QuizQuestion {
    let question: String
    let options: [String]
    let correctAnswer: Int
}

struct PostSleepQuizView: View {
    @ObservedObject var appState: AppState
    let sessionDuration: TimeInterval
    let onQuizCompleted: () -> Void
    @State private var quizScore = 0
    @State private var currentQuestionIndex = 0
    @State private var showResult = false
    
    let questions = [
        QuizQuestion(question: "What type of product was advertised?", options: ["Food", "Drink", "Electronics", "Clothing"], correctAnswer: 1),
        QuizQuestion(question: "What was the main message of the advert?", options: ["Relaxation", "Energy", "Fun", "Health"], correctAnswer: 0),
        QuizQuestion(question: "What was the tone of the advert?", options: ["Funny", "Serious", "Exciting", "Boring"], correctAnswer: 0),
        QuizQuestion(question: "What was the primary message conveyed by the advert?", options: ["Relax and unwind", "Boost your energy", "Have fun", "Improve your health"], correctAnswer: 0),
        QuizQuestion(question: "What was the most memorable part of the advert?", options: ["The music", "The message", "The product"], correctAnswer: 0)
    ]
    
    var body: some View {
        VStack {
            if !showResult {
                Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                    .font(.headline)
                    .padding()
                
                Text(questions[currentQuestionIndex].question)
                    .font(.title2)
                    .padding()
                
                ForEach(0..<questions[currentQuestionIndex].options.count, id: \.self) { index in
                    Button(action: {
                        answerSelected(index)
                    }) {
                        Text(questions[currentQuestionIndex].options[index])
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
            } else {
                Text("Quiz Completed!")
                    .font(.title)
                    .padding()
                
                Text("Your score: \(quizScore) out of \(questions.count)")
                    .font(.headline)
                    .padding()
                
                let reward = appState.rewardSystem.getReward(for: quizScore, sessionDuration: sessionDuration)
                
                Text("You earned \(reward.points) points!")
                    .font(.title2)
                    .padding()
                
                Text("Current Tier: \(reward.tier.rawValue)")
                    .font(.title3)
                    .padding()
                
                Button("Back to Content Selection") {
                    onQuizCompleted()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
    
    private func answerSelected(_ index: Int) {
        if index == questions[currentQuestionIndex].correctAnswer {
            quizScore += 1
        }
        
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            showResult = true
        }
    }
}
