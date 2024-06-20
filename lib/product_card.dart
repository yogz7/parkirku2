import 'package:flutter/material.dart';
// import '';
// import 'datail_page.dart';
// import 'products.dart';
import 'package:parkirku/product.dart';
import 'package:parkirku/detail_page.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.products, required double width});
  final Products products;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) {
              return DetailPage(products: products);
            }),
          ),
        );
      },
      child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                products.namaProduk,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(products.hargaProduk),
            ],
          )),
    );
  }
}
