//
//  ViewController.swift
//  圆角-截屏
//
//  Created by ZJ on 2018/4/28.
//  Copyright © 2018年 ZJ. All rights reserved.
//

import UIKit
import Photos
class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        self.view.backgroundColor = UIColor.red
        
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, 0.0)
        
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
     
        let imgNew: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
    
       // imgView.image = UIImage.imgeRoundedCorners(img: UIImage.init(named: "preview_wallpaper-1171488")!)
    
        imgView.image = UIImage.imgBorderRoundedCorners(img: UIImage.init(named: "preview_wallpaper-1171488")!, space: 10, color: UIColor.green)
        
        //保存到相册的图片对象
        //保存完成功后回调的目标对象
        //保存完成后回调的方法
        //保存完成后，会回调方法的contextinfo中
//        UIImageWriteToSavedPhotosAlbum(imgNew, self, #selector(imgSaveDidFinish(img:error:)), nil)
       
        PHPhotoLibrary.shared().performChanges({
            //写入相册
            PHAssetChangeRequest.creationRequestForAsset(from: imgNew)
        }) { (success, error) in
            print("成功： \(success)  错误：\(String(describing: error))")
        }
        
    }
 
    @objc func imgSaveDidFinish(img: UIImage, error: NSError) {
        
    }
    
  


}

extension UIImage {
    
    
    /// 截屏
    ///
    /// - Parameters:
    ///   - size: 截屏的大小
    ///   - view: 在那个View上截屏
    /// - Returns: 返回一个图片
    static func imgScreenshots(size: CGSize, in view: UIView) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let imgNew: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return imgNew
    }
    
    /// 带边框的图片圆角
    ///
    /// - Parameters:
    ///   - img: 图片
    ///   - space: 边框间隔
    ///   - color: 边框颜色
    /// - Returns: 返回生成的新图片
   static func imgBorderRoundedCorners(img: UIImage, space: CGFloat, color: UIColor) -> UIImage{
    
        let imgSize: CGSize = CGSize(width: img.size.width + 2 * space, height: img.size.height + 2 * space)
        
        
        UIGraphicsBeginImageContextWithOptions(imgSize, false, 0.0)
        let path: UIBezierPath = UIBezierPath.init(ovalIn: CGRect(x: 0,y: 0,width: imgSize.width,height: imgSize.height))
        
        color.set()
        path.fill()
        
        let path1: UIBezierPath = UIBezierPath.init(ovalIn: CGRect(x: space, y: space, width: img.size.width, height: img.size.height))
        
        path1.addClip()
        img.draw(at: CGPoint(x: space,y: space))
        
        let newImg: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImg
    }
    
    
    
    /// 图片圆角
    ///
    /// - Parameter img: 传入图片
    /// - Returns: 传出新图片
   static func imgeRoundedCorners(img: UIImage) -> UIImage{
    
        UIGraphicsBeginImageContextWithOptions(img.size, false, 0.0)
        let path: UIBezierPath = UIBezierPath.init(ovalIn: CGRect(x: 0,y: 0,width: img.size.width,height: img.size.height))
        path.addClip()
        img.draw(at: CGPoint(x: 0,y: 0))
        
        let newImg: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImg
    }
    
}









