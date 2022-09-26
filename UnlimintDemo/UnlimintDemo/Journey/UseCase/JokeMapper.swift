//
// Copyright © 2022 Hitender Kumar. All rights reserved.
//

import Foundation

public final class JokeMapper {
   
    public enum Error: Swift.Error {
        case invalidData
    }
    
    // DTO
    typealias RemoteJoke = String
        
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Joke {
        guard response.isOK, let joke = try? JSONDecoder().decode(RemoteJoke.self, from: data) else {
            throw Error.invalidData
        }
        
        return joke
    }
}

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }

    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
