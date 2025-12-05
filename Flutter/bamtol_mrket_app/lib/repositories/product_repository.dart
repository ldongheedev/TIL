import 'package:flutter/foundation.dart';

class ProductRepository {
  static final ProductRepository _instance = ProductRepository._internal();

  factory ProductRepository() {
    return _instance;
  }

  ProductRepository._internal();

  // 로컬 저장소 (Firebase 대신 사용)
  final List<Map<String, dynamic>> _products = [];

  /// 상품 저장
  Future<bool> saveProduct(Map<String, dynamic> product) async {
    try {
      // 로컬 저장
      _products.add(product);
      debugPrint('✅ 상품 저장 완료: ${product['title']}');
      return true;
    } catch (e) {
      debugPrint('❌ 상품 저장 실패: $e');
      return false;
    }
  }

  /// 모든 상품 조회
  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return _products;
    } catch (e) {
      debugPrint('❌ 상품 조회 실패: $e');
      return [];
    }
  }

  /// 상품 업데이트
  Future<bool> updateProduct(String id, Map<String, dynamic> product) async {
    try {
      final index = _products.indexWhere((p) => p['id'] == id);
      if (index != -1) {
        _products[index] = product;
        debugPrint('✅ 상품 수정 완료: $id');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('❌ 상품 수정 실패: $e');
      return false;
    }
  }

  /// 상품 삭제
  Future<bool> deleteProduct(String id) async {
    try {
      _products.removeWhere((p) => p['id'] == id);
      debugPrint('✅ 상품 삭제 완료: $id');
      return true;
    } catch (e) {
      debugPrint('❌ 상품 삭제 실패: $e');
      return false;
    }
  }

  /// 카테고리별 상품 조회
  Future<List<Map<String, dynamic>>> getProductsByCategory(
    String category,
  ) async {
    try {
      return _products.where((p) => p['category'] == category).toList();
    } catch (e) {
      debugPrint('❌ 카테고리별 상품 조회 실패: $e');
      return [];
    }
  }
}
