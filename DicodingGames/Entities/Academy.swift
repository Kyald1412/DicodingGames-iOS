//
//  Academy.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 05/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class Academy: NSManagedObject {
    
    func initData(completion: @escaping() -> Void) {
        
        AcademyLocalDataManager().createAcademyData(id: 0, name: "Android", desc: "Android Jetpack Pro", photo: (UIImage(named: "belajar_android_jetpack_pro_logo")?.jpegData(compressionQuality: 0.3))!)
        AcademyLocalDataManager().createAcademyData(id: 1, name: "Android", desc: "Android Developer Expert", photo: (UIImage(named: "menjadi_android_developer_expert_logo")?.jpegData(compressionQuality: 0.3))!)
        AcademyLocalDataManager().createAcademyData(id: 2, name: "Kotlin", desc: "Kotlin Androdi Developer Expert", photo: (UIImage(named: "kotlin_android_developer_expert_logo")?.jpegData(compressionQuality: 0.3))!)
        AcademyLocalDataManager().createAcademyData(id: 3, name: "SOLID", desc: "Belajar Prinsip Pemrograman SOLID", photo: (UIImage(named: "belajar_prinsip_pemrograman_solid_logo")?.jpegData(compressionQuality: 0.3))!)
        AcademyLocalDataManager().createAcademyData(id: 4, name: "iOS", desc: "Belajar Fundamental iOS", photo: (UIImage(named: "belajar_fundamental_aplikasi_ios_logo")?.jpegData(compressionQuality: 0.3))!)
    }
}
