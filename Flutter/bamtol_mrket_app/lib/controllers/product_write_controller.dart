import 'package:flutter/material.dart';

class ProductWriteController {
  // TextEditingControllers
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController locationController;

  // State variables
  String? selectedCategory;
  String? selectedStatus;
  List<String> selectedImages = [];
  String? selectedTradeLocation;
  bool canNegotiate = false;

  ProductWriteController() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    locationController = TextEditingController();
  }

  /// 모든 필드가 유효한지 확인
  bool isValid() {
    return titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        selectedCategory != null &&
        selectedTradeLocation != null;
  }

  /// 상품 데이터 생성
  Map<String, dynamic> getProductData() {
    return {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': titleController.text,
      'description': descriptionController.text,
      'price': double.tryParse(priceController.text) ?? 0,
      'category': selectedCategory,
      'status': selectedStatus ?? '판매중',
      'images': selectedImages,
      'location': selectedTradeLocation,
      'canNegotiate': canNegotiate,
      'createdAt': DateTime.now(),
    };
  }

  /// 컨트롤러 초기화
  void clear() {
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    locationController.clear();
    selectedCategory = null;
    selectedStatus = null;
    selectedImages = [];
    selectedTradeLocation = null;
    canNegotiate = false;
  }

  /// 리소스 해제
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    locationController.dispose();
  }
}
