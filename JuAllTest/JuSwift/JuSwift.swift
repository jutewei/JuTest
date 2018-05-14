//
//  JuSwift.swift
//  JuAllTest
//
//  Created by Juvid on 2018/5/9.
//  Copyright © 2018年 Juvid. All rights reserved.
//

import UIKit
import JuSwiftFrame

class JuSwift: NSObject {

    func juTest(name : NSString) {
        let juDown = JuCountDown()
        var blockA : (Int) ->String = { a in
            return "block"
        }
        blockA(1234)
        let block =  testBlock(name: "blokc") { (a) -> String in
            return "block 返回值 \(a)"
        }

        print(block)
    }

    func testBlock(name:String,Blocks:(Int)->String ) -> String {
       
        print(Blocks(1234))
        return "block函数 \(name)"
    }
}
