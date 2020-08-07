//
//  ProfileScreenWireframe.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import UIKit

class ProfileScreenWireFrame: ProfileScreenWireFrameProtocol {
    
    class func createProfileScreenModule() -> UIViewController {
        
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ProfileScreenView")
        
        if let view = viewController as? ProfileScreenView {
            
            let presenter: ProfileScreenPresenterProtocol = ProfileScreenPresenter()
            let wireFrame: ProfileScreenWireFrameProtocol = ProfileScreenWireFrame()
            let userDataManager: UserLocalDataManagerInputProtocol = UserLocalDataManager()
           let academyDataManager: AcademyLocalDataManagerInputProtocol = AcademyLocalDataManager()

            view.presenter = presenter
            presenter.view = view
            presenter.academyDataManager = academyDataManager
            presenter.userDataManager = userDataManager
            presenter.wireFrame = wireFrame

            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func presentAcademyScreen(from view: ProfileScreenViewProtocol) {
        let hostingController = ProfileAcademyScreenWireframe.createProfileAcademyScreenModule()
        
        hostingController.rootView.onDismiss = {
            hostingController.dismiss(animated: true, completion: nil)
        }
        DispatchQueue.main.async { //make sure all UI updates are on the main thread.
            if let sourceView = view as? UIViewController {
                //                sourceView.navigationController?.view.layer.add(CATransition().segueFromLeft(), forKey: nil)
                hostingController.modalPresentationStyle = .fullScreen
                sourceView.navigationController?.present(hostingController, animated: true, completion: nil)
            }
            
        }
    }
    
    func presentAcademyEditScreen(from view: ProfileScreenViewProtocol, id: Int) {
        let hostingController = ProfileAcademyScreenWireframe.createProfileAcademyEditScreenModule(id: id)
        
        hostingController.rootView.onDismiss = {
            hostingController.dismiss(animated: true, completion: nil)
        }
        DispatchQueue.main.async { //make sure all UI updates are on the main thread.
            if let sourceView = view as? UIViewController {
                //                sourceView.navigationController?.view.layer.add(CATransition().segueFromLeft(), forKey: nil)
                hostingController.modalPresentationStyle = .fullScreen
                sourceView.navigationController?.present(hostingController, animated: true, completion: nil)
            }
            
        }
    }
    
    func presentProfileEditScreen(from view: ProfileScreenViewProtocol) {
        
        let hostingController = ProfileEditScreenWireframe.createProfileEditScreenModule()
        
        hostingController.rootView.onDismiss = {
            hostingController.dismiss(animated: true, completion: nil)
        }
        DispatchQueue.main.async { //make sure all UI updates are on the main thread.
            if let sourceView = view as? UIViewController {
                //                sourceView.navigationController?.view.layer.add(CATransition().segueFromLeft(), forKey: nil)
                hostingController.modalPresentationStyle = .fullScreen
                sourceView.navigationController?.present(hostingController, animated: true, completion: nil)
            }
            
        }
        
    }
    
}

extension CATransition {

//New viewController will appear from bottom of screen.
func segueFromBottom() -> CATransition {
    self.duration = 0.375 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.moveIn
    self.subtype = CATransitionSubtype.fromTop
    return self
}
//New viewController will appear from top of screen.
func segueFromTop() -> CATransition {
    self.duration = 0.375 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.moveIn
    self.subtype = CATransitionSubtype.fromBottom
    return self
}
 //New viewController will appear from left side of screen.
func segueFromLeft() -> CATransition {
    self.duration = 0.1 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.moveIn
    self.subtype = CATransitionSubtype.fromLeft
    return self
}
//New viewController will pop from right side of screen.
func popFromRight() -> CATransition {
    self.duration = 0.1 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.reveal
    self.subtype = CATransitionSubtype.fromRight
    return self
}
//New viewController will appear from left side of screen.
func popFromLeft() -> CATransition {
    self.duration = 0.1 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.reveal
    self.subtype = CATransitionSubtype.fromLeft
    return self
   }
}
