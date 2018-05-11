//
//  NextViewController.swift
//  JuAllTest
//
//  Created by Juvid on 2018/5/11.
//  Copyright © 2018年 Juvid. All rights reserved.
//

import UIKit

class SNextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let view = UIImageView.init(frame: CGRect.init(x: 50, y: 64, width: 250, height: 250));
        //    view.image=[UIImage juGetGifWithName:@"123456"];
        self.view.addSubview(view);
        view.contentMode = UIViewContentMode.scaleAspectFit;
       view.juSetGifImage(name: "123456")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
