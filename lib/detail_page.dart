import 'package:flutter/material.dart';
// import 'package:Api/14/products.dart';
// import 'products.dart';
import 'package:parkirku/product.dart';


class DetailPage extends StatelessWidget {
  final Products products;
  const DetailPage({super.key, required this.products});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'id: ${products.idProduk}',
        ),
        Text('Nama: ${products.namaProduk}'),
        const SizedBox(
          height: 20,
        ),
        const Text('Harga: '),
        Text(products.hargaProduk)
      ])),
    );
  }
}
