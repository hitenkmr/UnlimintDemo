//
// Copyright © 2022 Hitender Kumar. All rights reserved.
//

import Foundation

public class RemoteJokeUseCase {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
}

public typealias Joke = String

extension RemoteJokeUseCase: JokeUseCase {
    public func getJoke(completion: @escaping ((Result<Joke, Swift.Error>) -> Void)) {
        let url = URL(string: "https://geek-jokes.sameerkumar.website/api")!
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case .success(let (data, response)):
                let isValidResponse = response.isOK && !data.isEmpty
                if isValidResponse {
                    do {
                        let joke = try JokeMapper.map(data, from: response)
                        completion(.success(joke))
                    } catch {
                        completion(.failure(JokeMapper.Error.invalidData))
                    }
                } else {
                    completion(.failure(Jokes.Error.refreshFailure))
                }
            case .failure:
                completion(.failure(Jokes.Error.notConnected))
            }
        }
    }
}

