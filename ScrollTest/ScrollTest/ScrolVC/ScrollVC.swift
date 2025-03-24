//
//  HomeVC.swift
//  Swift-OC
//
//  Created by mac on 2021/11/24.
//  Copyright © 2021 Muyuli. All rights reserved.
//

import UIKit
import Foundation

class NewWord: UIViewController,UIScrollViewDelegate,UIGestureRecognizerDelegate {

    var scrollView : UIScrollView?
    var currentIndex :NSInteger?
    var currentOffsetY : CGFloat?
    var scrolled : Bool?
    var pageIndex :NSInteger?
    var videoArray :NSArray?
    var push_index :NSInteger?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "欢迎来到新世界"
        self.currentIndex = 0
        self.scrollView = UIScrollView.init(frame: self.view.bounds)
        self.scrollView?.contentSize = CGSize.init(width: 0, height: kMainScreenHeight * 3)
        self.scrollView?.isOpaque = false
        self.scrollView?.isPagingEnabled = true
        self.currentOffsetY = kMainScreenHeight
        self.scrollView?.contentOffset = CGPoint.init(x: 0, y: kMainScreenHeight)
        self.scrollView?.bounces = false
        self.scrollView?.showsVerticalScrollIndicator = false
        self.scrollView?.delegate = self
        self.scrollView?.scrollsToTop = false
        self.view.addSubview(self.scrollView!)
        self.pageIndex = 0
      
        self.videoArray = ["1.jpeg","2.jpeg","3.jpeg","1.jpeg","2.jpeg","3.jpeg"]
                
//        let backBtn = UIButton.init(frame: CGRect.init(x: 16, y: NavigationBarHEIGHT - 44 + 7, width: 60, height: 30))
//        backBtn.setTitle("返回", for: UIControl.State.normal)
//        backBtn.addTarget(self, action:#selector(back) , for: UIControl.Event.touchUpInside)
//        self.view.addSubview(backBtn)
        
        DispatchAfter(after: 0.2) {
            self.setModelWithIndex(index: self.pageIndex!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    lazy var upView: UIImageView = {
        let upView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: kMainScreenHeight))
        upView.isUserInteractionEnabled = true
        upView.contentMode = UIView.ContentMode.scaleAspectFill;
        upView.clipsToBounds = true
        let blur = UIBlurEffect.init(style: UIBlurEffect.Style.dark)
        let effectview = UIVisualEffectView.init(effect: blur)
        effectview.frame = upView.bounds
        effectview.alpha = 0.8
        upView.addSubview(effectview)
        self.scrollView?.addSubview(upView)
        return upView
    }()
    
    lazy var downView: UIImageView = {
        let upView = UIImageView.init(frame: CGRect.init(x: 0, y: kMainScreenHeight * 2, width: kMainScreenWidth, height: kMainScreenHeight))
        upView.isUserInteractionEnabled = true
        upView.contentMode = UIView.ContentMode.scaleAspectFill;
        upView.clipsToBounds = true
        let blur = UIBlurEffect.init(style: UIBlurEffect.Style.dark)
        let effectview = UIVisualEffectView.init(effect: blur)
        effectview.frame = upView.bounds
        effectview.alpha = 0.8
        upView.addSubview(effectview)
        self.scrollView?.addSubview(upView)
        return upView
    }()
    
    lazy var centerView: UIImageView = {
        let upView = UIImageView.init(frame: CGRect.init(x: 0, y: kMainScreenHeight, width: kMainScreenWidth, height: kMainScreenHeight))
        upView.isUserInteractionEnabled = true
        upView.contentMode = UIView.ContentMode.scaleAspectFill;
        upView.clipsToBounds = true
        let zanBtn = UIButton.init(frame: CGRect.init(x: Int(kMainScreenWidth) - 60 - 16, y: NavigationBarHEIGHT, width: 60, height: 30))
        zanBtn.setTitleColor(UIColor.init(r: 111, g: 111, b: 111), for: UIControl.State.normal)
        zanBtn.titleLabel?.font = setFont(font: 14)
        zanBtn.setTitle("点赞", for: UIControl.State.normal)
        zanBtn.addTarget(self, action: #selector(zanAcion), for: UIControl.Event.touchUpInside)
        upView.addSubview(zanBtn)
        self.scrollView?.addSubview(upView)
        return upView
    }()
    
    @objc func zanAcion() {
        
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        self.scrollView?.isScrollEnabled = true;
        self.scrolled = true;
        return true;
    }
    
    func setModelWithIndex(index:NSInteger) {
        if (self.videoArray?.count)! - 1 < index || self.videoArray?.count == 0 || index < 0 {
            return
        }
        let cout1 = Int.init(self.videoArray?.count ?? 0)
        if index == 0 {
            
            self.scrollView?.addSubview(self.centerView)
            if cout1 > 1 {
                let imageName = self.videoArray?[1]
                self.downView.image = UIImage.init(named: imageName as! String)
            }
            let imageName1 = self.videoArray?[0]
            self.centerView.image =  UIImage.init(named: imageName1 as! String)
            self.scrollView?.setContentOffset(CGPoint.init(x: 0, y: kMainScreenHeight), animated: false)
        }
        
        if index > 0 && cout1  > 1 {
            
            let imageName1 = self.videoArray?[index - 1]
            self.upView.image = UIImage.init(named: imageName1 as! String)

            if index + 2 <= cout1 {
                let imageName2 = self.videoArray?[index + 1]
                self.downView.image = UIImage.init(named: imageName2 as! String)
            }
            let imageName3 = self.videoArray?[index]
            self.centerView.image =  UIImage.init(named: imageName3 as! String)
            self.scrollView?.setContentOffset(CGPoint.init(x: 0, y: kMainScreenHeight), animated: false)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = scrollView.contentOffset.y - self.currentOffsetY!
        if fabsf(Float(y)) < 20 {
            return
        }
    
        if self.pageIndex == 0 && scrollView.contentOffset.y <= self.currentOffsetY! {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
            return
        }
        
        
        let cout1 = Int.init(self.videoArray?.count ?? 0)
        if self.pageIndex == cout1 - 1 && scrollView.contentOffset.y >= self.currentOffsetY! {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
            return
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.isScrollEnabled = true
        let index = scrollView.contentOffset.y/kMainScreenHeight
        if index == 1 {
            return
        }
        if index == 0 {
            self.pageIndex = self.pageIndex! - 1
        }
        if index == 2 {
            self.pageIndex = self.pageIndex! + 1
        }
        self.currentIndex = NSInteger(index)
        if self.pageIndex! < 0 {
            self.pageIndex = 0
        }
        self.releasePlayerView()

        DispatchAfter(after: 0.2) {
            self.setModelWithIndex(index: self.pageIndex!)
        }
 
  
  
}
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func releasePlayerView() {
        self.centerView.image = nil
    }
    

    public func DispatchAfter(after: Double, handler:@escaping ()->())
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            handler()
        }
    }
}
