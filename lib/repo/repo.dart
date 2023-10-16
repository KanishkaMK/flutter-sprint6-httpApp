import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_app/models/product_model.dart';

class ApiRepo {
  Future<List<Products>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Products>((json) => Products.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<http.Response> createProduct() async {
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': 'product name',
        'price': 'product price',
        'description': 'product description',
        'category': 'product category',
        'image': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
        'rating': {"rate": 3.9, "count": 120}
      }),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to create Product.');
    }
  }

  Future<http.Response> deleteProduct(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://fakestoreapi.com/products/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.request);
    return response;
  }

  Future<http.Response> updateProducts(
      String title, String id, String price) async {
    final http.Response response = await http.put(
      Uri.parse('https://fakestoreapi.com/products/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'title': title, 'price': price}),
    );
    print(response.body);
    return response;
  }
}