//
//  LocationsTabViewController.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import UIKit

class LocationsTabViewController: RmBaseVC {
    
    public static func getInstance() -> LocationsTabViewController {
        return LocationsTabViewController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func getTitle() -> String {
        return "locations".getLocalizedString()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
