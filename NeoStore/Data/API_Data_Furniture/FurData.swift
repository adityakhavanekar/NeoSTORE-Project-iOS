//
//  FurData.swift
//  NeoStore
//
//  Created by Neosoft on 13/12/21.
//

import Foundation


//MARK:- GET Furniture
struct FurData: Codable{
    var data:[FurListData]
}

struct FurListData: Codable{
    var id: Int
    var name: String
    var producer: String
    var product_images: String
    var cost: Int
    var rating: Int
}

struct FurDetailDataData:Codable{
    var data: FurDetailData
}

struct FurDetailData: Codable{
    var id: Int
    var name: String
    var product_category_id: Int
    var producer: String
    var description: String
    var cost: Int
    var rating: Int
    var product_images:[FurDetailImages]
}

struct FurDetailImages: Codable{
    var id: Int
    var product_id: Int
    var image: String
}

//MARK:- GET User Details
struct UserDataResponse: Codable{
    var data:UserDetailData
}
struct UserDetailData: Codable{
    var user_data: UserListData
    var total_carts: Int
    var total_orders: Int
}
struct UserListData:Codable{
    var first_name:String
    var last_name:String
    var email:String
    var phone_no:String
    var profile_pic:String?
    var dob:String?
}

//MARK:- Post Update User Details
struct UpdateUserDataResponse:Codable{
    var status: Int
    var data:UpdateUserDetailData
    var message:String
    var user_msg: String
}
struct UpdateUserDetailData:Codable{
    var first_name:String
    var last_name:String
    var email:String
    var dob: String?
    var profile_pic:String?
    var phone_no:String
}

//MARK:- Post Structs

//MARK: Register Post
struct RegisterResponse:Codable {
    var status: Int
    var message:String
    var data:RegisterResponseData
}

struct RegisterResponseData:Codable {
    var access_token:String
    var first_name : String
    var last_name : String
}

//MARK: Login Post
struct LoginResponse:Codable{
    var status: Int
    var message: String
    var data: LoginResponseData
}
struct LoginResponseData:Codable{
    var access_token: String
    var first_name:String
    var last_name:String
}
//MARK:- Add to Cart Post

struct AddToCartResponse:Codable{
    var status:Int
    var data: Bool
    var total_carts:Int
    var message:String
    var user_msg:String
}
//MARK:- Rating

struct Rating:Codable{
    var status:Int
    var message:String
    var user_msg:String
}

//MARK:- My Cart Get

struct CartResponse:Codable{
    var status:Int
    var data:[CartResponseData]
    var count: Int
    var total:Int
    
}

struct CartResponseData:Codable{
    var id:Int
    var product_id:Int
    var quantity:Int
    var product:CartProductData
    
    
}

struct CartProductData:Codable{
    var id:Int
    var name:String
    var cost:Int
    var product_category:String
    var product_images:String
    var sub_total:Int
}


//MARK:- OrderList
struct OrderResponse:Codable{
    var data:[OrderListResponse]
}

struct OrderListResponse:Codable{
    var id:Int
    var cost:Int
    var created:String
}

//MARK:- Place Order

struct OrderPlaced:Codable{
    var status: Int
    var message:String
    var user_msg:String
}

//MARK:- Order Detail Get

struct OrderDetailResponse:Codable{
    var status: Int
    var data : OrderListData
}
struct OrderListData:Codable{
    var id:Int
    var cost: Int
    var order_details: [OrderDetailData]
}
struct OrderDetailData:Codable{
    var id:Int
    var order_id:Int
    var product_id:Int
    var quantity: Int
    var total: Int
    var prod_name:String
    var prod_cat_name:String
    var prod_image:String
}

//MARK:- RESET Password

struct PasswordResponse:Codable{
    var status:Int
    var message:String
    var user_msg:String
}


//MARK:- FORGOT PASS

struct forgotPassResponse:Codable{
    var status: Int
    var message: String
    var user_msg: String
}
