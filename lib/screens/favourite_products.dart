import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class FavouriteProducts extends StatefulWidget {
  const FavouriteProducts({super.key});

  @override
  State<FavouriteProducts> createState() => _FavouriteProductsState();
}

class _FavouriteProductsState extends State<FavouriteProducts> {
  ProductRepository? _productRepository;
  List<Product>? _product;
  initialize() async {
    _product = await _productRepository?.getAll() ?? [];
    setState(() {
      _product = _product;
    });
  }

  @override
  void initState() {
    _productRepository = ProductRepository();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _product?.length ?? 0,
        itemBuilder: ((context, index) {
          return Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_product?[index].name ?? ''),
          ));
        }));
  }
}
