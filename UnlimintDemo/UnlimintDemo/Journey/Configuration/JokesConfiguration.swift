//
// Copyright © 2022 Hitender Kumar. All rights reserved.
//

import Foundation

extension Jokes {
    public struct Configuration {
        
        public init() {
            /* Leave empty */
        }
        
        var maxJokes = 10
        
        // numbers of seconds to fetch joke after
        var jokeFetchDelay = 6

        public var strings = Strings()
        public var design = Design()
    }
}
