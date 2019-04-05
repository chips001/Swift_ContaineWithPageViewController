//
//  ViewController.swift
//  Swift_ContaineWithPageViewController
//
//  Created by 一木 英希 on 2019/03/31.
//  Copyright © 2019 一木 英希. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuScrollView: UIScrollView!
    @IBOutlet weak var firstViewButton: UIButton!
    @IBOutlet weak var secondViewButton: UIButton!
    @IBOutlet weak var thirdViewButton: UIButton!
    @IBOutlet weak var fourthViewButton: UIButton!
    
    var pageViewController: PageViewController?
    var menuViewControllers: [UIViewController] = []
    var selected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //PageViewControllerを取得する
        children.forEach { viewController in
            if viewController is PageViewController {
                self.pageViewController = viewController as? PageViewController
            }
        }
        
        //PageViewControllerにセットするViewControllerを生成して配列に入れる
        let firstViewController = FirstViewController.instantiateFromStoryboard()
        self.menuViewControllers.append(firstViewController)
        
        let secondViewController = SecondViewController.instantiateFromStoryboard()
        self.menuViewControllers.append(secondViewController)

        let thirdViewController = ThirdViewController.instantiateFromStoryboard()
        self.menuViewControllers.append(thirdViewController)
        
        let fourthViewController = FourthViewController.instantiateFromStoryboard()
        self.menuViewControllers.append(fourthViewController)
        
        //初期画面の設定
        self.pageViewController?.setViewControllers([self.menuViewControllers[0]], direction: .forward, animated: false, completion: nil)
        self.selected = 0
    }
    
    @IBAction func firstViewButtonHandler(_ sender: UIButton) {
        self.firstViewButton.isEnabled = false
        self.secondViewButton.isEnabled = true
        self.thirdViewButton.isEnabled = true
        self.fourthViewButton.isEnabled = true
        
        //一番左までスクロール
        self.menuScrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
        //表示切り替え
        self.pageViewController?.setViewControllers([self.menuViewControllers[0]], direction: .reverse, animated: true, completion: nil)
        self.selected = 0
    }
    
    @IBAction func secondViewButtonHandler(_ sender: UIButton) {
        self.firstViewButton.isEnabled = true
        self.secondViewButton.isEnabled = false
        self.thirdViewButton.isEnabled = true
        self.fourthViewButton.isEnabled = true
        
        //一番左までスクロール
        self.menuScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        //表示切り替え
        if self.selected < 1 {
            self.pageViewController?.setViewControllers([self.menuViewControllers[1]], direction: .forward, animated: true, completion: nil)
        } else {
            self.pageViewController?.setViewControllers([self.menuViewControllers[1]], direction: .reverse, animated: true, completion: nil)
        }
        self.selected = 1
    }
    
    @IBAction func thirdViewButtonHandler(_ sender: UIButton) {
        self.firstViewButton.isEnabled = true
        self.secondViewButton.isEnabled = true
        self.thirdViewButton.isEnabled = false
        self.fourthViewButton.isEnabled = true
        
        //一番右までスクロール
        let scrollWidth = self.menuScrollView.contentSize.width - self.menuScrollView.frame.size.width
        self.menuScrollView.setContentOffset(CGPoint(x: scrollWidth, y: 0), animated: true)
        //表示切り替え
        if self.selected < 2 {
            self.pageViewController?.setViewControllers([self.menuViewControllers[2]], direction: .forward, animated: true, completion: nil)
        } else {
            self.pageViewController?.setViewControllers([self.menuViewControllers[2]], direction: .reverse, animated: true, completion: nil)
        }
        self.selected = 2
    }
    
    @IBAction func fourthViewButtonHandler(_ sender: UIButton) {
        self.firstViewButton.isEnabled = true
        self.secondViewButton.isEnabled = true
        self.thirdViewButton.isEnabled = true
        self.fourthViewButton.isEnabled = false
        
        //一番右までスクロール
        let scrollWidth = self.menuScrollView.contentSize.width - self.menuScrollView.frame.size.width
        self.menuScrollView.setContentOffset(CGPoint(x: scrollWidth, y: 0), animated: true)
        //表示切り替え
        self.pageViewController?.setViewControllers([self.menuViewControllers[3]], direction: .forward, animated: true, completion: nil)
        self.selected = 3
    }
}

