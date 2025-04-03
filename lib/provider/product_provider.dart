import 'package:flutter/material.dart';
import '../model/product.dart';
import '../service/api_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String _searchQuery = "";

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  List<Product> get filteredProducts {
    if (_searchQuery.isEmpty) return _products;
    return _products
        .where((product) =>
            product.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await ApiService.fetchProducts();
    } catch (e) {
      print('Error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}