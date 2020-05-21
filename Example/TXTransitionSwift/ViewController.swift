//
//  ViewController.swift
//  TXTransitionSwift
//
//  Created by 张雄 on 05/21/2020.
//  Copyright (c) 2020 张雄. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let nextVC: NextViewController = .init()
        nextVC.view.backgroundColor = .red
        self.present(nextVC, animated: true, completion: nil)
    }

}

