//
// Copyright © 2022 Hitender Kumar. All rights reserved.
//

import UIKit
import Resolver

public protocol EdgeCase {
    /// Edge case title.
    var title: String? { get }

    /// Optional edge case subtitle.
    var subtitle: String { get }
}

public struct JokesEdgeCase: EdgeCase {
    public var title: String?
    public var subtitle: String
}

protocol EdgeCasePresenter: UIViewController { }

extension EdgeCasePresenter {
    private func assignEdgeCase(edgeCase: EdgeCase) {
        let alertController = UIAlertController(title: edgeCase.title,
                                                message: edgeCase.subtitle,
                                                preferredStyle: .alert)
        let config: Jokes.Configuration = Resolver.resolve()
        let action = UIAlertAction(title: config.strings.errorPopUpOkBUttonTitle,
                                   style: .cancel)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    func assignError(_ error: Jokes.Error) {
        let config: Jokes.Configuration = Resolver.resolve()
        
        switch error {
        case .notConnected:
            let edge = JokesEdgeCase(title: config.strings.errorTitle,
                                          subtitle: config.strings.errorNotConnectedSubtitle)
            self.assignEdgeCase(edgeCase: edge)
        case .refreshFailure:
            let edge = JokesEdgeCase(title: config.strings.errorTitle,
                                          subtitle: config.strings.errorRefreshFailureSubtitle)
            self.assignEdgeCase(edgeCase: edge)
        case .invalidData:
            let edge = JokesEdgeCase(title: config.strings.errorTitle,
                                          subtitle: config.strings.errorInvalidDataSubtitle)
            self.assignEdgeCase(edgeCase: edge)
        case .emptyData:
            let edge = JokesEdgeCase(title: config.strings.errorTitle,
                                          subtitle: config.strings.errorEmptyDataSubtitle)
            self.assignEdgeCase(edgeCase: edge)
        }
    }
}
