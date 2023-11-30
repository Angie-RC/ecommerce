import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  final List products;
  const ProductList({super.key, required this.products});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.products.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return _ProductItem(product: widget.products[index]);
      },
    );
  }
}

class _ProductItem extends StatefulWidget {
  final Product product;
  const _ProductItem({super.key, required this.product});

  @override
  State<_ProductItem> createState() => __ProductItemState();
}

class __ProductItemState extends State<_ProductItem> {
  bool isFavorite = false;
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    isFavorite = await ProductRepository().isFavorite(widget.product);
    if (mounted) {
      setState(() {
        isFavorite = isFavorite;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final icon =
        Icon(Icons.favorite, color: isFavorite ? Colors.cyan : Colors.black);
    final product = widget.product;
    
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: Stack(children: [
            Image.network(widget.product.images[0]),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: icon,
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  isFavorite
                      ? ProductRepository().insert(product)
                      : ProductRepository().delete(product);
                  print(isFavorite);
                  
                },
              ),
            ),
          ]),
        ),
        Text(widget.product.name),
      ],
    );
  }
}
