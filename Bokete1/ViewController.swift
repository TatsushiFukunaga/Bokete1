//
//  ViewController.swift
//  Bokete1
//
//  Created by Tatsushi Fukunaga on 2020/09/20.
//  Copyright © 2020 tatsushi.fukunaga. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var odaiImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTextView.layer.cornerRadius = 20.0
        
        PHPhotoLibrary.requestAuthorization { (States) in
            switch(States){
                case.authorized: break
                case.denied: break
                case.notDetermined: break
                case.restricted: break
            }
        }
       getImages(keyword: "funny")
        
    }
    
    //検索キーワードの値を元に画像を引っ張ってくる
    //Pixabay.com
    
    func getImages(keyword:String){
        
        //18380387-811e87d92e77fa8d8c2664351

        let url = "https://pixabay.com/api/?key=18380387-811e87d92e77fa8d8c2664351&q=\(keyword)"
        
        
        //Alamofireを使ってhttpリクエストを投げる
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON
            { (response) in
                switch response.result {
                case.success:
                    let json:JSON = JSON(response.data as Any)
                    var imageString = json["hits"][self.count]["webformatURL"].string
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    
                    if imageString == nil{
                         imageString = json["hits"][0]["webformatURL"].string
                        self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    }
                    
                case.failure(let error):
                    print(error)
                }
                
        }
       
    }
    
    @IBAction func nextOdai(_ sender: Any) {
        count = count + 1
        if searchTextField.text == ""{
            getImages(keyword: "funny")
        }else{
            getImages(keyword: searchTextField.text!)
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
        self.count = 0
        if searchTextField.text == ""{
            getImages(keyword: "funny")
        }else{
            getImages(keyword: searchTextField.text!)
        }
    }
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shareVC = segue.destination as? ShareViewController
        shareVC?.commentString = commentTextView.text
        shareVC?.resultImage = odaiImageView.image!
    }
    

}

