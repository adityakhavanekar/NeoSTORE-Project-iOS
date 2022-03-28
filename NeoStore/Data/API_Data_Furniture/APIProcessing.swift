//
//  APIProcessing.swift
//  NeoStore
//
//  Created by Neosoft on 13/12/21.
//

import Foundation
import UIKit

class Api_strings{
    var urls = [ "http://staging.php-dev.in:8844/trainingapp/api/products/getList?product_category_id=1",
                 "http://staging.php-dev.in:8844/trainingapp/api/products/getList?product_category_id=2",
                 "http://staging.php-dev.in:8844/trainingapp/api/products/getList?product_category_id=3",
                 "http://staging.php-dev.in:8844/trainingapp/api/products/getList?product_category_id=4"]
}

class APIProcessing{
    
    //Get Req
    var furListData = [FurListData]()
    func jsonParse(url:String,completed: @escaping () -> ()){
        guard let url = URL(string: url)else{return}
        let session = URLSession.shared
        session.dataTask(with: url){(data,response,error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do{
                    let pdata = try
                        JSONDecoder().decode(FurData.self, from:data)
                    self.furListData = pdata.data
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print(error)
                }
            }
        }.resume()
    }
}


//MARK:- API Post

var regSuccess:Int?
class ApiService
{
    static func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }

    static func callPost(url:URL, params:[String:Any], finish: @escaping ((message:String, data:Data?)) -> Void)
    {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let postString = self.getPostString(params: params)
        request.httpBody = postString.data(using: .utf8)

        var result:(message:String, data:Data?) = (message: "Fail", data: nil)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let httpResponse = response as! HTTPURLResponse
            print(type(of: httpResponse.statusCode))
            print(httpResponse.statusCode)
            
            if(error != nil)
            {
                result.message = "Fail Error not null : \(error.debugDescription)"
            }
            else
            {
                result.message = "Success"
                result.data = data
                print(response!)
            }
            finish(result)
        }
        task.resume()
    }
}



//MARK:- Fetch User Details Get
class APIProcessingUserDetails{
    
    var userAcessToken = UserDefaults.standard.string(forKey: "userAcessToken")as Any
    //Get Req
    var userListData = [UserListData]()
    var userDetailData = [UserDetailData]()
    func jsonParse(url:String,completed: @escaping () -> ()){
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue((userAcessToken as! String), forHTTPHeaderField: "access_token")
        
        let session = URLSession.shared
        session.dataTask(with: request){(data,response,error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do{
                    let pdata = try
                        JSONDecoder().decode(UserDataResponse.self, from:data)
                    self.userDetailData = [pdata.data]
                    self.userListData = [pdata.data.user_data]
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print(error)
                }
            }
        }.resume()
    }
}
// API Processing Update Users and add to cart

class ApiServiceUpdateUserDetails{
    static func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }

    static func callPost(url:URL,access_token:String, params:[String:Any], finish: @escaping ((message:String, data:Data?)) -> Void)
    {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(access_token, forHTTPHeaderField: "access_token")
        let postString = self.getPostString(params: params)
        request.httpBody = postString.data(using: .utf8)

        var result:(message:String, data:Data?) = (message: "Fail", data: nil)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let httpResponse = response as! HTTPURLResponse
            print(type(of: httpResponse.statusCode))
            print(httpResponse.statusCode)
            if(error != nil)
            {
                result.message = "Fail Error not null : \(error.debugDescription)"
            }
            else
            {
                result.message = "Success"
                result.data = data
                print(response!)
            }
            finish(result)
        }
        task.resume()
    }
}
// MARK:- my cart

class APIProcessingMyCartDetails{
    
    var userAcessToken = UserDefaults.standard.string(forKey: "userAcessToken")as Any
    //Get Req
    var cartResponse = 0
    var response = 0
    var cartResponseData = [CartResponseData]()
    var cartProductData = [CartProductData]()
    
    func jsonParse(url:String,completed: @escaping () -> ()){
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue((userAcessToken as! String), forHTTPHeaderField: "access_token")
        
        let session = URLSession.shared
        session.dataTask(with: request){(data,response,error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do{
                    let pdata = try
                        JSONDecoder().decode(CartResponse.self, from:data)
                    self.response = pdata.count
                    print(response)
                    self.cartResponse = pdata.total
                    self.cartResponseData = pdata.data
                    self.cartProductData = [pdata.data[0].product]
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print(error)
                }
            }
        }.resume()
    }
}


// MARK:- My Orders
class APIProcessingMyOrdersDetails{
    
    var userAcessToken = UserDefaults.standard.string(forKey: "userAcessToken")as Any
    //Get REQ
    var orderResponseData = [OrderListResponse]()

    func jsonParse(url:String,completed: @escaping () -> ()){
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue((userAcessToken as! String), forHTTPHeaderField: "access_token")
        
        let session = URLSession.shared
        session.dataTask(with: request){(data,response,error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do{
                    let pdata = try
                        JSONDecoder().decode(OrderResponse.self, from:data)
                    
                    self.orderResponseData = pdata.data
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print(error)
                }
            }
        }.resume()
    }
}

//MARK:- Place Order Post


class ApiServicePlaceOrder{
    static func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }

    static func callPost(url:URL,access_token:String, params:[String:Any], finish: @escaping ((message:String, data:Data?)) -> Void)
    {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(access_token, forHTTPHeaderField: "access_token")
        let postString = self.getPostString(params: params)
        request.httpBody = postString.data(using: .utf8)

        var result:(message:String, data:Data?) = (message: "Fail", data: nil)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let httpResponse = response as! HTTPURLResponse
            print(type(of: httpResponse.statusCode))
            print(httpResponse.statusCode)
            if(error != nil)
            {
                result.message = "Fail Error not null : \(error.debugDescription)"
            }
            else
            {
                result.message = "Success"
                result.data = data
                print(response!)
            }
            finish(result)
        }
        task.resume()
    }
}

//MARK:- Get Order Detail Data
class APIProcessingOrderDetails{
    
    var userAcessToken = UserDefaults.standard.string(forKey: "userAcessToken")as Any
    //Get Req
    var orderDetails = [OrderListData]()
    var orderDetailsFull = [OrderDetailData]()
    
    func jsonParse(url:URL,completed: @escaping () -> ()){
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue((userAcessToken as! String), forHTTPHeaderField: "access_token")
        
        let session = URLSession.shared
        session.dataTask(with: request){(data,response,error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do{
                    let pdata = try
                        JSONDecoder().decode(OrderDetailResponse.self, from:data)
                    self.orderDetails = [pdata.data]
                    self.orderDetailsFull = pdata.data.order_details
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print(error)
                }
            }
        }.resume()
    }
}

// MARK:- Change Password Post

class ApiServicePostPassword{
    static func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }

    static func callPost(url:URL,access_token:String, params:[String:Any], finish: @escaping ((message:String, data:Data?)) -> Void)
    {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(access_token, forHTTPHeaderField: "access_token")
        let postString = self.getPostString(params: params)
        request.httpBody = postString.data(using: .utf8)

        var result:(message:String, data:Data?) = (message: "Fail", data: nil)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let httpResponse = response as! HTTPURLResponse
            print(type(of: httpResponse.statusCode))
            print(httpResponse.statusCode)
            if(error != nil)
            {
                result.message = "Fail Error not null : \(error.debugDescription)"
            }
            else
            {
                result.message = "Success"
                result.data = data
                print(response!)
            }
            finish(result)
        }
        task.resume()
    }
}
