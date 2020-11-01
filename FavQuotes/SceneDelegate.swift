//
//  SceneDelegate.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/4/20.
//  Copyright © 2020 eagersoft.io. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    public static let LOAD_WITH_SWIFTUI = false
    /*
     I don't choose to load this project with SwiftUI by default because I found trouble dealing with some *functions* while implementing with SwiftUI. I did build a working SwiftUI version, though. Simply change LOAD_WITH_SWIFTUI to true to load the Scene with SwiftUI.
     
     *function*:
        1. Placeholder for TextEditor: I'm trying to solve it by using a Zstack. I'm thinking about aligning TextEditor and a placeholder label in Z direction. When the Text is not empty(the user entered something), I will set the background placeholder text's alpha to 0, and vice versa.
        2. Sync with CoreData immediately after the user exiting QuoteEditor. In NewQuoteViewController, I can easily do it with a callback. In SwiftUI though, the callback is automatically managed, so I have to passively sync when the app enters background. Still looking for solutions on StackOverflow...
        3. Deleting the Quote when user edit the current Quote to empty. Same thing with #2, I can't detect if the user emptied both TextView after exiting QuoteEditor.
     */

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if(SceneDelegate.LOAD_WITH_SWIFTUI){
            let contentView = QuoteList()
            if let windowScene = scene as? UIWindowScene {
                        let window = UIWindow(windowScene: windowScene)
                        window.rootViewController = UIHostingController(rootView: contentView)
                        self.window = window
                        window.makeKeyAndVisible()
            }
        }else{
            guard let windowScene = (scene as? UIWindowScene) else {
                return
            }
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.windowScene = windowScene
            window?.rootViewController = BaseViewController.init(nibName: "BaseViewController", bundle: Bundle.main)
            window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        if(SceneDelegate.LOAD_WITH_SWIFTUI){
            AppDataManager.shared.syncQuotesWithCoreData()
        }
    }


}

