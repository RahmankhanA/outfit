import 'dart:math';

import 'package:get/get.dart';
import 'package:outfit/app/data/constant/assets_constant.dart';
import 'package:outfit/app/modules/home/models/outfit_model.dart';

class HomeController extends GetxController {
  List<OutFitModel> images = [];
  Random random = Random();
  List<String> categories = [
    'ALL CATEGORIES',
    'COATS',
    'SWEATERS',
    'TROUSERS',
    'SHIRT',
    'T-SHIRT',
    'SHORTS',
    'SHOES'
  ];

  List<OutFitModel> selectedImages = [];

  void handleOnTap({required OutFitModel data}) {

    if(data.isSelected){
      selectedImages.remove(data);
      data.isSelected=false;
    }
    else{
      selectedImages.add(data);
      data.isSelected=true;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    initializedImageList();
  }

  void initializedImageList() {
    for (var element in AssetsConstant.images) {
      images.add(OutFitModel(url: element));
    }
  }
}
