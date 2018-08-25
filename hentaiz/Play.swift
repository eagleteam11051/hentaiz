//
//  Play.swift
//  hentaiz
//
//  Created by Thắng Nguyễn Hoàng on 8/25/18.
//  Copyright © 2018 Thắng Nguyễn Hoàng. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Alamofire
class Play: UIViewController {
    var data:[GetLink] = []
    @IBOutlet weak var lblLink: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var order:Order?
    
    let avPlayerVC = AVPlayerViewController()
    var avPlayer = AVPlayer()
    
    
    @IBAction func btnPlay(_ sender: Any) {
        self.present(avPlayerVC, animated: true){
            self.avPlayerVC.player?.play()
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        let back = self.storyboard?.instantiateViewController(withIdentifier: "main")
        self.present(back!, animated: true, completion: nil)
    }
    @IBAction func btnLui(_ sender: Any) {
        so = so - 1
        if (so != 0){
            print(so)
            load()
        }else{
            so = so + 1
            let alertController = UIAlertController(title: "Thông Báo", message: "Đã quay về trang đầu tiên", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style:.default) {
                UIAlertAction in
                NSLog("OK Pressed")
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        
        
    }
    
    @IBOutlet weak var navi: UINavigationItem!
    @IBAction func btnTien(_ sender: Any) {
        so = so + 1
        
        if(so <= Int(sotap)!){
            load()
        }else{
            so = so - 1
            
            let alertController = UIAlertController(title: "Thông Báo", message: "Đã quay về trang đầu tiên", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style:.default) {
                UIAlertAction in
                NSLog("OK Pressed")
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        print(so)
    }
    
    var sotap: String = ""
    var link: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadVideo()
    }
    var so: Int = 1
    override func viewDidAppear(_ animated: Bool) {
        load()
    }
    func load(){
        var a = ("\((order?.link!)!)/xem-phim/tap-\(so).html")
        print(a)
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request("http://congtymienbac.com.vn/testtruyen.php?url=\(a)",headers: headers).responseJSON {(response) in
            
            let Value = response.result.value as! NSDictionary
            
            
            
            let res = Value["data"] as! [[String: Any]]
            self.sotap = Value["tap"] as! String
            print(self.sotap)
            self.data.removeAll()
            for item in res{
                self.link = item["file"] as! String
                
                print(self.link)
                print("===========================================")
                
                do{
                    
                    let jsonData = try? JSONSerialization.data(withJSONObject: item, options: [])
                    let jsonString:String = String(data: jsonData!, encoding: .utf8)!
                    print("jsonString:",jsonString)
                    let getlink = try JSONDecoder().decode(GetLink.self, from: jsonString.data(using: .utf8)!)
                    self.data.append(getlink)
                    
                }catch let e{
                    print("error",e)
                }
                
                let mvURL: NSURL? = NSURL(string: self.link)
                
                if let url = mvURL{
                    self.avPlayer = AVPlayer(url: url as! URL)
                    self.avPlayerVC.player = self.avPlayer
                }
                self.navi.title = "\(self.so)/\(self.sotap)"
                print("===========================================")
            }
            
        }
    }
    func loadVideo(){
        
        lblLink.text = order?.des!
        print("asnjsknfs",link)
        
        var a = order?.src!
        print(a)
        let url = NSURL(string: a!)
        let data1 = NSData(contentsOf: url as! URL)
        img.image = UIImage(data: data1 as! Data)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
