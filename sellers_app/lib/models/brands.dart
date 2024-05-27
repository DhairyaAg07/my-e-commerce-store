import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Brands
{
  String? brandID;
  String? brandInfo;
  String? brandTitle;
  Timestamp? publishDate;
  String? sellerUID;
  String? status;
  String? thumbnailUrl;
  
  Brands({
      this.brandID,
      this.brandInfo,
      this.brandTitle,
      this.publishDate,
      this.sellerUID,
      this.status,
      this.thumbnailUrl,
  });
  
  Brands.fromJson(
      Map<String,dynamic> json)
  {
    brandID=json["brandId"];
    brandInfo=json["brandInfo"];
    brandTitle=json["brandTitle"];
    publishDate=json["publishDate"];
    sellerUID=json["sellerUID"];
    status=json["status"];
    thumbnailUrl=json["thumbnailUrl"];
  }
}