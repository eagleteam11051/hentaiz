//
//  ViewController.swift
//  hentaiz
//
//  Created by Thắng Nguyễn Hoàng on 8/25/18.
//  Copyright © 2018 Thắng Nguyễn Hoàng. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var data:[Order] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "maincell", for: indexPath) as! mainCell
        cell.lblTieuDe.text = data[indexPath.row].des
        var a = data[indexPath.row].src!
        print(a)
        let url = NSURL(string: a)
        let data1 = NSData(contentsOf: url as! URL)
        cell.imageView?.image = UIImage(data: data1 as! Data)
        //cell.time.text = data[indexPath.row].create_time
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let a = data[indexPath.row].service_id
        
            let chitietcongviec = storyboard?.instantiateViewController(withIdentifier: "play") as! Play
            chitietcongviec.order = data[indexPath.row]
            
            self.present(chitietcongviec, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request("http://congtymienbac.com.vn/getdstheloai.php?url=https://hentaiz.net/category/big-boobs",headers: headers).responseJSON {(response) in
            
            let Value = response.result.value as! NSDictionary
           
            
            
                let res = Value["response"] as! [[String: Any]]
                self.data.removeAll()
                for item in res{
                    print("===========================================")
                   
                    do{
                        
                            let jsonData = try? JSONSerialization.data(withJSONObject: item, options: [])
                            let jsonString:String = String(data: jsonData!, encoding: .utf8)!
                            print("jsonString:",jsonString)
                            let order = try JSONDecoder().decode(Order.self, from: jsonString.data(using: .utf8)!)
                            self.data.append(order)
                        
                    }catch let e{
                        print("error",e)
                    }
                    
                    print("===========================================")
                }
                
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
                
            }
            
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

