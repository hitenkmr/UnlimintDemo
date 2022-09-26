//
// Copyright © 2022 Hitender Kumar. All rights reserved.
//

import UIKit
import Resolver

final class JokeTableViewCell: UITableViewCell {
    
    // MARK: - View Lifecycle
    
    @LazyInjected
    private var config: Jokes.Configuration
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyStyle()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: JokeViewModel) {
        textLabel?.text = viewModel.joke
    }
}

extension JokeTableViewCell {
    // MARK: - Private
    
    private func applyStyle() {
        guard let label = textLabel else { return }
        config.design.jokeLabel(label)
    }
}
