//
// Copyright © 2022 Hitender Kumar. All rights reserved.
//

import Foundation
import UIKit

public struct Jokes {
    
    /// Creates and returns the Facilities  view controller instance
    /// - Parameter navigationController: The closure that will be used for routing
    public static func build() -> UIViewController {
        let viewModel = JokesViewModel()
        let controller = JokesViewController(viewModel: viewModel)
        return controller
        
    }
} 

extension Jokes {
    
    /// Represents different errors that may occur on the journey screens
    public enum Error : Swift.Error {
        case notConnected
        case refreshFailure
        case invalidData
        case emptyData
    }
}
