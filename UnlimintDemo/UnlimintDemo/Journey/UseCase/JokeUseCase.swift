//
// Copyright © 2022 Hitender Kumar. All rights reserved.
//

import Foundation

public protocol JokeUseCase {
    /// Retrieves a joke and provides an appropriate completion handler
    func getJoke(url: URL, completion: @escaping ((Result<Joke, Swift.Error>) -> Void))
} 
