import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com/products';

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['products'];
      return body.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<Product> fetchProductDetails(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product details');
    }
  }
}