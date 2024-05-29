import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Items
{
  String? brandID;
  String? itemID;
  String? itemInfo;
  String? itemTitle;
  String? longDescription;
  String? price;
  Timestamp? publishedDate;
  String? selleUID;
  String? sellerName;
  String? status;
  String? thumbnailUrl;
  
  
  Items(
  {
    this.brandID,
    this.itemID,
    this.itemInfo,
    this.itemTitle,
    this.longDescription,
    this.price,
    this.publishedDate,
    this.selleUID,
    this.sellerName,
    this.status,
    this.thumbnailUrl,
});
  
  
  Items.fromJson(Map<String, dynamic>json)
  {
    brandID=json["brandID"];
    itemID=json["itemID"];
    itemInfo=json["itemInfo"];
    itemTitle=json["itemTitle"];
    longDescription=json["longDescription"];
    price=json["price"];
    publishedDate=json["publishedDate"];
    selleUID=json["selleUID"];
    sellerName=json["sellerName"];
    status=json["status"];
    thumbnailUrl=json["thumbnailUrl"];
  }
}