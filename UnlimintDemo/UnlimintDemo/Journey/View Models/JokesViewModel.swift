//
// Copyright © 2022 Hitender Kumar. All rights reserved.
//

import Foundation
import Resolver

public class JokesViewModel {
    
    // MARK: - Properties
    @LazyInjected
    var configuration: Jokes.Configuration
    
    @LazyInjected
    var useCase: JokeUseCase
    
    // Private
    private var jokes = [Joke]()
    
    var jokesViewMOdels: [JokeViewModel] {
        self.jokes.map({ JokeViewModel($0) })
    }

    public var isLoading: ((Bool) -> Void)?
  
    // Handlers
    var onError: ((Jokes.Error) -> Void)?
    var onJokeFetchSuccess: (() -> Void)?
    
    // MARK: - Constructor
    
    public init() { }
    
    func scheduleJokeFetcher() {
        Timer.scheduledTimer(timeInterval: TimeInterval(configuration.jokeFetchDelay), target: self, selector: #selector(getJoke), userInfo: nil, repeats: true)
    }
}

extension JokesViewModel {
    
    // MARK: Network call
    
    @objc public func getJoke() {
        self.isLoading?(true)
        self.useCase.getJoke(completion: { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading?(false)
                switch result {
                case .failure(let error):
                    if let err = error as? Jokes.Error {
                        self?.onError?(err)
                    }
                case .success(let joke):
                    guard !(joke.isEmpty) else {
                        self?.onError?(Jokes.Error.emptyData)
                        return
                    }
                    self?.addJoke(newJoke: joke)
                    self?.onJokeFetchSuccess?()
                }
            }
        })
    }
    
    private func addJoke(newJoke: Joke) {
        guard jokes.count >= 10 else {
            jokes.append(newJoke)
            return
        }
        jokes[0] = newJoke
    }
}
