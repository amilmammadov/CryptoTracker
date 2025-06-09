//
//  LaunchViewModel.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 09.06.25.
//

import Foundation
import Combine

protocol LaunchViewModelProtocol: ObservableObject {
    var launchText: [String] { get set }
    var counter: Int { get set }
    var loops: Int { get set }
    var timer: Publishers.Autoconnect<Timer.TimerPublisher> { get }
    func handleCounterChange()
    var onFinish: (()->Void)? {get set }
}

final class LaunchViewModel: LaunchViewModelProtocol {
    
    @Published var launchText: [String] = StringConstants.launchScreenText.map { String($0) }
    @Published var counter: Int = 0
    @Published var loops: Int = 0
    var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    var onFinish: (()->Void)?
    
    //MARK: - Handles counter when timer emits value
    func handleCounterChange(){
        if counter == launchText.count - 1 {
            counter = 0
            loops += 1
            if loops >= 2 {
                onFinish?()
            }
        } else {
            counter += 1
        }
    }
}
