import SwiftUI
import HealthKit
import AVFoundation

struct SleepTrackingView: View {
    let content: Content?
    @ObservedObject var appState: AppState
    @State private var isSleepTrackingActive = false
    @State private var audioPlayer: AVAudioPlayer?
    @State private var sessionStartTime: Date?
    @State private var showQuiz = false
    @State private var quizCompleted = false
    @State private var advertAudioPlayer: AVAudioPlayer?
    @State private var remSleepDetected = false
    @State private var advertTimer: Timer?

    var body: some View {
        VStack {
            if let content = content {
                Text("Sleep Tracking: \(content.title)")
                
                if isSleepTrackingActive {
                    if remSleepDetected {
                        Text("REM Sleep Detected")
                    } else {
                        Text("Sleep Tracking Active")
                    }
                    Button("End Session") {
                        endSleepTracking()
                    }
                } else if showQuiz {
                    if let startTime = sessionStartTime {
                        PostSleepQuizView(appState: appState, sessionDuration: Date().timeIntervalSince(startTime), onQuizCompleted: {
                            quizCompleted = true
                            showQuiz = false
                        })
                    }
                } else if quizCompleted {
                    Text("Session and quiz completed")
                    Button("Start New Session") {
                        resetSession()
                    }
                } else {
                    Button("Start Sleep Tracking") {
                        startSleepTracking()
                    }
                }
            } else {
                Text("Please select content from the Content tab")
            }
        }
    }
    
    func startSleepTracking() {
        isSleepTrackingActive = true
        sessionStartTime = Date()
        
        // Play bedtime audio
        if let audioURL = Bundle.main.url(forResource: "bedtime", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                audioPlayer?.play()
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        } else {
            print("Error: Could not find audio file")
        }
        
        // Schedule timer to detect REM sleep
        advertTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { _ in
            self.remSleepDetected = true
            self.playAdvert()
        }
    }
    
    func endSleepTracking() {
        isSleepTrackingActive = false
        audioPlayer?.stop()
        advertTimer?.invalidate()
        showQuiz = true
    }
    
    func resetSession() {
        isSleepTrackingActive = false
        showQuiz = false
        quizCompleted = false
        sessionStartTime = nil
        audioPlayer?.stop()
        advertTimer?.invalidate()
    }
    
    func playAdvert() {
        if let audioURL = Bundle.main.url(forResource: "beverage", withExtension: "mp3") {
            do {
                advertAudioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                advertAudioPlayer?.currentTime = 5 // Skip the first 5 seconds
                advertAudioPlayer?.play()
                audioPlayer?.volume = 0.5 // Set the volume of the bedtime audio to 0.5
                advertAudioPlayer?.volume = 1.0 // Set the volume of the advert audio to 1.0
            } catch {
                print("Error playing advert: \(error.localizedDescription)")
            }
        } else {
            print("Error: Could not find advert audio file")
        }
        
        // Invalidate the timer
        advertTimer?.invalidate()
    }
}
