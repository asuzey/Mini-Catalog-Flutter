import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import '../models/products_model.dart';

// urunleri api den ceken servis
class ApiService {
  static const String productsUrl = 'https://wantapi.com/products.php';
  static const String bannerUrl = 'https://wantapi.com/assets/banner.png';
  static const String localJsonPath = 'assets/data/products.json';

  // once api yi dener olmazsa local json
  Future<ProductsModel> fetchProducts() async {
    try {
      return await fetchFromApi();
    } catch (e) {
      log('api hatasi local json kullaniliyor $e');
      return await fetchFromAsset();
    }
  }

  // http get ile istek atiyoruz
  Future<ProductsModel> fetchFromApi() async {
    final response = await http
        .get(Uri.parse(productsUrl))
        .timeout(const Duration(seconds: 10));

    // 200 ise basarili
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ProductsModel.fromJson(data);
    } else {
      throw Exception('Failed to load products');
    }
  }

  // assets icindeki json u okuyoruz
  Future<ProductsModel> fetchFromAsset() async {
    final jsonString = await rootBundle.loadString(localJsonPath);
    final data = jsonDecode(jsonString);
    return ProductsModel.fromJson(data);
  }
}
