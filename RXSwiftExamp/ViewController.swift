//
//  ViewController.swift
//  RXSwiftExamp
//
//  Created by Hector Gutierrez on 29/01/18.
//  Copyright © 2018 Armit Solutions. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    var helloString: String = "hello World! "
    var publishSubject = PublishSubject<String>()
    let bag = DisposeBag()
    var stringGeneral: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newFunct()
        changeString("hello2")
        changeString()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newFunct(){
        let subscription = publishSubject.subscribe(onNext:{
            print($0)
            self.stringGeneral = $0
            if (self.stringGeneral) != nil{
                debugPrint("the value was replaced by: ")
                self.printString(self.stringGeneral!)
            }
        }).disposed(by: bag)
        
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        debugPrint("starts timer")
        delay(when)
        
    }
    
    func changeString(_ string: String){
        publishSubject.onNext(string)
    }
    
    func changeString(){
        publishSubject.onNext("Hello")
        publishSubject.onNext("World")
    }
    
    func printString(_ string: String){
        debugPrint(string)
    }
    
    func delay(_ when: DispatchTime){
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.publishSubject.onNext("What`s new pussy cat!")
        }
    }

}

