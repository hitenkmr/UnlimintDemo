//
//  AppDelegate.swift
//  UnlimintDemo
//
//  Created by Hitender Kumar on 27/09/22.
//

import UIKit
import Resolver

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        start()
        return true
    }

    func start() {
        let configuration: Jokes.Configuration = .init()
        Resolver.register { configuration }

        let client = URLSessionHTTPClient.init(session: .shared)
        let useCase = RemoteJokeUseCase(client: client)
             
        Resolver.register { useCase }
        .implements(JokeUseCase.self)
         
        let jokeViewController = Jokes.build()
        
        window = UIWindow(frame: UIScreen.main.bounds)

        // -- main app window
        window?.rootViewController = jokeViewController

        // -- main controller
        window?.makeKeyAndVisible()
    }

}

