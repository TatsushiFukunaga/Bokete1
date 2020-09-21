//
//  ShareViewController.swift
//  Bokete1
//
//  Created by Tatsushi Fukunaga on 2020/09/20.
//  Copyright © 2020 tatsushi.fukunaga. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    var resultImage = UIImage()
    var commentString = String()
    var screenShotImage = UIImage()
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultImageView.image = resultImage
        commentLabel.text = commentString
        commentLabel.adjustsFontSizeToFitWidth = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func share(_ sender: Any) {
        //スクリーンショットを撮る
        takeScreenShot()
        
        let items = [screenShotImage] as [Any]
        //アクティビティービューに乗っけてシェアする。
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    func takeScreenShot() {
        let width = CGFloat(UIScreen.main.bounds.size.width)
        let height = CGFloat(UIScreen.main.bounds.size.height/1.3)
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        //Viewに書き出す
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
