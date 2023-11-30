import 'dart:convert';
import 'dart:io'; //httpstatus.ok

import 'package:ecommerce/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final _baseUrl = 'https://plain-marbled-muskox.glitch.me/shoes';

  //
  Future<List> getAll() async {
    http.Response response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == HttpStatus.ok) {
      final List jsonResponse = json.decode(response.body);
      print(response.body);
      return jsonResponse.map((e) => Product.fromJson(e)).toList();
    }
    return [];
  }

  Future<List> getByName(String name) async {
    http.Response response =
        await http.get(Uri.parse('$_baseUrl?name_like=$name'));
    if (response.statusCode == HttpStatus.ok) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Product.fromJson(e)).toList();
    }
    return [];
  }
}
