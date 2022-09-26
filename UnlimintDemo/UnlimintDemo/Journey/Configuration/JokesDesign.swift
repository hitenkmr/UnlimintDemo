//
// Copyright © 2022 Hitender Kumar. All rights reserved.
//

import Foundation
import UIKit

public typealias Style<Component> = (Component) -> Void

extension Jokes {
    public struct Design {
        
        /// Applied to background views.
        public var background: Style<UIView> {
            return { view in
                view.backgroundColor = .white
            }
        }
        
        /// Applied to the of facility label
        public var jokeLabel: Style<UILabel> = {
            $0.numberOfLines = 0
            $0.font = .boldSystemFont(ofSize: 16)
            $0.textColor = .black
        }
    }
}
