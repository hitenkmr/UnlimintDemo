//
// Copyright © 2022 Hitender Kumar. All rights reserved.
//

import Foundation

extension Jokes {
    public struct Strings {
        
        /// Creates a new instance of the string with default values
        public init() {}
        
        public var navigationTitle = "screen.jokes.navigation.title".localized
         
        /// Errors
        public var errorNotConnectedSubtitle = "alerts.error.notConnected.message".localized
        public var errorInvalidDataSubtitle = "alerts.error.invalidData.message".localized
        public var errorRefreshFailureSubtitle = "alerts.error.refreshFailure.message".localized
        public var errorEmptyDataSubtitle = "alerts.error.emptyData.message".localized

        public var errorTitle = "alerts.error.title".localized
        public var errorPopUpOkBUttonTitle = "alerts.error.options.ok".localized
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: .main, value: "", comment: "")
    }
}

