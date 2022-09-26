//
// Copyright © 2022 Hitender Kumar. All rights reserved.
//

import Foundation

public class JokeViewModel {
    
    // MARK: - Properties
    let joke: Joke
    
    // MARK: - Constructor
    internal init(_ joke: Joke) {
        self.joke = joke
    }
}
