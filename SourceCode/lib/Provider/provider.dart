import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';


class DataProvider extends ChangeNotifier
{

  String bannerTitle = "";
  List bannerImages = [];
  double rating = 0.0;
  String description = "";
  List details = [];
  List popularTreks = [];

  bool isLoading = false;

  Future<void> readJson()async{

    isLoading = true;
    notifyListeners();

    final String response = await rootBundle.loadString("assets/data.json");
    final data = await json.decode(response);

    bannerTitle =  data["bannerTitle"];
    bannerImages =  data["bannerImages"];
    rating = data["rating"];
    description = data["description"];
    details = data["details"];
    popularTreks = data["popularTreks"];

    isLoading = false;
    notifyListeners();

  }
}